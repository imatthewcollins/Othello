//
//  BoardView.swift
//  Othello
//
//  Created by Collins, Matthew - MC on 12/12/2023.
//

import SwiftUI

struct BoardView: View {
    
    var board: [[Square]]
    
    var body: some View {
        Grid(horizontalSpacing: 1, verticalSpacing: 1) {
            ForEach(0..<board.count, id: \.self) { i in
                GridRow {
                    ForEach(0..<board[i].count, id:\.self) { j in
                        SquareView(square: board[i][j])
                            .padding(0)
                    }
                }
            }
        }
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView(board: [[Square]]())
    }
}
