import Foundation

enum ButtonType {
    case resumeGame
    case newGame
    case presentHighscores
    case presentAbout
}

protocol MainMenuControllerDelegate: class {
    var resumeAvailable: Bool { get }
    func didTapMenuButton(with type: ButtonType)
}

class MainMenuController {
    
    // MARK: - Private Properties
    
    private weak var applicationDelegate: ApplicationDelegate!
    
    private var mainMenuScene: MainMenuScene
    private var mainMenuModel: MainMenuModel
    
    
    // MARK: - Initialization
    
    init(applicationDelegate: ApplicationDelegate) {
        self.applicationDelegate = applicationDelegate
        
        mainMenuScene = MainMenuScene()
        mainMenuModel = MainMenuModel()
    }
    
    
    // MARK: - Public Functions
    
    func startMainMenu() {
        mainMenuScene.mainMenuControllerDelegate = self
        applicationDelegate.presentScene(mainMenuScene)
        mainMenuScene.configureResumeAvailable(mainMenuModel.savegame != nil)
    }
}

extension MainMenuController: MainMenuControllerDelegate {
    
    var resumeAvailable: Bool {
        return mainMenuModel.savegame != nil
    }
    
    func didTapMenuButton(with type: ButtonType) {
        switch type {
        case .resumeGame:
            applicationDelegate.moveToScene(with: .game(mainMenuModel.savegame!))
        case .newGame:
            applicationDelegate.moveToScene(with: .game(nil))
        case .presentHighscores:
            applicationDelegate.moveToScene(with: .highscores)
        case .presentAbout:
            applicationDelegate.moveToScene(with: .about)
        }
    }
}
