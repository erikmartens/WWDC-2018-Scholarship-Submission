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
    
    
    // MARK: - Input Event Handlers
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        
        if gameControllerDelegate.jokerFiftyFiftyActive
            && gameNode.contains(location) {
            gameNode.jokerFiftyFiftyButton.fillTexture = kJokerFiftyFiftySelectedTexture
        }
        if gameControllerDelegate.jokerAudienceActive
            && gameNode.jokerAudienceButton.contains(location) {
            gameNode.jokerAudienceButton.fillTexture = kJokerAudienceSelectedTexture
        }
        if gameNode.pauseButton.contains(location) {
            gameNode.pauseButton.fillTexture = kButtonPauseSelectedTexture
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        
        if gameNode.answerOptionActive_0
            && gameNode.answerOption_0.contains(location) {
            gameNode.isUserInteractionEnabled = false
            gameNode.answerOption_0.fillTexture = kButtonLoggedTexture
            gameControllerDelegate.didSelectAnswerOption(.optionA)
        }
        if gameNode.answerOptionActive_1
            && gameNode.answerOption_1.contains(location) {
            gameNode.isUserInteractionEnabled = false
            gameNode.answerOption_1.fillTexture = kButtonLoggedTexture
            gameControllerDelegate.didSelectAnswerOption(.optionB)
        }
        if gameNode.answerOptionActive_2
            && gameNode.answerOption_2.contains(location) {
            gameNode.isUserInteractionEnabled = false
            gameNode.answerOption_2.fillTexture = kButtonLoggedTexture
            gameControllerDelegate.didSelectAnswerOption(.optionC)
        }
        if gameNode.answerOptionActive_3
            && gameNode.answerOption_3.contains(location) {
            gameNode.isUserInteractionEnabled = false
            gameNode.answerOption_3.fillTexture = kButtonLoggedTexture
            gameControllerDelegate.didSelectAnswerOption(.optionD)
        }
        if gameControllerDelegate.jokerFiftyFiftyActive
            && gameNode.jokerFiftyFiftyButton.contains(location) {
            gameControllerDelegate.jokerFiftyFiftyActive = false
            gameNode.jokerFiftyFiftyButton.fillTexture = kJokerFiftyFiftyInactiveTexture
            gameControllerDelegate.didSelectJokerOption(.fiftyFifty)
        }
        if gameControllerDelegate.jokerAudienceActive
            && gameNode.jokerAudienceButton.contains(location) {
            gameControllerDelegate.jokerAudienceActive = false
            gameNode.jokerAudienceButton.fillTexture = kJokerAudienceInactiveTexture
            gameControllerDelegate.didSelectJokerOption(.audience)
        }
        if gameNode.pauseButton.contains(location) {
            gameControllerDelegate.didSelectPause()
        }
        gameNode.pauseButton.fillTexture = kButtonPauseActiveTexture
    }
}
