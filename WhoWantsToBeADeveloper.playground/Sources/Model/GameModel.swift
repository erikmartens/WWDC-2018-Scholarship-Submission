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
    var jokerFiftyFiftyActive: Bool!
    var jokerAudienceActive: Bool!
    
    
    // MARK: - Initialization
    
    
    private init(currentQuestionIndex: Int, deliveredQuestionIDs: [Int], jokerFiftyFiftyActive: Bool, jokerAudienceActive: Bool) {
        self.currentQuestionIndex = currentQuestionIndex
        self.deliveredQuestionIDs = deliveredQuestionIDs
        questions = FileStorageService.questions! // force unwrap, this should always succeed and should crash if it doesn't (without questions the game can't run)
        if !deliveredQuestionIDs.isEmpty {
            currentQuestion = questions.first { return $0.identifier == deliveredQuestionIDs.last! }
        }
        self.jokerFiftyFiftyActive = jokerFiftyFiftyActive
        self.jokerAudienceActive = jokerAudienceActive
    }
    
    /**
     * This init is used for restoring a previous game from a save file
     */
    convenience init(savegame: SaveGameDTO) {
        self.init(currentQuestionIndex: savegame.currentQuestionIndex, deliveredQuestionIDs: savegame.deliveredQuestionIDs, jokerFiftyFiftyActive: savegame.jokerFiftyFiftyActive, jokerAudienceActive: savegame.jokerAudienceActive)
    }
    
    /**
     * This convenience init is used for initiating a new game
     */
    convenience init() {
        self.init(currentQuestionIndex: -1, deliveredQuestionIDs: [Int](), jokerFiftyFiftyActive: true, jokerAudienceActive: true)
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
