//
//  DrinkingGameApp.swift
//  DrinkingGame
//
//  Created by Tudor Manea on 18/02/2025.
//

import SwiftUI

@main
struct DrinkingGameApp: App {
    @StateObject private var gameViewModel = GameViewModel()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if gameViewModel.isGameStarted {
                    GameView(viewModel: gameViewModel)
                } else {
                    PlayerInputView(viewModel: gameViewModel)
                }
            }
        }
    }
}
