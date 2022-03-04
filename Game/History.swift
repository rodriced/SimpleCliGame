//
//  History.swift
//  Game
//
//  Created by Rodolphe Desruelles on 16/02/2022.
//

class History {
    var rounds: [Round.Infos]
    
    init(_ rounds: [Round.Infos] = []) {
        self.rounds = rounds
    }
    
    var lastRoundNum: Int {
        rounds.last!.roundNum
    }
    
    func add(_ round: Round.Infos) {
        rounds.append(round)
    }
}
