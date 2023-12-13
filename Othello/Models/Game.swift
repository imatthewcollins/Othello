//
//  Game.swift
//  Othello
//
//  Created by Collins, Matthew - MC on 12/12/2023.
//

import Foundation

class Game: ObservableObject {
    
    private let boardSize = 8
    @Published var board: [[Square]]
    
    init() {
        self.board = [[Square]]()
        for _ in 0..<self.boardSize {
            var row = [Square]()
            for _ in 0..<self.boardSize {
                row.append(Square())
            }
            self.board.append(row)
        }
        
        self.board[3][3].currentPiece = .white
        self.board[3][4].currentPiece = .black
        self.board[4][3].currentPiece = .black
        self.board[4][4].currentPiece = .white
    }
    
    
    func getBoardSize() -> Int {
        return self.boardSize
    }
}
