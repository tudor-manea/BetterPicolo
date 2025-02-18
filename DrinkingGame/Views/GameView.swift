import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel
    @State private var cardRotation: Double = 0
    @State private var cardOpacity: Double = 1
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Game On!")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
            
            // Flashcard-style question display
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.blue.opacity(0.1))
                    .shadow(radius: 10)
                
                VStack(spacing: 15) {
                    Text(viewModel.formattedQuestion)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
            .frame(height: 200)
            .rotation3DEffect(
                .degrees(cardRotation),
                axis: (x: 0, y: 1, z: 0)
            )
            .opacity(cardOpacity)
            
            Spacer()
            
            // Control buttons
            HStack(spacing: 20) {
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        cardOpacity = 0
                        cardRotation = -90
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        viewModel.nextQuestion()
                        
                        withAnimation(.easeInOut(duration: 0.5)) {
                            cardOpacity = 1
                            cardRotation = 0
                        }
                    }
                }) {
                    Text("Next Question")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                Button(action: viewModel.endGame) {
                    Text("End Game")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.red)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding(.horizontal)
        }
        .padding()
    }
}
