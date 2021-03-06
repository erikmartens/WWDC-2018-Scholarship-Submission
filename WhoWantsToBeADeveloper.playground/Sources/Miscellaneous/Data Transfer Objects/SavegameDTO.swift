import Foundation

struct SavegameDTO: Codable {
    var currentQuestionIndex: Int
    var deliveredQuestionIDs: [Int]
    var remainingTime: TimeInterval
    var jokerActive: Bool
    var roundsUntilJokerReactivation: Int
}

