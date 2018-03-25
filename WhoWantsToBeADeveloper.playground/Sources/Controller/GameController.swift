import Foundation

enum JokerOption: Int {
    case fiftyFifty
    case audience
}

protocol GameControllerDelegate: class {
    func didSelectAnswerOption(_ option: AnswerOption)
    func didSelectJokerOption(_ option: JokerOption)
    func didSelectPause()
}

class GameController {
    
    // MARK: - Private Properties
    // implicitely force unwrap applicationGameDelegate, gameNode & gameModel
    // they should never be nil and if it is we want to know by crashing the app, so we are alerted and can fix it
    
    private weak var applicationGameDelegate: ApplicationGameDelegate!

    private var gameNode: GameNode!
    private var gameModel: GameModel!
    
    private var roundTimer: Timer!
    private var timeLeft: TimeInterval = 0
    
    
    // MARK: - Initialization
    
    init(applicationGameDelegate: ApplicationGameDelegate) {
        self.applicationGameDelegate = applicationGameDelegate
        startGame()
    }
    
    init(applicationGameDelegate: ApplicationGameDelegate, gameState: GameStateDTO) {
        self.applicationGameDelegate = applicationGameDelegate
        resumeGame(with: gameState)
    }
    
    
    // MARK: - Private Helpers
    
    private func startGame() {
        gameModel = GameModel()
        gameNode = GameNode(frame: applicationGameDelegate.aplicationFrame, gameControllerDelegate: self)
        applicationGameDelegate.presentGame(with: gameNode)
        configureNextRound()
    }
    
    private func resumeGame(with gameState: GameStateDTO) {
        
        gameModel = GameModel(currentQuestionIndex: gameState.currentQuestionIndex,
                              deliveredQuestionIDs: gameState.deliveredQuestionIDs,
                              jokerFiftyFiftyActive: gameState.jokerFiftyFiftyActive,
                              jokerAudienceActive: gameState.jokerAudienceActive)
        gameNode = GameNode(frame: applicationGameDelegate.aplicationFrame, gameControllerDelegate: self)
        applicationGameDelegate.presentGame(with: gameNode)
        
        let questionNumber = gameModel.currentQuestionIndex
        gameNode.configure(with: gameModel.currentQuestion, questionNumber: questionNumber, jokerFiftyFiftyActive: gameModel.jokerFiftyFiftyActive, jokerAudienceActive: gameModel.jokerAudienceActive)
        startRoundTimer()
    }
    
    fileprivate func storeGameState() {
        let gameState = GameStateDTO(currentQuestionIndex: gameModel.currentQuestionIndex,
                                     deliveredQuestionIDs: gameModel.deliveredQuestionIDs,
                                     remainingTime: Int(timeLeft),
                                     jokerFiftyFiftyActive: gameModel.jokerFiftyFiftyActive,
                                     jokerAudienceActive: gameModel.jokerAudienceActive)
        FileStorageService.savegame = gameState
    }
    
    fileprivate func configureNextRound() {
        let question = gameModel.nextQuestion
        let questionNumber = gameModel.currentQuestionIndex
        gameNode.configure(with: question, questionNumber: questionNumber, jokerFiftyFiftyActive: gameModel.jokerFiftyFiftyActive, jokerAudienceActive: gameModel.jokerAudienceActive)
        
        timeLeft = 30
        startRoundTimer()
    }
    
    fileprivate func gameOver() {
        let score = gameModel.currentQuestionIndex
        applicationGameDelegate.didCompleteGame(with: score)
    }
    
    /* Round Timer */
    
    private func startRoundTimer() {
        gameNode.updateTimer(with: timeLeft)
        roundTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }

    @objc private func fireTimer() {
        timeLeft -= 1
        if timeLeft < 0 {
            timerDidRunOut()
            return
        }
        gameNode.updateTimer(with: timeLeft)
    }
    
    private func timerDidRunOut() {
        roundTimer.invalidate()
        gameOver()
    }
}

extension GameController: GameControllerDelegate {
    
    func didSelectAnswerOption(_ option: AnswerOption) {
        roundTimer.invalidate()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let answeredCorrectly = self.gameModel.verifyAnswerOption(option)
            guard answeredCorrectly else {
                self.gameNode.markAsAnsweredIncorrectly(with: option, correctOption: self.gameModel.correctAnswerOption)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.gameOver()
                }
                return
            }
            self.gameNode.markAsAnsweredCorrectly(with: option)
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
            gameNode.activateFiftyFiftyJoker(with: excludedAnswerOptions)
        case .audience:
            gameModel.jokerAudienceActive = false
            // todo
        }
    }
    
    func didSelectPause() {
        storeGameState()
        applicationGameDelegate.didPauseGame()
    }
}
