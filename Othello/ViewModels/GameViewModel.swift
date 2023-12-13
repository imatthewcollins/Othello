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
    @Published var currentPlayer: Piece?
    
    
    
    
    private init() {
        self.game = Game()
    }
    
    
    
    
    
    private func checkDirection(row: Int, col: Int, rowDirection: Int, colDirection: Int, currentPlayer: Piece) -> Bool {
        // boundary check
        if row + rowDirection < 0 || col + colDirection < 0 || row + rowDirection >= self.game.getBoardSize() || col + colDirection >= self.game.getBoardSize() {
            return false
        }
        // empty check
        else if self.game.board[row+rowDirection][col+colDirection].currentPiece == nil {
            return false
        }
        // sandwich check
        else if self.game.board[row+rowDirection][col+colDirection].currentPiece == currentPlayer {
            return true
        }
        // keep checking
        else {
            return self.checkDirection(row: row+rowDirection, col: col+colDirection, rowDirection: rowDirection, colDirection: colDirection, currentPlayer: currentPlayer)
        }
    }
    
    
    
    
    
    private func findValidMoves(for player: Piece) {
        let board = self.game.board
        
        for row in 0..<self.game.getBoardSize() {
            for col in 0..<self.game.getBoardSize() {
                if board[row][col].currentPiece == nil {
                    
                    // check north
                    if row - 1 >= 0 && board[row-1][col].currentPiece != nil && board[row-1][col].currentPiece != currentPlayer {
                        if checkDirection(row: row-1, col: col, rowDirection: -1, colDirection: 0, currentPlayer: currentPlayer!) {
                            print("Valid move at \(row),\(col)")
                            board[row][col].setValidMove()
                        }
                    }
                    
                    
                    // check north east
                    if row - 1 >= 0 && board[row-1][col].currentPiece != nil && board[row-1][col].currentPiece != currentPlayer
                    && col + 1 < self.game.getBoardSize() && board[row][col+1].currentPiece != nil && board[row][col+1].currentPiece != currentPlayer {
                        if checkDirection(row: row-1, col: col+1, rowDirection: -1, colDirection: 1, currentPlayer: currentPlayer!) {
                            print("Valid move at \(row),\(col)")
                            board[row][col].setValidMove()
                        }
                    }
                    
                    
                    // check east
                    if col + 1 < self.game.getBoardSize() && board[row][col+1].currentPiece != nil && board[row][col+1].currentPiece != currentPlayer {
                        if checkDirection(row: row, col: col+1, rowDirection: 0, colDirection: 1, currentPlayer: currentPlayer!) {
                            print("Valid move at \(row),\(col)")
                            board[row][col].setValidMove()
                        }
                    }
                    
                    
                    // check south east
                    if row + 1 < self.game.getBoardSize() && board[row+1][col].currentPiece != nil && board[row+1][col].currentPiece != currentPlayer &&
                        col + 1 < self.game.getBoardSize() && board[row][col+1].currentPiece != nil && board[row][col+1].currentPiece != currentPlayer {
                        if checkDirection(row: row+1, col: col+1, rowDirection: 1, colDirection: 1, currentPlayer: currentPlayer!) {
                            print("Valid move at \(row),\(col)")
                            board[row][col].setValidMove()
                        }
                    }
                    
                    
                    
                    // check south
                    if row + 1 < self.game.getBoardSize() && board[row+1][col].currentPiece != nil && board[row+1][col].currentPiece != currentPlayer {
                        if checkDirection(row: row+1, col: col, rowDirection: 1, colDirection: 0, currentPlayer: currentPlayer!) {
                            print("Valid move at \(row),\(col)")
                            board[row][col].setValidMove()
                        }
                    }
                    
                    
                    // check south west
                    if row + 1 < self.game.getBoardSize() && board[row+1][col].currentPiece != nil && board[row+1][col].currentPiece != currentPlayer &&
                        col - 1 >= 0 && board[row][col-1].currentPiece != nil && board[row][col-1].currentPiece != currentPlayer {
                        if checkDirection(row: row+1, col: col-1, rowDirection: 1, colDirection: -1, currentPlayer: currentPlayer!) {
                            print("Valid move at \(row),\(col)")
                            board[row][col].setValidMove()
                        }
                    }
                    
                    
                    
                    // check west
                    if col - 1 >= 0 && board[row][col-1].currentPiece != nil && board[row][col-1].currentPiece != currentPlayer {
                        if checkDirection(row: row, col: col-1, rowDirection: 0, colDirection: -1, currentPlayer: currentPlayer!) {
                            print("Valid move at \(row),\(col)")
                            board[row][col].setValidMove()
                        }
                    }
                    
                    
                    // check north west
                    if row - 1 >= 0 && board[row-1][col].currentPiece != nil && board[row-1][col].currentPiece != currentPlayer &&
                        col - 1 >= 0 && board[row][col-1].currentPiece != nil && board[row][col-1].currentPiece != currentPlayer {
                        if checkDirection(row: row-1, col: col-1, rowDirection: -1, colDirection: -1, currentPlayer: currentPlayer!) {
                            print("Valid move at \(row),\(col)")
                            board[row][col].setValidMove()
                        }
                    }
                }
            }
        }
    }
    
    
    
    
    
    func startGame() {
        currentPlayer = .black
        
        self.findValidMoves(for: currentPlayer!)
        // while game is not over
        // find moves for current player
        // wait for player to move
        // switch to other player
    }
}
