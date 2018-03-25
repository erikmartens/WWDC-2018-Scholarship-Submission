import Foundation

struct GameStateDTO: Codable {
    var currentQuestionIndex: Int
    var deliveredQuestionIDs: [Int]
    var remainingTime: TimeInterval
    var jokerFiftyFiftyActive: Bool
    var jokerAudienceActive: Bool
}

