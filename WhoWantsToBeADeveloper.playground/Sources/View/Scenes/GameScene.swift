import SpriteKit

class GameScene: SKScene {
    
    // MARK: - Public Properties
    
    weak var gameControllerDelegate: GameControllerDelegate!
    
    
    // MARK: - Private Properties
    
    private var gameNode: GameNode!
    
    
    // MARK: - Overrides
    
    override func didMove(to view: SKView) {
        size = view.frame.size
        
        if gameNode == nil {
            gameNode = GameNode(frame: view.frame, gameControllerDelegate: gameControllerDelegate)
        }
        addChild(gameNode)
    }
    
    override func willMove(from: SKView) {
        removeAllChildren()
    }
    
    
    // MARK: - Public Functions
    
    func configure(with question: QuestionDTO, questionIndex: Int, jokerFiftyFiftyActive: Bool, jokerAudienceActive: Bool) {
        gameNode.configure(with: question, questionIndex: questionIndex, jokerFiftyFiftyActive: jokerFiftyFiftyActive, jokerAudienceActive: jokerAudienceActive)
    }
    
    func updateTimer(with timeLeft: TimeInterval) {
        gameNode.updateTimer(with: timeLeft)
    }
    
    func markAsAnsweredCorrectly(with answerOption: AnswerOption) {
        gameNode.markAnswerOption(answerOption, usingTexture: kButtonCorrectTexture)
    }
    
    func markAsAnsweredIncorrectly(with chosenOption: AnswerOption, correctOption: AnswerOption) {
        gameNode.markAnswerOption(chosenOption, usingTexture: kButtonIncorrectTexture)
        gameNode.markAnswerOption(correctOption, usingTexture: kButtonCorrectTexture)
    }
    
    func activateFiftyFiftyJoker(with excludedAnswerOptions: JokerFiftyExcludedAnswerOptions) {
        gameNode.markAnswerOptionInactive(excludedAnswerOptions.firstAnswerOption)
        gameNode.markAnswerOptionInactive(excludedAnswerOptions.secondAnswerOption)
    }
}
