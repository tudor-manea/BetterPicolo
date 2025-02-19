import SwiftUI

struct PlayerInputView: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Gradient Background
                LinearGradient(gradient: Gradient(colors: [
                    .customLightBlue,
                    .customTeal
                ]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Top section with input and add button
                    VStack(spacing: 15) {
                        TextField("Enter player name", text: $viewModel.currentPlayerName)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal)
                        
                        Button {
                            viewModel.addPlayer()
                        } label: {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                Text("Add Player")
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(Color.customYellow)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical, 20)
                    .background(Color.customLightBlue)
                    
                    if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.caption)
                            .padding(.top, 5)
                    }
                    
                    // Player list
                    ScrollView {
                        LazyVStack(spacing: 1) {
                            ForEach(viewModel.players) { player in
                                HStack {
                                    Text(player.name)
                                        .font(.body)
                                        .foregroundColor(.customNavy)
                                    Spacer()
                                    Button {
                                        viewModel.removePlayer(player)
                                    } label: {
                                        Image(systemName: "trash.fill")
                                            .foregroundColor(.customYellow)
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 12)
                                .background(Color.white.opacity(0.2))
                            }
                        }
                        .padding(.top, 10)
                    }
                    
                    Spacer()
                    
                    // Start Game button at bottom
                    Button {
                        viewModel.startGame()
                    } label: {
                        HStack {
                            Image(systemName: "play.fill")
                            Text("Start Game")
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(viewModel.players.count >= 2 ? Color.customYellow : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .disabled(viewModel.players.count < 2)
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                }
            }
            .navigationTitle("Add Players")
        }
    }
}
