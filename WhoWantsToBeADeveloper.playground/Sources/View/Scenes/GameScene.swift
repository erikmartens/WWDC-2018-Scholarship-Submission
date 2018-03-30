import SpriteKit

class GameScene: SKScene {
    
    // MARK: - Public Properties
    
    weak var gameControllerDelegate: GameControllerDelegate!
    
    
    // MARK: - Private Properties
    
    private var gameNode: GameNode!
    private var gameMusicNode: SKAudioNode!
    
    
    // MARK: - Overrides
    
    override func didMove(to view: SKView) {
        size = view.frame.size
        
        let musicNode = SKAudioNode(fileNamed: "Sounds/level_1.wav")
        gameMusicNode = musicNode
        
        if gameNode == nil {
            gameNode = GameNode(frame: view.frame, gameControllerDelegate: gameControllerDelegate)
        }
        gameMusicNode.autoplayLooped = true
        addChild(gameMusicNode)
        addChild(gameNode)
    }
    
    override func willMove(from: SKView) {
        removeAllChildren()
    }
    
    
    // MARK: - Public Functions
    
    func configure(with question: QuestionDTO, questionIndex: Int, jokerActive: Bool) {
        gameNode.configure(with: question, questionIndex: questionIndex, jokerActive: jokerActive)
    }
    
    func playGameMusic() {
        gameMusicNode.run(.play())
    }
    
    func deactivateGameMusic(_ deactivate: Bool) {
        let volume: Float = deactivate ? 0 : 1
        gameMusicNode.run(.changeVolume(to: volume, duration: 0))
    }
    
    func stopGameMusic() {
        gameMusicNode.run(.stop())
    }
    
    func updateTimer(with timeLeft: TimeInterval) {
        gameNode.updateTimer(with: timeLeft)
    }
    
    func markAsAnsweredCorrectly(with answerOption: AnswerOption) {
        gameNode.markAnswerOption(answerOption, usingTexture: kButtonCorrectTexture)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.run(SKAction.playSoundFileNamed("Sounds/correct.wav", waitForCompletion: false))
        }
    }
    
    func markAsAnsweredIncorrectly(with chosenOption: AnswerOption, correctOption: AnswerOption) {
        gameNode.markAnswerOption(chosenOption, usingTexture: kButtonIncorrectTexture)
        gameNode.markAnswerOption(correctOption, usingTexture: kButtonCorrectTexture)
        
        gameMusicNode.run(.changeVolume(to: 0, duration: 2.0))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.run(SKAction.playSoundFileNamed("Sounds/incorrect.wav", waitForCompletion: false))
        }
    }
    
    func activateJoker(with excludedAnswerOptions: JokerFiftyExcludedAnswerOptions) {
        gameNode.markAnswerOptionInactive(excludedAnswerOptions.firstAnswerOption)
        gameNode.markAnswerOptionInactive(excludedAnswerOptions.secondAnswerOption)
        run(SKAction.playSoundFileNamed("Sounds/joker.wav", waitForCompletion: false))
    }
}
