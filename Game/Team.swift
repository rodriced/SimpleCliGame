//
//  Team.swift
//  Game
//
//  Created by Rodolphe Desruelles on 16/02/2022.
//

class Team {
    static let emojis = "âšđģâšđŧâšđŋâšī¸ââī¸âšđŊââī¸âšđŋââī¸âšđģââī¸âšđŊââī¸"
    
    let playerNum: Int
    var members: [GameCharacter]
    
    init(_ num: Int) {
        playerNum = num
        members = [GameCharacter]()
    }
    
    func add(_ character: GameCharacter) {
        members.append(character)
    }
    
    var isAlive: Bool {
        return members.contains { $0.isAlive }
    }
    
    var aliveMembers: [GameCharacter] {
        return members.filter { $0.isAlive }
    }
    
    func hasMemberWithName(_ name: String) -> Bool {
        members.contains { $0.name.lowercased() == name.lowercased() }
    }
    
    var description: String {
        return members.reduce("") { $0+"\n"+$1.description }
    }
}
