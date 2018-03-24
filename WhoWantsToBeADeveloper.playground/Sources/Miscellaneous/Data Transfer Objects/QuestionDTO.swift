import Foundation

enum AnswerOption: String, Codable {
    case optionA
    case optionB
    case optionC
    case optionD
}

struct QuestionArrayWrapper: Codable {
    var questions: [QuestionDTO]
}

struct QuestionDTO: Codable {
    var identifier: Int
    var question: String
    var answerOptions: [AnswerOption: String]
    var correctAnswerOption: AnswerOption
}
