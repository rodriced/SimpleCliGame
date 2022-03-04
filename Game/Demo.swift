//
//  Demo.swift
//  Game
//
//  Created by Rodolphe Desruelles on 16/02/2022.
//

enum Demo {
    static var data: ([Team], History) {
        let team1 = Team(1)
        let team2 = Team(2)

        let han = Warrior(name: "Han")
        let leia = Elf(name: "Leia")
        let luc = Clerc(name: "Luc")
        let bart = Clerc(name: "Bart")
        let bob = Clerc(name: "Bob")
        let bill = Clerc(name: "Bill")

        team1.members = [han, leia, luc]
        han.lifePoints = 22
        leia.lifePoints = 68

        team2.members = [bart, bob, bill]
        bart.lifePoints = 0
        bob.lifePoints = 0
        bill.lifePoints = 2

        let rounds = [
            Round.Infos(roundNum: 1, origin: "Han", target: "Bart", action: .attack, wasKilled: false),
            Round.Infos(roundNum: 2, origin: "Bart", target: "Han", action: .attack, wasKilled: false),
            Round.Infos(roundNum: 3, origin: "Han", target: "Bart", action: .attack, wasKilled: false),
            Round.Infos(roundNum: 4, origin: "Bart", target: "Han", action: .attack, wasKilled: false),
            Round.Infos(roundNum: 5, origin: "Han", target: "Bart", action: .attack, wasKilled: false),
            Round.Infos(roundNum: 6, origin: "Bart", target: "Han", action: .attack, wasKilled: false),
            Round.Infos(roundNum: 7, origin: "Han", target: "Bart", action: .attack, wasKilled: false),
            Round.Infos(roundNum: 8, origin: "Bart", target: "Han", action: .attack, wasKilled: false),
            Round.Infos(roundNum: 9, origin: "Han", target: "Bart", action: .attack, wasKilled: false),
            Round.Infos(roundNum: 10, origin: "Bart", target: "Han", action: .attack, wasKilled: false),
            Round.Infos(roundNum: 11, origin: "Han", target: "Bart", action: .attack, wasKilled: true),
            Round.Infos(roundNum: 12, origin: "Bob", target: "Han", action: .attack, wasKilled: false),
            Round.Infos(roundNum: 13, origin: "Han", target: "Bob", action: .attack, wasKilled: false),
            Round.Infos(roundNum: 14, origin: "Bob", target: "Han", action: .attack, wasKilled: false),
            Round.Infos(roundNum: 15, origin: "Han", target: "Bob", action: .attack, wasKilled: false),
            Round.Infos(roundNum: 16, origin: "Bob", target: "Han", action: .attack, wasKilled: false),
            Round.Infos(roundNum: 17, origin: "Han", target: "Bob", action: .attack, wasKilled: false),
            Round.Infos(roundNum: 18, origin: "Bob", target: "Han", action: .attack, wasKilled: false),
            Round.Infos(roundNum: 19, origin: "Han", target: "Bob", action: .attack, wasKilled: false),
            Round.Infos(roundNum: 20, origin: "Bob", target: "Han", action: .attack, wasKilled: false),
            Round.Infos(roundNum: 21, origin: "Han", target: "Bob", action: .attack, wasKilled: false),
            Round.Infos(roundNum: 22, origin: "Bob", target: "Han", action: .attack, wasKilled: false),
            Round.Infos(roundNum: 23, origin: "Leia", target: "Bob", action: .attack, wasKilled: false),
            Round.Infos(roundNum: 24, origin: "Bob", target: "Leia", action: .attack, wasKilled: false),
            Round.Infos(roundNum: 25, origin: "Leia", target: "Bob", action: .attack, wasKilled: true),
            Round.Infos(roundNum: 26, origin: "Bill", target: "Han", action: .attack, wasKilled: false),
            Round.Infos(roundNum: 27, origin: "Han", target: "Bill", action: .attack, wasKilled: false),
            Round.Infos(roundNum: 28, origin: "Bill", target: "Han", action: .attack, wasKilled: false),
            Round.Infos(roundNum: 29, origin: "Han", target: "Bill", action: .attack, wasKilled: false),
            Round.Infos(roundNum: 30, origin: "Bill", target: "Han", action: .attack, wasKilled: false),
            Round.Infos(roundNum: 31, origin: "Han", target: "Bill", action: .attack, wasKilled: false),
            Round.Infos(roundNum: 32, origin: "Bill", target: "Han", action: .attack, wasKilled: false),
            Round.Infos(roundNum: 33, origin: "Han", target: "Bill", action: .attack, wasKilled: false),
            Round.Infos(roundNum: 34, origin: "Bill", target: "Leia", action: .attack, wasKilled: false),
            Round.Infos(roundNum: 35, origin: "Leia", target: "Bill", action: .attack, wasKilled: false),
            Round.Infos(roundNum: 36, origin: "Bill", target: "Leia", action: .attack, wasKilled: false),
            Round.Infos(roundNum: 37, origin: "Leia", target: "Bill", action: .attack, wasKilled: false),
            Round.Infos(roundNum: 38, origin: "Bill", target: "Leia", action: .attack, wasKilled: false),
            Round.Infos(roundNum: 39, origin: "Han", target: "Bill", action: .attack, wasKilled: false),
        ]

        return ([team1, team2], History(rounds))
    }
}
