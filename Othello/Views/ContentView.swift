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
            Button {
                gameViewModel.startGame()
            } label: {
                Text("New game")
            }
            Spacer()
            Text("\(gameViewModel.currentPlayer != nil ? "\(gameViewModel.currentPlayer == .black ? "Black" : "White") to move" : "")")
            Spacer()
            BoardView()
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
