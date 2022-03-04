//
//  Game.swift
//  Game
//
//  Created by Rodolphe Desruelles on 16/02/2022.
//

import Foundation

class Game {
    static let numbersOfPlayers = 2
    static let numbersOfCharactersPerTeam = 3
    
    var currentRoundNum = 0
    
    var teams = [Team]()
    var history = History()
    
    // test if a name choosen for a new character is unique according to the other characters already created
    func isCharacterNameAlreadyUsed(_ name: String) -> Bool {
        teams.contains { $0.hasMemberWithName(name) }
    }
    
    // Player chooses a type in the console for a new character in his team
    func chooseCharacterType() -> GameCharacterType {
        print("Choose a type")
        return Console.chooseInEnum(GameCharacterType.self)
    }
    
    // Player chooses a name in the console for a new character in his team
    func chooseCharacterName() -> String {
        while true {
            let name = Console.readString(precededBy: "Choose a name -> ")
            if name.isEmpty {
                print("You did not type a name. Retry.")
                continue
            }
            if isCharacterNameAlreadyUsed(name) {
                print("Name already used. Retry.")
                continue
            }
            return name
        }
    }
    
    // Each player create his team before the fight !
    func createTeams() {
        for p in 1...Self.numbersOfPlayers {
            let team = Team(p)
            teams.append(team)

            let playerEmoji = Team.emojis.randomElement()!
            
            print()
            print("\(playerEmoji) Team for player #\(team.playerNum) \(playerEmoji)")
            for c in 1...Self.numbersOfCharactersPerTeam {
                let characterEmoji = GameCharacter.emojis.randomElement()!
                
                print()
                print("\(characterEmoji) Member #\(c)")
                let type = chooseCharacterType()
                let name = chooseCharacterName()
                
                let character = type.createCharacter(name: name)
                character.emoji = characterEmoji
                team.add(character)
            }
        }
    }
    
    // Display the content of each player's team
    func printTeams(onlyAlive: Bool = true) {
        for team in teams {
            print("Team for player #\(team.playerNum) :")
            for character in onlyAlive ? team.aliveMembers : team.members {
                print("- \(character.description)")
            }
        }
    }
    
    // It's the more important part of the play : taking turn, each team fights against the other, till victory !
    func fight() -> (winner: Team, looser: Team) {
        while true {
            currentRoundNum += 1

            let round = Round(currentRoundNum, with: teams)
            
            guard let roundInfos = round.go() else {
                continue
            }
            
            // Save some round infos in history for statistics
            history.add(roundInfos)
            
            // Fight ends (with a winner) only after an attack and if all characters of the other team are dead then
            if !round.otherTeam.isAlive {
                return (round.mainTeam, round.otherTeam)
            }
            
            // Pause between each round
            menu: while true {
                let cmd = Console.readString(precededBy: "⏯❓ Press Enter to go to the next round, else Q to quit -> ")
                switch cmd.lowercased() {
                case "q":
                    exit(0)
                case "":
                    break menu
                default:
                    break
                }
            }
        }
    }
    
    // Print some statistics at the end of the game
    func printStatistics() {
        print("The game lasted \(history.lastRoundNum) rounds.")
        print()
        
        print("Teams status :")
        print()
        printTeams(onlyAlive: false)
        print()
        
        history.rounds.filter { $0.wasKilled }
            .forEach { print("\($0.target) was killed by \($0.origin) at round #\($0.roundNum).") }
    }
    
    // Main function in game with all stages
    func play() {
        print("  ***************************************")
        print("  *               G A M E               *")
        print("  ***************************************")
        print()
        print()

        if Console.readYesNo(precededBy: "Generate demo environment ?") {
            (teams, history) = Demo.data
            currentRoundNum = history.lastRoundNum
            
            print()
            print("Demo environment generated")
            print()
        } else {
            
            print()
            print("🏁 PLAYERS INITIALIZATION 🏁")
            print("----------------------------")
            
            createTeams()
        }
        
        print()
        print("👤👤👤 TEAMS SUMMARY 👤👤👤")
        print("----------------------------")
        print()
        
        printTeams()
        
        print()
        print()
        print("⚡️ FIGHT ! ⚡️")
        print("-------------")
        print()
        
        let (winner, loser) = fight()
        
        print()
        print("☠️ All characters in the team of player #\(loser.playerNum) are dead. !!! ☠️")

        print()
        print("           ***************************************")
        print("           *                                     *")
        print("           *  🏆 PLAYER #\(winner.playerNum) IS THE WINNER !!! 🏆  *")
        print("           *                                     *")
        print("           ***************************************")
        
        print()
        print("📈 STATISTICS 📊")
        print("----------------")
        print()
        
        printStatistics()
    }
}
