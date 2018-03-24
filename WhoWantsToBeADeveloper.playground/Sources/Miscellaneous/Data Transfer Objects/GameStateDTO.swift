import Foundation

struct GameStateDTO: Codable {
    var currentQuestionIndex: Int
    var deliveredQuestionIDs: [Int]
    var remainingTime: Int
    var jokerFiftyFiftyActive: Bool
    var jokerAudienceActive: Bool
}

