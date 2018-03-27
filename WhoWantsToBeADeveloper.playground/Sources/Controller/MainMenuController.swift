import Foundation

enum ButtonType {
    case resumeGame
    case newGame
    case presentHighscores
    case presentAbout
}

protocol MainMenuControllerDelegate: class {
    var savegameAvailable: Bool { get }
    func didTapMenuButton(with type: ButtonType)
}

class MainMenuController {
    
    // MARK: - Private Properties
    
    private weak var applicationDelegate: ApplicationDelegate!
    
    private var mainMenuScene: GameScene
    private var mainMenuModel: GameModel
    
    
    // MARK: - Initialization
    
    init(applicationDelegate: ApplicationDelegate) {
        self.applicationDelegate = applicationDelegate
        mainMenuScene = MainMenuScene(mainMenuControllerDelegate: self)
        mainMenuModel = MainMenuModel()
    }
    
    // MARK: - Public Functions
    
    func startMainMenu() {
        applicationDelegate.presentScene(&mainMenuScene)
    }
}

extension MainMenuController: MainMenuControllerDelegate {
    
    var savegameAvailable: Bool {
        return mainMenuModel.savegame != nil
    }
    
    func didTapMenuButton(with type: ButtonType) {
        switch type {
        case .resumeGame:
            applicationDelegate.moveToScene(with: .game(mainMenuModel.savegame!))
        case .newGame:
            applicationDelegate.moveToScene(with: .game)
        case .presentHighscores:
            applicationDelegate.moveToScene(with: .highscores)
        case .presentAbout:
            applicationDelegate.moveToScene(with: .about)
        }
    }
}
