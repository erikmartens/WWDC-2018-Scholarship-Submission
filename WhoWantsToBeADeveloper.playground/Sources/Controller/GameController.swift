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

    private weak var applicationGameDelegate: ApplicationGameDelegate?

    private var gameNode: GameNode?
    private var gameModel: GameModel?
    
    
    // MARK: - Initialization
    
    init(applicationGameDelegate: ApplicationGameDelegate) {
        self.applicationGameDelegate = applicationGameDelegate
        startGame()
    }
    
    
    // MARK: - Private Helpers

    // force unwrap applicationGameDelegate in method, it should never be nil and if we want to know by crashing
    private func startGame() {
        if gameModel == nil {
            gameModel = GameModel() // todo
        }
        if gameNode == nil {
            gameNode = GameNode(frame: applicationGameDelegate!.aplicationFrame, gameControllerDelegate: self)
        }
        applicationGameDelegate!.presentGame(with: gameNode!)
    }

    private func fireTimer() {
        //gameNodeDelegate?.updateTimer() // todo
    }
    
    private func timerDidRunOut() { // todo
        
    }
}

extension GameController: GameControllerDelegate { // todo
    
    func didSelectAnswerOption(_ option: AnswerOption) {
        
    }
    
    func didSelectJokerOption(_ option: JokerOption) {
        
    }
    
    func didSelectPause() {
        
    }
}
