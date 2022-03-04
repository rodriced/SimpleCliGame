//
//  Round.swift
//  Game
//
//  Created by Rodolphe Desruelles on 16/02/2022.
//

class Round {
    let roundNum: Int
    
    let mainTeam: Team
    let mainAliveTeam: [GameCharacter]

    let otherTeam: Team
    let otherAliveTeam: [GameCharacter]

    let otherTeamCountBeforeAction: Int
    
    enum ActionType: String, CaseIterable {
        case attack
        case heal
    }

    struct Infos {
        let roundNum: Int
        let origin: String
        let target: String
        let action: ActionType
        let wasKilled: Bool
    }

    init(_ roundNum: Int, with teams: [Team]) {
        self.roundNum = roundNum
        
        // We alternate players for each round : player 1 is the main player for odd rounds, and player 2 for the even ones
        let mainPlayerIndex = (roundNum + 1) % 2
        let otherPlayerIndex = roundNum % 2

        mainTeam = teams[mainPlayerIndex]
        mainAliveTeam = mainTeam.aliveMembers

        otherTeam = teams[otherPlayerIndex]
        otherAliveTeam = otherTeam.aliveMembers

        otherTeamCountBeforeAction = otherAliveTeam.count
    }
    
    // Display teams state at the beginning og the round
    func printTeamsState() {
        print(" - Your team:")
        for character in mainAliveTeam {
            print("     \(character.description)")
        }
        print(" - Other team (player #\(otherTeam.playerNum)):")
        for character in otherAliveTeam {
            print("     \(character.description)")
        }
    }
    
    func chooseActionOrigin() -> GameCharacter {
        if mainAliveTeam.count == 1 {
            let myLastCharacter = mainAliveTeam[0]
            print("⚠️ \(myLastCharacter.name) with 'attack' action is automaticaly chosen beacause it is the only possibility. ⚠️")
            print()
            return myLastCharacter
        } else {
            print("📝 Choose a character from your team")
            return Console.chooseInArray(mainAliveTeam, displayWith: { $0.name })
        }
    }
    
    func chooseActionType(_ possibleHealTargets: [GameCharacter], _ origin: GameCharacter) -> ActionType {
        // Special case : when there is no character to heal, no need to choose the action type
        if possibleHealTargets.isEmpty {
            return ActionType.attack
        } else {
            if origin.canHeal {
                print("📝 Choose an action")
                return Console.chooseInEnum(ActionType.self)
            } else {
                print()
                print("⚠️ \(origin.name) cannot heal so 'attack' action is automaticaly chosen. ⚠️")
                return ActionType.attack
            }
        }
    }
    
    func chooseActionTarget(_ actionType: ActionType, _ possibleAttackTargets: [GameCharacter], _ possibleHealTargets: [GameCharacter]) -> GameCharacter {
        switch actionType {
        case .attack:
            if possibleAttackTargets.count == 1 {
                let attackTarget = possibleAttackTargets[0]
                print("⚠️ The only character to attack is \(attackTarget.name). ⚠️")
                return attackTarget
            } else {
                print("📝 Choose a character to attack from the opposing team")
                return Console.chooseInArray(possibleAttackTargets, displayWith: { $0.name })
            }
                
        case .heal:
            if possibleHealTargets.count == 1 {
                let healTarget = possibleHealTargets[0]
                print("⚠️ The only character to heal is \(healTarget.name). ⚠️")
                return healTarget
            } else {
                print("📝 Choose a character to heal from your team")
                return Console.chooseInArray(possibleHealTargets, displayWith: { $0.name })
            }
        }
    }
    
    func executeAction(_ actionType: ActionType, _ origin: GameCharacter, _ target: GameCharacter) {
        let targetOldLifePoints = target.lifePoints
        
        switch actionType {
        case .attack:
            target.gettingAttacked(by: origin)
            
            let lossStatus = target.isAlive ?
                "lost \(targetOldLifePoints - target.lifePoints) life points which are now equal to \(target.lifePoints)"
                : "is dead 💀"
            
            print("⚔️ Attack result : \(target.name) \(lossStatus).")
            
        case .heal:
            target.gettingHealed(by: origin)
            
            let gainStatus = targetOldLifePoints == target.initialLifePoints ?
                "gained no life points because it was already at the maximum"
                : "gained \(target.lifePoints - targetOldLifePoints) life points that reached \(target.lifePoints)"
            
            print("💊 Heal result : \(target.name) \(gainStatus).")
        }
    }
    
    func go() -> Infos? {
        print()
        print("🎲 🏓 Round #\(roundNum) => player #\(mainTeam.playerNum) is playing. 🏓 🎲")
        print("-----------------------------------------------")
        print()
        printTeamsState()
        print()

        // In the following code, 'origin' is used for the character doing the 'action' (attacking or healing), 'target' if for the one that is target of the action
        
        // ------------------//
        // ORIGIN SELECTION //
        
        let origin = chooseActionOrigin()
        
        // Possible targets characters for healing and attacking
        let possibleHealTargets = mainAliveTeam.filter { $0 !== origin }
        let possibleAttackTargets = otherAliveTeam
        
        // -----------------------//
        // ACTION TYPE SELECTION //
        
        let actionType = chooseActionType(possibleHealTargets, origin)

        // ------------------//
        // TARGET SELECTION //
        
        let target = chooseActionTarget(actionType, possibleAttackTargets, possibleHealTargets)
        
        // ----------------------------//
        // ACTION EXECUTION AND RESULT //
        
        print("📝 Confirm your action: \(origin.name) is going to \(actionType) \(target.name)")
        if !Console.readYesNo(precededBy: "Ok ?") {
            print("Restarting current round.")
            return nil
        }
        
        print()
        
        executeAction(actionType, origin, target)

        // ------------------//
        // END OF THE ROUND //
        
        return Infos(roundNum: roundNum,
                     origin: origin.name,
                     target: target.name,
                     action: actionType,
                     wasKilled: otherTeam.aliveMembers.count < otherTeamCountBeforeAction)
    }
}
