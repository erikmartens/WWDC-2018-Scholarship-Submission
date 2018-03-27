import Foundation

import Foundation

protocol RegisterHighscoreControllerDelegate: class {
    func didTapSaveButton(withNameEntered name: String)
}

class RegisterHighscoreController {
    // MARK: - Private Properties
    
    private weak var applicationDelegate: ApplicationDelegate!
    
    private var registerHighscoreScene: RegisterHighscoreScene
    private var registerHighscoreModel: RegisterHighscoreModel
    
    
    // MARK: - Initialization
    
    init(applicationDelegate: ApplicationDelegate, score: Int) {
        self.applicationDelegate = applicationDelegate
        
        registerHighscoreScene = RegisterHighscoreScene()
        registerHighscoreModel = RegisterHighscoreModel(score: score)
    }
    
    
    // MARK: - Public Functions
    
    func startRegisterHighscore() {
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
}
