//
//  GameCharacter.swift
//  Game
//
//  Created by Rodolphe Desruelles on 16/02/2022.
//

// Class is not named Character because it is used by swift for writen characters (and it is used here for emojis)
class GameCharacter {
    static let emojis = "🙋‍♀️🙋🏻‍♀️🙋🏼‍♀️🙋🏽‍♀️🙋🏾‍♀️🙋🏿‍♀️🙋🙋🏻🙋🏼🙋🏽🙋🏾🙋🏿🙋‍♂️🙋🏻‍♂️🙋🏼‍♂️🙋🏽‍♂️🙋🏾‍♂️🙋🏿‍♂️"

    let name: String
    var emoji: Character?
    var lifePoints: Int
    let initialLifePoints: Int
    let weapon: Weapon
    let abilityToHeal: Int

    init(name: String, initialLifePoints: Int, weapon: Weapon, abilityToHeal: Int) {
        self.name = name
        self.initialLifePoints = initialLifePoints
        lifePoints = initialLifePoints
        self.weapon = weapon
        self.abilityToHeal = abilityToHeal
    }

    var isAlive: Bool { lifePoints > 0 }

    var canHeal: Bool { abilityToHeal > 0 }

    // Compute new life points when the character is attacked
    func gettingAttacked(by attacker: GameCharacter) {
        lifePoints = max(0, lifePoints - attacker.weapon.damages)
    }

    // Compute new life points when the character is attacked
    func gettingHealed(by healer: GameCharacter) {
        lifePoints = min(initialLifePoints, lifePoints + healer.abilityToHeal)
    }

    // human readable informations from the character
    var description: String {
        let typeStr = "(\(String(describing: Self.self)))"
        return "\(emoji.map { "\($0) " } ?? "")\(name.padding(toLength: 10, withPad: " ", startingAt: 0)) \(typeStr.padding(toLength: 9, withPad: " ", startingAt: 0)) -> Life points: \(String(format: "%3d", lifePoints))/\(String(format: "%3d", initialLifePoints)), Weapon: \(weapon.description), Ability to heal: \(String(format: "%2d", abilityToHeal))"
    }
}

class Warrior: GameCharacter {
    init(name: String) {
        super.init(name: name, initialLifePoints: 80, weapon: Sword(), abilityToHeal: 0)
    }
}

class Elf: GameCharacter {
    init(name: String) {
        super.init(name: name, initialLifePoints: 100, weapon: Bow(), abilityToHeal: 5)
    }
}

class Clerc: GameCharacter {
    init(name: String) {
        super.init(name: name, initialLifePoints: 60, weapon: Dagger(), abilityToHeal: 8)
    }
}

enum GameCharacterType: String, CaseIterable {
    case warrior, elf, clerc

    func createCharacter(name: String) -> GameCharacter {
        switch self {
        case .warrior:
            return Warrior(name: name)
        case .elf:
            return Elf(name: name)
        case .clerc:
            return Clerc(name: name)
        }
    }
}
