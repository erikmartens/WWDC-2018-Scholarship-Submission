import Foundation

struct GameStateDTO: Codable {
    var currentQuestionIndex: Int
    var deliveredQuestionIDs: [Int]
    var remainingTime: Int
    var usedFiftyFiftyJoker: Bool
    var usedAudienceJoker: Bool
}

