import Foundation

struct GameStateDTO: Codable {
    var numberOfQuestions: Int
    var currentQuestionID: Int
    var remainingTime: Int
    var usedFiftyFiftyJoker: Bool
    var usedAudienceJoker: Bool
}
