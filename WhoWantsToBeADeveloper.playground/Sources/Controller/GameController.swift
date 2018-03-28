import Foundation

enum JokerOption: Int {
    case fiftyFifty
    case audience
}

protocol GameControllerDelegate: class {
    var jokerFiftyFiftyActive: Bool { get set }
    var jokerAudienceActive: Bool { get set }
    func didSelectAnswerOption(_ option: AnswerOption)
    func didSelectJokerOption(_ option: JokerOption)
    func didSelectPause()
}

class GameController {
    
    // MARK: - Private Properties
    
    private weak var applicationDelegate: ApplicationDelegate!
    
    private var gameScene: GameScene
    private var gameModel: GameModel
    
    private var roundTimer: Timer!
    private var timeLeft: TimeInterval = 0
    
    
    // MARK: - Initialization
    
    init(applicationDelegate: ApplicationDelegate) {
        self.applicationDelegate = applicationDelegate
        
        gameScene = GameScene()
        gameModel = GameModel()
    }
    
    
    // MARK: - Public Functions
    
    func startGame(with savegame: SavegameDTO?) {
        gameScene.gameControllerDelegate = self
        
        guard let savegame = savegame else {
            gameModel = GameModel()
            applicationDelegate.presentScene(gameScene)
            configureNextRound()
            return
        }
        gameModel.configure(with: savegame)
        timeLeft = savegame.remainingTime
        applicationDelegate.presentScene(gameScene)
        configureResumeRound()
    }
    
    
    // MARK: - Private Helpers
    
    fileprivate func gameOver() {
        let score = gameModel.currentQuestionIndex
        applicationDelegate.moveToScene(with: .registerHighscore(score))
    }
    
    fileprivate func storeGameState() {
        let savegame = SavegameDTO(currentQuestionIndex: gameModel.currentQuestionIndex,
                                   deliveredQuestionIDs: gameModel.deliveredQuestionIDs,
                                   remainingTime: timeLeft,
                                   jokerFiftyFiftyActive: gameModel.jokerFiftyFiftyActive,
                                   jokerAudienceActive: gameModel.jokerAudienceActive)
        FileStorageService.savegame = savegame
    }
    
    private func configureResumeRound() {
        let question = gameModel.currentQuestion!
        let questionIndex = gameModel.currentQuestionIndex
        gameScene.configure(with: question, questionIndex: questionIndex, jokerFiftyFiftyActive: gameModel.jokerFiftyFiftyActive, jokerAudienceActive: gameModel.jokerAudienceActive)
        startRoundTimer()
    }
    
    fileprivate func configureNextRound(with timeLeft: TimeInterval = 30) {
        let question = gameModel.nextQuestion
        let questionIndex = gameModel.currentQuestionIndex
        gameScene.configure(with: question, questionIndex: questionIndex, jokerFiftyFiftyActive: gameModel.jokerFiftyFiftyActive, jokerAudienceActive: gameModel.jokerAudienceActive)
        
        self.timeLeft = timeLeft
        startRoundTimer()
    }
    
    
    /* Round Timer */
    
    private func startRoundTimer() {
        gameScene.updateTimer(with: timeLeft)
        roundTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }

    @objc private func fireTimer() {
        timeLeft -= 1
        if timeLeft < 0 {
            timerDidRunOut()
            return
        }
        gameScene.updateTimer(with: timeLeft)
    }
    
    private func timerDidRunOut() {
        roundTimer.invalidate()
        gameOver()
    }
}

extension GameController: GameControllerDelegate {
    
    var jokerFiftyFiftyActive: Bool {
        get { return gameModel.jokerFiftyFiftyActive }
        set { gameModel.jokerFiftyFiftyActive = newValue }
    }
    
    var jokerAudienceActive: Bool {
        get { return gameModel.jokerAudienceActive }
        set { gameModel.jokerAudienceActive = newValue }
    }
    
    func didSelectAnswerOption(_ option: AnswerOption) {
        roundTimer.invalidate()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let answeredCorrectly = self.gameModel.verifyAnswerOption(option)
            guard answeredCorrectly else {
                self.gameScene.markAsAnsweredIncorrectly(with: option, correctOption: self.gameModel.correctAnswerOption)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.gameOver()
                }
                return
            }
            self.gameScene.markAsAnsweredCorrectly(with: option)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.configureNextRound()
            }
        }
    }
    
    func didSelectJokerOption(_ option: JokerOption) {
        switch option {
        case .fiftyFifty:
            gameModel.jokerFiftyFiftyActive = false
            let excludedAnswerOptions = gameModel.jokerFiftyFiftyExcludedAnswerOptions
            gameScene.activateFiftyFiftyJoker(with: excludedAnswerOptions)
        case .audience:
            gameModel.jokerAudienceActive = false
            // todo
        }
    }
    
    func didSelectPause() {
        roundTimer.invalidate()
        storeGameState()
        applicationDelegate.moveToScene(with: .mainMenu)
    }
}
