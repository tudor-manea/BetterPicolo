import Foundation

struct QuestionsData: Codable {
    let questions: [Question]
}

enum QuestionLoaderError: Error {
    case fileNotFound
    case decodingError
}

class QuestionLoader {
    static func loadQuestions() throws -> [Question] {
        guard let url = Bundle.main.url(forResource: "questions", withExtension: "json") else {
            throw QuestionLoaderError.fileNotFound
        }
        
        do {
            let data = try Data(contentsOf: url)
            let questionsData = try JSONDecoder().decode(QuestionsData.self, from: data)
            return questionsData.questions
        } catch {
            print("Error loading questions: \(error)")
            throw QuestionLoaderError.decodingError
        }
    }
}
