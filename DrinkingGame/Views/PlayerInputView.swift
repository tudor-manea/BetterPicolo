import SwiftUI

struct PlayerInputView: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    TextField("Enter player name", text: $viewModel.currentPlayerName)
                        .textFieldStyle(.roundedBorder)
                        .submitLabel(.done)
                        .onSubmit {
                            viewModel.addPlayer()
                        }
                    
                    if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    
                    Button {
                        viewModel.addPlayer()
                    } label: {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Add Player")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .padding(.horizontal)
                
                List {
                    ForEach(viewModel.players) { player in
                        HStack {
                            Text(player.name)
                                .font(.body)
                            Spacer()
                            Button(role: .destructive) {
                                viewModel.removePlayer(player)
                            } label: {
                                Image(systemName: "trash")
                            }
                            .buttonStyle(.borderless)
                        }
                    }
                }
                
                Button {
                    viewModel.startGame()
                } label: {
                    HStack {
                        Image(systemName: "play.fill")
                        Text("Start Game")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.players.count >= 2 ? .green : .gray)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .disabled(viewModel.players.count < 2)
                .padding(.horizontal)
            }
            .navigationTitle("Add Players")
        }
    }
}
