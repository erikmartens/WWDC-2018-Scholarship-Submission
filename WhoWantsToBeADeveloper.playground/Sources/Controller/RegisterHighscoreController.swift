import Foundation

fileprivate let kPlayNameSubstitute = "PlayerUnknown"

protocol RegisterHighscoreControllerDelegate: class {
    func didTapSaveButton()
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
        registerHighscoreScene.configure(with: registerHighscoreModel.scoreText, name: registerHighscoreModel.playerName ?? kPlayNameSubstitute)
    }
}

extension RegisterHighscoreController: RegisterHighscoreControllerDelegate {
    
    func didTapSaveButton() {
        let name = registerHighscoreModel.playerName ?? kPlayNameSubstitute
        let highscore = HighscoreDTO(score: registerHighscoreModel.score, name: name, date: Date())
        FileStorageService.appendHighscore(highscore)
        applicationDelegate.moveToScene(with: .mainMenu)
    }
}
