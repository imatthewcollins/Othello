//
//  Game.swift
//  Othello
//
//  Created by Collins, Matthew - MC on 12/12/2023.
//

import Foundation

struct Game {
    private let boardSize = 8
    private var board: [[Square]]
    
    init() {
        self.board = Array(repeating: Array(repeating: Square(), count: self.boardSize), count: self.boardSize)
        self.board[3][3].currentPiece = .white
        self.board[3][4].currentPiece = .black
        self.board[4][3].currentPiece = .black
        self.board[4][4].currentPiece = .white
    }
    
    
    func getBoard() -> [[Square]] {
        return self.board
    }
}
