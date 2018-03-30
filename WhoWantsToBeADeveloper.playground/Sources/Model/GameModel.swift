import Foundation

struct JokerFiftyExcludedAnswerOptions {
    var firstAnswerOption: AnswerOption
    var secondAnswerOption: AnswerOption
}

class GameModel {

    // MARK: - Properties
    
    private(set) var currentQuestionIndex: Int
    private(set) var deliveredQuestionIDs: [Int]
    private var questions: [QuestionDTO]
    private(set) var currentQuestion: QuestionDTO!
    var jokerActive: Bool
    var roundsUntilJokerReactivation = 0
    
    
    // MARK: - Initialization
    
    convenience init() {
        self.init(currentQuestionIndex: -1, deliveredQuestionIDs: [Int](), jokerActive: true, roundsUntilJokerReactivation: 0)
    }
    
    private init(currentQuestionIndex: Int, deliveredQuestionIDs: [Int], jokerActive: Bool, roundsUntilJokerReactivation: Int) {
        self.currentQuestionIndex = currentQuestionIndex
        self.deliveredQuestionIDs = deliveredQuestionIDs
        questions = FileStorageService.questions! // force unwrap, this should always succeed and should crash if it doesn't (without questions the game can't run)
        if !deliveredQuestionIDs.isEmpty {
            currentQuestion = questions.first { return $0.identifier == deliveredQuestionIDs.last! }
        }
        self.jokerActive = jokerActive
        self.roundsUntilJokerReactivation = roundsUntilJokerReactivation
    }
    
    
    // MARK: - Public Properties & Functions
    
    func configure(with savegame: SavegameDTO) {
        currentQuestionIndex = savegame.currentQuestionIndex
        deliveredQuestionIDs = savegame.deliveredQuestionIDs
        jokerActive = savegame.jokerActive
        roundsUntilJokerReactivation = savegame.roundsUntilJokerReactivation
        
        if !deliveredQuestionIDs.isEmpty {
            currentQuestion = questions.first { return $0.identifier == deliveredQuestionIDs.last! }
        }
    }
    
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
