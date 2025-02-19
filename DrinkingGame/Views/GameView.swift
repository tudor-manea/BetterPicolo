import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel
    @State private var cardRotation: Double = 0
    @State private var cardOpacity: Double = 1
    
    var body: some View {
        ZStack {
            // Gradient Background
            LinearGradient(gradient: Gradient(colors: [
                .customNavy,
                .customTeal
            ]), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Game On!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                // Flashcard-style question display
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.customLightBlue.opacity(0.9))
                        .shadow(radius: 10)
                    
                    VStack(spacing: 15) {
                        Text(viewModel.formattedQuestion)
                            .font(.title2)
                            .multilineTextAlignment(.center)
                            .padding()
                            .foregroundColor(.white)
                    }
                }
                .frame(height: 200)
                .rotation3DEffect(
                    .degrees(cardRotation),
                    axis: (x: 0, y: 1, z: 0)
                )
                .opacity(cardOpacity)
                .onTapGesture {
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
                }
                
                Spacer()
                
                // End Game button
                Button(action: viewModel.endGame) {
                    HStack {
                        Image(systemName: "xmark.circle.fill")
                        Text("End Game")
                    }
                    .frame(width: 200)
                    .padding()
                    .background(Color.customOrange)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                .padding(.bottom, 30)
            }
            .padding()
        }
    }
}
