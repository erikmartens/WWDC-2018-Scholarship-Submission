import SpriteKit

enum SceneType {
    case mainMenu
    case game(SaveGameDTO?)
    case registerHighscore
    case highscores
    case about
}

protocol ApplicationDelegate: class {
    func moveToScene(with type: SceneType)
    func presentScene(_ scene: SKScene)
}

class ApplicationMain {
    
    // MARK: - Properties
    
    private let view: SKView
    
    private var gameController: GameController?
    
    private var mainMenuController: MainMenuController?
    
    private var registerHighscoreScene: SKScene?
    private var highscoresScene: SKScene?
    private var aboutScene: SKScene?
    
    
    // MARK: - Initialization
    
    init(view: SKView) {
        self.view = view
    }
    
    
    // MARK: - Private Helpers
    
    /**
     * Starts the game
     * The initial scene is always the main menu
     */
    public func run() {
        if mainMenuController == nil {
            mainMenuController = MainMenuController(applicationDelegate: self)
        }
        mainMenuController!.startMainMenu()
    }
}

extension ApplicationMain: ApplicationDelegate {
    
    func moveToScene(with type: SceneType) {
        switch type {
        case .mainMenu:
            break
        case .game(let savegame):
            if gameController == nil {
                gameController = savegame != nil ? GameController(savegame: savegame!) : GameModel()
            }
            gameController.startGame()
        case .registerHighscore:
            break
        case .highscores:
            break
        case .about:
            break
        }
    }
    
    func presentScene(_ scene: inout SKScene) {
        scene.scaleMode = .aspectFit
        view.presentScene(scene, transition: .fade(withDuration: 1.0))
    }
}
