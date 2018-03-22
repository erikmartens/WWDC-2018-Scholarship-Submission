import Foundation

enum AnswerOption: Int {
    case optionA
    case optionB
    case optionC
    case optionD
}

enum JokerOption: Int {
    case fiftyFifty
    case audience
}

protocol GameControllerDelegate {
    func didSelectAnswerOption(_ option: AnswerOption)
    func didSelectJokerOption(_ option: JokerOption)
    func didSelectExit()
}

class GameController {
    
    // MARK: - Private Properties
    
    private weak var applicationDelegate: ApplicationDelegate?
    private weak var gameNodeDelegate: GameNodeDelegate?
    private weak var gameModelDelegate: GameModelDelegate?
    
    
    // MARK: - Initialization
    
    init(applicationDelegate: ApplicationDelegate?, gameNodeDelegate: GameNodeDelegate, gameModelDelegate: GameModelDelegate) {
        self.applicationDelegate = applicationDelegate
        self.gameNodeDelegate = gameNodeDelegate
        self.gameModelDelegate = gameModelDelegate
    }
    
    
    // MARK: - Private Helpers
    
    private func timerDidRunOut() { // todo
        
    }
}

extension GameController: GameControllerDelegate { // todo
    
    func didSelectAnswerOption(_ option: AnswerOption) {
        
    }
    
    func didSelectJokerOption(_ option: JokerOption) {
        
    }
    
    func didSelectExit() {
        
    }
}
