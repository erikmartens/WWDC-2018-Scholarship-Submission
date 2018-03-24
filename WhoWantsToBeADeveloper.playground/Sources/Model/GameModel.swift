import Foundation

struct JokerFiftyExcludedAnswerOptions {
    var firstAnswerOption: AnswerOption
    var secondAnswerOption: AnswerOption
}

class GameModel {
    
    // todo: remove dummy question
    static private let answerOptions = [AnswerOption.optionA: "Test A", AnswerOption.optionB: "Test B", AnswerOption.optionC: "Test C", AnswerOption.optionD: "Test D"]
    static private let question = QuestionDTO(identifier: 126543456, question: "Test Question? Test Question? Test Question? Test Question? Test Question? Test Question? Test Question? Test Question? Test Question?", answerOptions: GameModel.answerOptions, correctAnswerOption: AnswerOption.optionA)

    // MARK: - Properties
    
    private(set) var currentQuestionIndex: Int
    private var deliveredQuestionIDs: [Int]
    private var questions: [QuestionDTO]
    private var currentQuestion: QuestionDTO!
    var jokerFiftyFiftyActive: Bool!
    var jokerAudienceActive: Bool!
    
    
    // MARK: - Initialization
    
    /**
     * This init is used for restoring a previous game from a save file
     */
    init(currentQuestionIndex: Int, deliveredQuestionIDs: [Int], questions: [QuestionDTO], jokerFiftyFiftyActive: Bool, jokerAudienceActive: Bool) {
        self.currentQuestionIndex = currentQuestionIndex
        self.deliveredQuestionIDs = deliveredQuestionIDs
        self.questions = questions
        self.jokerFiftyFiftyActive = jokerFiftyFiftyActive
        self.jokerAudienceActive = jokerAudienceActive
    }
    
    /**
     * This convenience init is used for initiating a new game
     */
    convenience init() {
        let questions = [GameModel.question] // todo: get via file storage service
        self.init(currentQuestionIndex: 0, deliveredQuestionIDs: [Int](), questions: questions, jokerFiftyFiftyActive: true, jokerAudienceActive: true)
    }
    
    
    // MARK: - Public Properties & Functions
    
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
        
        let randomIndex = Int(arc4random_uniform(UInt32(remainingQuestions.count)))
        currentQuestion = remainingQuestions[randomIndex]
        deliveredQuestionIDs.append(currentQuestion.identifier)
        return currentQuestion
    }
    
    var correctAnswerOption: AnswerOption {
        return currentQuestion.correctAnswerOption
    }
    
    var jokerFiftyFiftyExcludedAnswerOptions: JokerFiftyExcludedAnswerOptions {
        var excludableAnswerOptions: [AnswerOption] = [.optionA, .optionB, .optionC, .optionD].filter { return $0 != currentQuestion.correctAnswerOption }
        
        let randomIndex = Int(arc4random_uniform(UInt32(excludableAnswerOptions.count)))
        _ = excludableAnswerOptions.remove(at: randomIndex)
        return JokerFiftyExcludedAnswerOptions(firstAnswerOption: excludableAnswerOptions.first!, secondAnswerOption: excludableAnswerOptions.last!) // force unwrap, this should never be nil (and if we want to know)
    }
    
    func verifyAnswerOption(_ option: AnswerOption) -> Bool {
        return currentQuestion.correctAnswerOption == option
    }
}
