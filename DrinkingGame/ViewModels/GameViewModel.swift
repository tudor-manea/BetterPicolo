import Foundation
import Combine
import SwiftUI

@MainActor
class GameViewModel: ObservableObject {
    @Published private(set) var players: [Player] = []
    @Published private(set) var currentQuestion: Question? = nil
    @Published private(set) var formattedQuestion: String = ""
    @Published var currentPlayerName: String = ""
    @Published private(set) var errorMessage: String? = nil
    @Published private(set) var isGameStarted: Bool = false
    
    private var questions: [Question] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadQuestions()
    }
    
    private func loadQuestions() {
        do {
            questions = try QuestionLoader.loadQuestions()
        } catch {
            print("Failed to load questions: \(error)")
            // Fallback questions in case the JSON file fails to load
            questions = [
                Question(template: "{player1} must take a drink!", numberOfPlayersInvolved: 1, type: .singlePlayerAction),
                Question(template: "{player1} must challenge {player2} to a dance-off!", numberOfPlayersInvolved: 2, type: .playerComparison),
                Question(template: "Everyone except {player1} must drink!", numberOfPlayersInvolved: 1, type: .groupAction)
            ]
        }
    }
    
    func addPlayer() {
        let trimmedName = currentPlayerName.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedName.isEmpty else {
            errorMessage = "Player name cannot be empty"
            return
        }
        
        guard !players.contains(where: { $0.name.lowercased() == trimmedName.lowercased() }) else {
            errorMessage = "Player name must be unique"
            return
        }
        
        let newPlayer = Player(name: trimmedName)
        players.append(newPlayer)
        currentPlayerName = ""
        errorMessage = nil
    }
    
    func removePlayer(_ player: Player) {
        players.removeAll(where: { $0.id == player.id })
    }
    
    func startGame() {
        guard players.count >= 2 else {
            errorMessage = "At least 2 players are required to start the game"
            return
        }
        
        isGameStarted = true
        nextQuestion()
    }
    
    func nextQuestion() {
        guard let question = questions.randomElement() else { return }
        currentQuestion = question
        formattedQuestion = question.formatQuestion(with: players)
    }
    
    func endGame() {
        isGameStarted = false
        currentQuestion = nil
        formattedQuestion = ""
    }
}
