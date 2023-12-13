//
//  Square.swift
//  Othello
//
//  Created by Collins, Matthew - MC on 12/12/2023.
//

import Foundation

class Square: ObservableObject {
    @Published var currentPiece: Piece?
    @Published var isValidMove: Bool
    
    init() {
        self.currentPiece = nil
        self.isValidMove = false
    }
    
    func setValidMove() {
        self.isValidMove = true
    }
}
