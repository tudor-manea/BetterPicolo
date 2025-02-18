//
//  ContentView.swift
//  DrinkingGame
//
//  Created by Tudor Manea on 18/02/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var gameViewModel = GameViewModel()
    
    var body: some View {
        Group {
            if gameViewModel.isGameStarted {
                GameView(viewModel: gameViewModel)
            } else {
                PlayerInputView(viewModel: gameViewModel)
            }
        }
    }
}

#Preview {
    ContentView()
}
