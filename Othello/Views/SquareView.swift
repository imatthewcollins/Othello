//
//  SquareView.swift
//  Othello
//
//  Created by Collins, Matthew - MC on 12/12/2023.
//

import SwiftUI

struct SquareView: View {
    
    @State var square: Square
    
    var body: some View {
        ZStack {
            Rectangle()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.green)
            
            if let piece = square.currentPiece {
                Circle()
                    .foregroundColor(piece == .white ? .white : .black)
                    .padding(1)
            }
        }
    }
}

struct SquareView_Previews: PreviewProvider {
    static var previews: some View {
        SquareView(square: Square())
    }
}
