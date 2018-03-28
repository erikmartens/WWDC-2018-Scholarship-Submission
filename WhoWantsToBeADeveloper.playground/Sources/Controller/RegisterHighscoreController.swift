import Foundation

import Foundation

enum KeyType {
    case character(String, String)
    case enter(String)
    case backspace(String)
}

protocol RegisterHighscoreControllerDelegate: class {
    func didTapSaveButton(withNameEntered name: String)
    func didPressKeyboardKey(_ type: KeyType)
}

class RegisterHighscoreController {
    // MARK: - Private Properties
    
    private weak var applicationDelegate: ApplicationDelegate!
    
    private var registerHighscoreScene: RegisterHighscoreScene
    private var registerHighscoreModel: RegisterHighscoreModel
    
    
    // MARK: - Initialization
    
    init(applicationDelegate: ApplicationDelegate) {
        self.applicationDelegate = applicationDelegate
        
        registerHighscoreScene = RegisterHighscoreScene()
        registerHighscoreModel = RegisterHighscoreModel()
    }
    
    
    // MARK: - Public Functions
    
    func startRegisterHighscore(with score: Int) {
        registerHighscoreModel.score = score
        registerHighscoreScene.registerHighscoreControllerDelegate = self
        
        applicationDelegate.presentScene(registerHighscoreScene)
        registerHighscoreScene.configure(with: registerHighscoreModel.scoreText)
    }
}

extension RegisterHighscoreController: RegisterHighscoreControllerDelegate {
    
    func didTapSaveButton(withNameEntered name: String) {
        let highscore = HighscoreDTO(score: registerHighscoreModel.score, name: name, date: Date())
        FileStorageService.appendHighscore(highscore)
        applicationDelegate.moveToScene(with: .mainMenu)
    }
    
    func didPressKeyboardKey(_ type: KeyType) {
        switch type {
        case .character(let currentName, let char):
            let newName = currentName + char
            registerHighscoreScene.configureEnteredName(with: newName)
        case .enter(let currentName):
            let highscore = HighscoreDTO(score: registerHighscoreModel.score, name: currentName, date: Date())
            FileStorageService.appendHighscore(highscore)
            applicationDelegate.moveToScene(with: .mainMenu)
        case .backspace(let currentName):
            let newName = currentName.substring(to: currentName.index(before: currentName.endIndex))
            registerHighscoreScene.configureEnteredName(with: newName)
        }
    }
}
