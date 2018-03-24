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
    
    
    // MARK: - Private Helpers
    
    private func startGame() {
        gameModel = GameModel()
        gameNode = GameNode(frame: applicationGameDelegate.aplicationFrame, gameControllerDelegate: self)
        applicationGameDelegate.presentGame(with: gameNode)
        configureNextRound()
    }
    
    private func resumeGame() { // todo
        
    }
    
    fileprivate func configureNextRound() {
        let question = gameModel.nextQuestion
        let questionNumber = gameModel.currentQuestionIndex
        gameNode.configure(with: question, questionNumber: questionNumber, jokerFiftyFiftyActive: true, jokerAudienceActive: true) // todo: joker active states
        startRoundTimer()
    }
    
    fileprivate func gameOver() {
        let score = gameModel.currentQuestionIndex
        applicationGameDelegate.didCompleteGame(with: score)
    }
    
    /* Round Timer */
    
    private func startRoundTimer() {
        timeLeft = 30
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
            let excludedAnswerOptions = gameModel.jokerFiftyFiftyExcludedAnswerOptions
            gameNode.activateFiftyFiftyJoker(with: excludedAnswerOptions)
        case .audience:
            break
        }
    }
    
    func didSelectPause() {
        // todo: store game and call applicationGameDelegate method
    }
}
