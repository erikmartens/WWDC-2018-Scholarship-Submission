import Foundation

struct HighscoreArrayWrapper: Codable {
    var highscores: [HighscoreDTO]
}

struct HighscoreDTO: Codable {
    var score: Int
    var name: String
    var date: Date
}
