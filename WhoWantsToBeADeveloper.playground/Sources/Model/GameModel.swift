import Foundation

protocol GameModelDelegate: class {
    var nextQuestion: QuestionDTO { get }
    func verifyAnswerOption(_ option: AnswerOption) -> Bool
}

class GameModel {
    
    // todo: remove dummy question
    static private let answerOptions = [AnswerOption.optionA: "Test A", AnswerOption.optionB: "Test B", AnswerOption.optionC: "Test C", AnswerOption.optionD: "Test D"]
    static private let question = QuestionDTO(identifier: 126543456, question: "Test Question?", answerOptions: GameModel.answerOptions, correctAnswerOption: AnswerOption.optionA)

    // MARK: - Properties
    
    fileprivate var currentQuestionIndex: Int
    fileprivate var deliveredQuestionIDs: [Int]
    fileprivate var questions: [QuestionDTO]
    
    fileprivate var currentQuestion: QuestionDTO!
    
    
    // MARK: - Initialization
    
    /**
     * This init is used for restoring a previous game from a save file
     */
    init(currentQuestionIndex: Int, deliveredQuestionIDs: [Int], questions: [QuestionDTO]) {
        self.currentQuestionIndex = currentQuestionIndex
        self.deliveredQuestionIDs = deliveredQuestionIDs
        self.questions = questions
    }
    
    /**
     * This convenience init is used for initiating a new game
     */
    convenience init() {
        let questions = [GameModel.question] // todo: get via file storage service
        self.init(currentQuestionIndex: 0, deliveredQuestionIDs: [Int](), questions: questions)
    }
}

extension GameModel: GameModelDelegate {
    
    var nextQuestion: QuestionDTO {
        var remainingQuestions = questions.filter { question in
            return !deliveredQuestionIDs.contains(where: { return $0 == question.identifier })
        }
        // all questions may have been used -> start over
        if remainingQuestions.isEmpty {
            deliveredQuestionIDs = [Int]()
            remainingQuestions = questions
        }
        
        currentQuestionIndex += 1
        
        let randomIndex = Int(arc4random_uniform(UInt32(questions.count)))
        currentQuestion = questions[randomIndex]
        deliveredQuestionIDs.append(currentQuestion.identifier)
        return currentQuestion
    }
    
    func verifyAnswerOption(_ option: AnswerOption) -> Bool {
        return currentQuestion.correctAnswerOption == option
    }
}
