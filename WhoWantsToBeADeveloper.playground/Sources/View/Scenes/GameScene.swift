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
    
    override func mouseDown(with event: NSEvent) {
        let mousePoint = convertPoint(fromView: CGPoint(x: event.locationInWindow.x, y: event.locationInWindow.y))
        guard let touchedNode = nodes(at: mousePoint).first else {
            return
        }
        if gameControllerDelegate.jokerFiftyFiftyActive
            && touchedNode == gameNode.jokerFiftyFiftyButton {
            gameNode.jokerFiftyFiftyButton.fillTexture = kJokerFiftyFiftySelectedTexture
        }
        if gameControllerDelegate.jokerAudienceActive
            && touchedNode == gameNode.jokerAudienceButton {
            gameNode.jokerAudienceButton.fillTexture = kJokerAudienceSelectedTexture
        }
        if touchedNode == gameNode.pauseButton {
            gameNode.pauseButton.fillTexture = kButtonPauseSelectedTexture
        }
    }
    
    override func mouseUp(with event: NSEvent) {
        let mousePoint = convertPoint(fromView: CGPoint(x: event.locationInWindow.x, y: event.locationInWindow.y))
        guard let touchedNode = nodes(at: mousePoint).first else {
            return
        }
        if gameNode.answerOptionActive_0
            && touchedNode == gameNode.answerOption_0 {
            gameNode.isUserInteractionEnabled = false
            gameNode.answerOption_0.fillTexture = kButtonLoggedTexture
            gameControllerDelegate.didSelectAnswerOption(.optionA)
        }
        if gameNode.answerOptionActive_1
            && touchedNode == gameNode.answerOption_1 {
            gameNode.isUserInteractionEnabled = false
            gameNode.answerOption_1.fillTexture = kButtonLoggedTexture
            gameControllerDelegate.didSelectAnswerOption(.optionB)
        }
        if gameNode.answerOptionActive_2
            && touchedNode == gameNode.answerOption_2 {
            gameNode.isUserInteractionEnabled = false
            gameNode.answerOption_2.fillTexture = kButtonLoggedTexture
            gameControllerDelegate.didSelectAnswerOption(.optionC)
        }
        if gameNode.answerOptionActive_3
            && touchedNode == gameNode.answerOption_3 {
            gameNode.isUserInteractionEnabled = false
            gameNode.answerOption_3.fillTexture = kButtonLoggedTexture
            gameControllerDelegate.didSelectAnswerOption(.optionD)
        }
        if gameControllerDelegate.jokerFiftyFiftyActive
            && touchedNode == gameNode.jokerFiftyFiftyButton {
            gameControllerDelegate.jokerFiftyFiftyActive = false
            gameNode.jokerFiftyFiftyButton.fillTexture = kJokerFiftyFiftyInactiveTexture
            gameControllerDelegate.didSelectJokerOption(.fiftyFifty)
        }
        if gameControllerDelegate.jokerAudienceActive
            && touchedNode == gameNode.jokerAudienceButton {
            gameControllerDelegate.jokerAudienceActive = false
            gameNode.jokerAudienceButton.fillTexture = kJokerAudienceInactiveTexture
            gameControllerDelegate.didSelectJokerOption(.audience)
        }
        if touchedNode == gameNode.pauseButton {
            gameControllerDelegate.didSelectPause()
        }
        gameNode.pauseButton.fillTexture = kButtonPauseActiveTexture
    }
}
