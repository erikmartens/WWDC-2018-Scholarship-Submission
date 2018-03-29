import Foundation

protocol HighscoresControllerDelegate: class {
    func didTapBackButton()
}

class HighscoresController {
    // MARK: - Private Properties
    
    private weak var applicationDelegate: ApplicationDelegate!
    
    private var highscoresScene: HighscoresScene
    private var highscoresModel: HighscoresModel
    
    
    // MARK: - Initialization
    
    init(applicationDelegate: ApplicationDelegate) {
        self.applicationDelegate = applicationDelegate
        
        highscoresScene = HighscoresScene()
        highscoresModel = HighscoresModel()
    }
    
    
    // MARK: - Public Functions
    
    func startHighscores() {
        highscoresScene.highscoresControllerDelegate = self
        applicationDelegate.presentScene(highscoresScene)
        highscoresScene.configure(with: highscoresModel.highscores)
    }
}

extension HighscoresController: HighscoresControllerDelegate {
    
    func didTapBackButton() {
        applicationDelegate.moveToScene(with: .mainMenu)
    }
}
