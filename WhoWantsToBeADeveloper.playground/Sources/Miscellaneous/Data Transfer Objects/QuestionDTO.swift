import Foundation

enum AnswerOption: Int, Codable {
    case optionA
    case optionB
    case optionC
    case optionD
}

struct QuestionDTO: Codable {
    var identifier: Int
    var question: String
    var answerOptions: [AnswerOption: String]
    var correctAnswerOption: AnswerOption
}
