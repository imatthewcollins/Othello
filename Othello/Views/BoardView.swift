//
//  BoardView.swift
//  Othello
//
//  Created by Collins, Matthew - MC on 12/12/2023.
//

import SwiftUI

struct BoardView: View {
    
    @ObservedObject var gameViewModel = GameViewModel.shared
    
    var body: some View {
        Grid(horizontalSpacing: 1, verticalSpacing: 1) {
            ForEach(0..<gameViewModel.game.getBoardSize(), id: \.self) { i in
                GridRow {
                    ForEach(0..<gameViewModel.game.getBoardSize(), id:\.self) { j in
                        SquareView(square: gameViewModel.game.board[i][j])
                            .padding(0)
                    }
                }
            }
        }
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView()
    }
}
