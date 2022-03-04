//
//  Weapon.swift
//  Game
//
//  Created by Rodolphe Desruelles on 16/02/2022.
//

class Weapon {
    let damages: Int

    init(damages: Int) {
        self.damages = damages
    }

    // human readable informations from the weapon
    var description: String {
        let type = String(describing: Self.self)
        return "\(type.padding(toLength: 6, withPad: " ", startingAt: 0))(\(String(format: "%2d", damages)))"
    }
}

class Sword: Weapon {
    init() {
        super.init(damages: 10)
    }
}

class Bow: Weapon {
    init() {
        super.init(damages: 6)
    }
}

class Dagger: Weapon {
    init() {
        super.init(damages: 3)
    }
}
