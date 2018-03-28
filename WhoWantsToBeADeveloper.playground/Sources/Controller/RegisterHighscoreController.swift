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
}
