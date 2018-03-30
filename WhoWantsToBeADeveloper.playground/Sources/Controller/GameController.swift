import Foundation
import SpriteKit

protocol GameControllerDelegate: class {
    var jokerActive: Bool { get set }
    var gameMusicActive: Bool { get }
    func didSelectAnswerOption(_ option: AnswerOption)
    func didSelectJoker()
    func didSelectPause()
    func didSelectDeactivateMusic()
}

class GameController {
    
    // MARK: - Private Properties
    
    private weak var applicationDelegate: ApplicationDelegate!
    
    private var gameScene: GameScene
    private var gameModel: GameModel
    
    private var roundTimer: Timer!
    private var timeLeft: TimeInterval = 0
    
    private var musicActive = true
    
    // MARK: - Initialization
    
    init(applicationDelegate: ApplicationDelegate) {
        self.applicationDelegate = applicationDelegate
        
        gameScene = GameScene()
        gameModel = GameModel()
    }
    
    
    // MARK: - Public Functions
    
    func startGame(with savegame: SavegameDTO?) {
        musicActive = true
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
        
        gameScene.playGameMusic()
    }
    
    
    // MARK: - Private Helpers
    
    fileprivate func gameOver() {
        gameScene.stopGameMusic()
        let score = gameModel.currentQuestionIndex
        applicationDelegate.moveToScene(with: .registerHighscore(score))
    }
    
    fileprivate func storeGameState() {
        let savegame = SavegameDTO(currentQuestionIndex: gameModel.currentQuestionIndex,
                                   deliveredQuestionIDs: gameModel.deliveredQuestionIDs,
                                   remainingTime: timeLeft,
                                   jokerActive: gameModel.jokerActive,
                                   roundsUntilJokerReactivation: gameModel.roundsUntilJokerReactivation)
        FileStorageService.savegame = savegame
    }
    
    private func configureResumeRound() {
        let question = gameModel.currentQuestion!
        let questionIndex = gameModel.currentQuestionIndex
        gameScene.configure(with: question, questionIndex: questionIndex)
        startRoundTimer()
    }
    
    fileprivate func configureNextRound(with timeLeft: TimeInterval = 30) {
        let question = gameModel.nextQuestion
        let questionIndex = gameModel.currentQuestionIndex
        if !jokerActive {
            gameModel.roundsUntilJokerReactivation -= 1
        }
        if gameModel.roundsUntilJokerReactivation == 0 {
            gameModel.jokerActive = true
        }
        gameScene.configure(with: question, questionIndex: questionIndex)
        
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
    
    var jokerActive: Bool {
        get { return gameModel.jokerActive }
        set { gameModel.jokerActive = newValue }
    }
    
    var gameMusicActive: Bool {
        return musicActive
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
    
    func didSelectJoker() {
        gameModel.jokerActive = false
        gameModel.roundsUntilJokerReactivation = 10
        let excludedAnswerOptions = gameModel.jokerFiftyFiftyExcludedAnswerOptions
        gameScene.activateJoker(with: excludedAnswerOptions)
    }
    
    func didSelectPause() {
        roundTimer.invalidate()
        storeGameState()
        applicationDelegate.moveToScene(with: .mainMenu)
    }
    
    func didSelectDeactivateMusic() {
        musicActive = !musicActive
        gameScene.deactivateGameMusic(!musicActive)
    }
}
