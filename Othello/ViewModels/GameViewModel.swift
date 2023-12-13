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
    
    
    
    
    
    private func findValidMoves(for player: Piece) -> [(Int, Int)] {
        let board = self.game.board
        var validMoves = [(Int, Int)]()
                           
        for row in 0..<self.game.getBoardSize() {
            for col in 0..<self.game.getBoardSize() {
                if board[row][col].currentPiece == nil {
                    
                    // check north
                    if row - 1 >= 0 && board[row-1][col].currentPiece != nil && board[row-1][col].currentPiece != currentPlayer {
                        if checkDirection(row: row-1, col: col, rowDirection: -1, colDirection: 0, currentPlayer: currentPlayer!) {
                            print("Valid move at \(row),\(col)")
                            board[row][col].setValidMove()
                            validMoves.append((row, col))
                        }
                    }
                    
                    
                    // check north east
                    if row - 1 >= 0 && board[row-1][col].currentPiece != nil && board[row-1][col].currentPiece != currentPlayer
                    && col + 1 < self.game.getBoardSize() && board[row][col+1].currentPiece != nil && board[row][col+1].currentPiece != currentPlayer {
                        if checkDirection(row: row-1, col: col+1, rowDirection: -1, colDirection: 1, currentPlayer: currentPlayer!) {
                            print("Valid move at \(row),\(col)")
                            board[row][col].setValidMove()
                            validMoves.append((row, col))
                        }
                    }
                    
                    
                    // check east
                    if col + 1 < self.game.getBoardSize() && board[row][col+1].currentPiece != nil && board[row][col+1].currentPiece != currentPlayer {
                        if checkDirection(row: row, col: col+1, rowDirection: 0, colDirection: 1, currentPlayer: currentPlayer!) {
                            print("Valid move at \(row),\(col)")
                            board[row][col].setValidMove()
                            validMoves.append((row, col))
                        }
                    }
                    
                    
                    // check south east
                    if row + 1 < self.game.getBoardSize() && board[row+1][col].currentPiece != nil && board[row+1][col].currentPiece != currentPlayer &&
                        col + 1 < self.game.getBoardSize() && board[row][col+1].currentPiece != nil && board[row][col+1].currentPiece != currentPlayer {
                        if checkDirection(row: row+1, col: col+1, rowDirection: 1, colDirection: 1, currentPlayer: currentPlayer!) {
                            print("Valid move at \(row),\(col)")
                            board[row][col].setValidMove()
                            validMoves.append((row, col))
                        }
                    }
                    
                    
                    
                    // check south
                    if row + 1 < self.game.getBoardSize() && board[row+1][col].currentPiece != nil && board[row+1][col].currentPiece != currentPlayer {
                        if checkDirection(row: row+1, col: col, rowDirection: 1, colDirection: 0, currentPlayer: currentPlayer!) {
                            print("Valid move at \(row),\(col)")
                            board[row][col].setValidMove()
                            validMoves.append((row, col))
                        }
                    }
                    
                    
                    // check south west
                    if row + 1 < self.game.getBoardSize() && board[row+1][col].currentPiece != nil && board[row+1][col].currentPiece != currentPlayer &&
                        col - 1 >= 0 && board[row][col-1].currentPiece != nil && board[row][col-1].currentPiece != currentPlayer {
                        if checkDirection(row: row+1, col: col-1, rowDirection: 1, colDirection: -1, currentPlayer: currentPlayer!) {
                            print("Valid move at \(row),\(col)")
                            board[row][col].setValidMove()
                            validMoves.append((row, col))
                        }
                    }
                    
                    
                    
                    // check west
                    if col - 1 >= 0 && board[row][col-1].currentPiece != nil && board[row][col-1].currentPiece != currentPlayer {
                        if checkDirection(row: row, col: col-1, rowDirection: 0, colDirection: -1, currentPlayer: currentPlayer!) {
                            print("Valid move at \(row),\(col)")
                            board[row][col].setValidMove()
                            validMoves.append((row, col))
                        }
                    }
                    
                    
                    // check north west
                    if row - 1 >= 0 && board[row-1][col].currentPiece != nil && board[row-1][col].currentPiece != currentPlayer &&
                        col - 1 >= 0 && board[row][col-1].currentPiece != nil && board[row][col-1].currentPiece != currentPlayer {
                        if checkDirection(row: row-1, col: col-1, rowDirection: -1, colDirection: -1, currentPlayer: currentPlayer!) {
                            print("Valid move at \(row),\(col)")
                            board[row][col].setValidMove()
                            validMoves.append((row, col))
                        }
                    }
                }
            }
        }
        return validMoves
    }
    
    
    
    private func resetValidMoves(for moves: [(Int, Int)]) {
        for move in moves {
            self.game.board[move.0][move.1].isValidMove = false
        }
    }
    
    
    
    
    func startGame() {
        currentPlayer = .black
        
        for _ in 0..<10 {
            let validMoves = self.findValidMoves(for: self.currentPlayer!)
            self.makeMove(for: self.currentPlayer!, with: validMoves)
            self.resetValidMoves(for: validMoves)
            self.currentPlayer = self.currentPlayer == .black ? .white : .black
        }
        let validMoves = self.findValidMoves(for: self.currentPlayer!)
        
        // while game is not over
        // find moves for current player
        // wait for player to move
        // switch to other player
    }
    
    
    
    
    
    func makeMove(for player: Piece, with validMove: [(Int, Int)]) {
        var bestScore = -500
        var bestMove = validMove[0]
        for move in validMove {
            let score = evaluateBoard(row: move.0, col: move.1)
            if score > bestScore {
                bestScore = score
                bestMove = move
            }
        }
        
        self.game.board[bestMove.0][bestMove.1].currentPiece = player
        self.flipSandwiches(row: bestMove.0, col: bestMove.1)
    }
    
    
    
    
    private func evaluateBoard(row: Int, col: Int) -> Int {
        return weights[row][col]
    }
    
    
    
    
    
    private func flipInDirection(row: Int, col: Int, rowDirection: Int, colDirection: Int) {
        var currentRow = row
        var currentColumn = col
        while self.game.board[currentRow][currentColumn].currentPiece != currentPlayer {
            self.game.board[currentRow][currentColumn].currentPiece = currentPlayer
            currentRow += rowDirection
            currentColumn += colDirection
        }
    }
    
    
    
    
    
    
    private func flipSandwiches(row: Int, col: Int) {
        // check north
        if row - 1 >= 0 && self.game.board[row-1][col].currentPiece != nil && self.game.board[row-1][col].currentPiece != currentPlayer {
            if checkDirection(row: row-1, col: col, rowDirection: -1, colDirection: 0, currentPlayer: currentPlayer!) {
                print("Valid sandwich at \(row),\(col)")
                flipInDirection(row: row-1, col: col, rowDirection: -1, colDirection: 0)
            }
        }
        
        
        // check north east
        if row - 1 >= 0 && self.game.board[row-1][col].currentPiece != nil && self.game.board[row-1][col].currentPiece != currentPlayer
            && col + 1 < self.game.getBoardSize() && self.game.board[row][col+1].currentPiece != nil && self.game.board[row][col+1].currentPiece != currentPlayer {
            if checkDirection(row: row-1, col: col+1, rowDirection: -1, colDirection: 1, currentPlayer: currentPlayer!) {
                print("Valid sandwich at \(row),\(col)")
                flipInDirection(row: row-1, col: col+1, rowDirection: -1, colDirection: 1)
            }
        }
        
        
        // check east
        if col + 1 < self.game.getBoardSize() && self.game.board[row][col+1].currentPiece != nil && self.game.board[row][col+1].currentPiece != currentPlayer {
            if checkDirection(row: row, col: col+1, rowDirection: 0, colDirection: 1, currentPlayer: currentPlayer!) {
                print("Valid sandwich at \(row),\(col)")
                flipInDirection(row: row, col: col+1, rowDirection: 0, colDirection: 1)
            }
        }
        
        
        // check south east
        if row + 1 < self.game.getBoardSize() && self.game.board[row+1][col].currentPiece != nil && self.game.board[row+1][col].currentPiece != currentPlayer &&
            col + 1 < self.game.getBoardSize() && self.game.board[row][col+1].currentPiece != nil && self.game.board[row][col+1].currentPiece != currentPlayer {
            if checkDirection(row: row+1, col: col+1, rowDirection: 1, colDirection: 1, currentPlayer: currentPlayer!) {
                print("Valid sandwich at \(row),\(col)")
                flipInDirection(row: row+1, col: col+1, rowDirection: 1, colDirection: 1)
            }
        }
        
        
        
        // check south
        if row + 1 < self.game.getBoardSize() && self.game.board[row+1][col].currentPiece != nil && self.game.board[row+1][col].currentPiece != currentPlayer {
            if checkDirection(row: row+1, col: col, rowDirection: 1, colDirection: 0, currentPlayer: currentPlayer!) {
                print("Valid sandwich at \(row),\(col)")
                flipInDirection(row: row+1, col: col, rowDirection: 1, colDirection: 0)
            }
        }
        
        
        // check south west
        if row + 1 < self.game.getBoardSize() && self.game.board[row+1][col].currentPiece != nil && self.game.board[row+1][col].currentPiece != currentPlayer &&
            col - 1 >= 0 && self.game.board[row][col-1].currentPiece != nil && self.game.board[row][col-1].currentPiece != currentPlayer {
            if checkDirection(row: row+1, col: col-1, rowDirection: 1, colDirection: -1, currentPlayer: currentPlayer!) {
                print("Valid sandwich at \(row),\(col)")
                flipInDirection(row: row+1, col: col-1, rowDirection: 1, colDirection: -1)
            }
        }
        
        
        
        // check west
        if col - 1 >= 0 && self.game.board[row][col-1].currentPiece != nil && self.game.board[row][col-1].currentPiece != currentPlayer {
            if checkDirection(row: row, col: col-1, rowDirection: 0, colDirection: -1, currentPlayer: currentPlayer!) {
                print("Valid sandwich at \(row),\(col)")
                flipInDirection(row: row, col: col-1, rowDirection: 0, colDirection: -1)
            }
        }
        
        
        // check north west
        if row - 1 >= 0 && self.game.board[row-1][col].currentPiece != nil && self.game.board[row-1][col].currentPiece != currentPlayer &&
            col - 1 >= 0 && self.game.board[row][col-1].currentPiece != nil && self.game.board[row][col-1].currentPiece != currentPlayer {
            if checkDirection(row: row-1, col: col-1, rowDirection: -1, colDirection: -1, currentPlayer: currentPlayer!) {
                print("Valid sandwich at \(row),\(col)")
                flipInDirection(row: row-1, col: col-1, rowDirection: -1, colDirection: -1)
            }
        }
    }
    
    
}
