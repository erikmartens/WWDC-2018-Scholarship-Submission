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

//protocol HighscoreControllerDelegate: class {
//    func triggerNameEntryAlertController(completionHandler: @escaping ((String?) -> Void))
//    func didCompleteHighscoreInput(with playerName: String?)
//}

class GameController {
    
    // MARK: - Private Properties
    
    private weak var applicationDelegate: ApplicationDelegate!
    
    private var gameScene: GameScene
    private var gameModel: GameModel
    
    private var roundTimer: Timer!
    private var timeLeft: TimeInterval = 0
    
    private var registerHighscoreNode: RegisterHighscoreNode?
    
    
    // MARK: - Initialization
    
    init(applicationDelegate: ApplicationDelegate, savegame: SavegameDTO?) {
        self.applicationDelegate = applicationDelegate
        
        gameScene = GameScene(gameControllerDelegate: self)
        
        if let savegame = savegame {
            gameModel = GameModel(savegame: SaveGameDTO)
            timeLeft = savegame.remainingTime
            return
        }
        gameModel = GameModel()
        timeLeft = 30
    }
    
    
    // MARK: - Public Functions
    
    func startGame() {
        applicationDelegate.presentScene(&gameScene)
        configureNextRound(timeLeft: timeLeft)
    }
    
    
    // MARK: - Private Helpers
    
    fileprivate func gameOver() {
        let score = gameModel.currentQuestionIndex
//        if registerHighscoreNode == nil {
//            registerHighscoreNode = RegisterHighscoreNode(frame: applicationGameDelegate.applicationFrame, highscoreControllerDelegate: self, score: score)
//        }
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
    
    func didSelectAnswerOption(_ option: AnswerOption) {
        roundTimer.invalidate()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let answeredCorrectly = self.gameModel.verifyAnswerOption(option)
            guard answeredCorrectly else {
                self.gameScene.markAsAnsweredIncorrectly(with: option, correctOption: self.gameModel.correctAnswerOption)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
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
        applicationDelegate.didPauseGame()
    }
}

//extension GameController: HighscoreControllerDelegate {
//
//    func triggerNameEntryAlertController(completionHandler: @escaping ((String?) -> Void)) {
//        applicationDelegate.presentNameEntryAlertController(completionHandler: completionHandler)
//    }
//
//    func didCompleteHighscoreInput(with playerName: String?) {
//        let name = (playerName != nil && !playerName!.isEmpty) ? playerName! : "PlayerUnknown"
//        let highscore = HighscoreDTO(score: gameModel.currentQuestionIndex + 1, name: name, date: Date())
//        applicationDelegate.didCompleteGame(with: highscore)
//    }
//}

