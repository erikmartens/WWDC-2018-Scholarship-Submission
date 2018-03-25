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

protocol HighscoreControllerDelegate: class {
    func triggerNameEntryAlertController(completionHandler: @escaping ((String?) -> Void))
    func didCompleteHighscoreInput(with playerName: String?)
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
    
    private var registerHighscoreNode: RegisterHighscoreNode?
    
    
    // MARK: - Initialization
    
    init(applicationGameDelegate: ApplicationGameDelegate) {
        self.applicationGameDelegate = applicationGameDelegate
        startGame()
    }
    
    init(applicationGameDelegate: ApplicationGameDelegate, savegame: SavegameDTO) {
        self.applicationGameDelegate = applicationGameDelegate
        resumeGame(with: savegame)
    }
    
    
    // MARK: - Private Helpers
    
    private func startGame() {
        gameModel = GameModel()
        gameNode = GameNode(frame: applicationGameDelegate.aplicationFrame, gameControllerDelegate: self)
        applicationGameDelegate.presentNode(gameNode)
        configureNextRound()
    }
    
    fileprivate func gameOver() {
        let score = gameModel.currentQuestionIndex
        if registerHighscoreNode == nil {
            registerHighscoreNode = RegisterHighscoreNode(frame: applicationGameDelegate.aplicationFrame, highscoreControllerDelegate: self, score: score)
        }
        applicationGameDelegate.presentNode(registerHighscoreNode!)
    }
    
    fileprivate func storeGameState() {
        let savegame = SavegameDTO(currentQuestionIndex: gameModel.currentQuestionIndex,
                                   deliveredQuestionIDs: gameModel.deliveredQuestionIDs,
                                   remainingTime: timeLeft,
                                   jokerFiftyFiftyActive: gameModel.jokerFiftyFiftyActive,
                                   jokerAudienceActive: gameModel.jokerAudienceActive)
        FileStorageService.savegame = savegame
    }
    
    private func resumeGame(with savegame: SavegameDTO) {
        gameModel = GameModel(currentQuestionIndex: savegame.currentQuestionIndex,
                              deliveredQuestionIDs: savegame.deliveredQuestionIDs,
                              jokerFiftyFiftyActive: savegame.jokerFiftyFiftyActive,
                              jokerAudienceActive: savegame.jokerAudienceActive)
        gameNode = GameNode(frame: applicationGameDelegate.aplicationFrame, gameControllerDelegate: self)
        applicationGameDelegate.presentNode(gameNode)
        
        let questionNumber = gameModel.currentQuestionIndex
        gameNode.configure(with: gameModel.currentQuestion, questionNumber: questionNumber, jokerFiftyFiftyActive: gameModel.jokerFiftyFiftyActive, jokerAudienceActive: gameModel.jokerAudienceActive)
        timeLeft = savegame.remainingTime
        startRoundTimer()
    }
    
    fileprivate func configureNextRound() {
        let question = gameModel.nextQuestion
        let questionNumber = gameModel.currentQuestionIndex
        gameNode.configure(with: question, questionNumber: questionNumber, jokerFiftyFiftyActive: gameModel.jokerFiftyFiftyActive, jokerAudienceActive: gameModel.jokerAudienceActive)
        
        timeLeft = 30
        startRoundTimer()
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
        roundTimer.invalidate()
        storeGameState()
        applicationGameDelegate.didPauseGame()
    }
}

extension GameController: HighscoreControllerDelegate {
    
    func triggerNameEntryAlertController(completionHandler: @escaping ((String?) -> Void)) {
        applicationGameDelegate.presentNameEntryAlertController(completionHandler: completionHandler)
    }
    
    func didCompleteHighscoreInput(with playerName: String?) {
        let name = (playerName != nil && !playerName!.isEmpty) ? playerName! : "PlayerUnknown"
        let highscore = HighscoreDTO(score: gameModel.currentQuestionIndex, name: name, date: Date())
        applicationGameDelegate.didCompleteGame(with: highscore)
    }
}
