//
//  ContentView.swift
//  Othello
//
//  Created by Collins, Matthew - MC on 11/12/2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var gameViewModel = GameViewModel.shared
    
    var body: some View {
        VStack {
            Text("Othello")
            Spacer()
            BoardView(board: gameViewModel.game.getBoard())
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
