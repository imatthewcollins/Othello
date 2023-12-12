//
//  GameViewModel.swift
//  Othello
//
//  Created by Collins, Matthew - MC on 12/12/2023.
//

import Foundation

class GameViewModel: ObservableObject {
    static let shared = GameViewModel()
    
    @Published var game: Game
    
    private init() {
        self.game = Game()
    }
}
