import Foundation

enum QuestionType: String, Codable {
    case singlePlayerAction
    case playerComparison
    case groupAction
}

struct Question: Identifiable, Codable {
    let id: UUID
    let template: String
    let numberOfPlayersInvolved: Int
    let type: QuestionType
    
    init(id: UUID = UUID(), template: String, numberOfPlayersInvolved: Int, type: QuestionType) {
        self.id = id
        self.template = template
        self.numberOfPlayersInvolved = numberOfPlayersInvolved
        self.type = type
    }
    
    func formatQuestion(with players: [Player]) -> String {
        guard players.count >= numberOfPlayersInvolved else {
            return "Not enough players for this question"
        }
        
        var formattedTemplate = template
        let selectedPlayers = players.shuffled().prefix(numberOfPlayersInvolved)
        
        for (index, player) in selectedPlayers.enumerated() {
            formattedTemplate = formattedTemplate.replacingOccurrences(
                of: "{player\(index + 1)}",
                with: player.name
            )
        }
        
        return formattedTemplate
    }
}
