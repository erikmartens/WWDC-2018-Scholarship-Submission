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
        let questionNumber = gameModel.currentQuestionIndex + 1
        gameNode.configure(with: question, questionNumber: questionNumber, jokerFiftyFiftyActive: true, jokerAudienceActive: true) // todo: joker active states
        // todo: activate timer
    }
    
    fileprivate func gameOver() {
        let score = gameModel.currentQuestionIndex + 1
        applicationGameDelegate.didCompleteGame(with: score)
    }

    private func fireTimer() {
        //gameNodeDelegate?.updateTimer() // todo
    }
    
    @objc private func timerDidRunOut() { // todo
        
    }
}

extension GameController: GameControllerDelegate { // todo
    
    func didSelectAnswerOption(_ option: AnswerOption) {
        let answeredCorrectly = gameModel.verifyAnswerOption(option)
        guard answeredCorrectly else {
            gameOver()
            return
        }
        configureNextRound()
    }
    
    func didSelectJokerOption(_ option: JokerOption) {
        
    }
    
    func didSelectPause() {
        // todo: store game and call applicationGameDelegate method
    }
}
