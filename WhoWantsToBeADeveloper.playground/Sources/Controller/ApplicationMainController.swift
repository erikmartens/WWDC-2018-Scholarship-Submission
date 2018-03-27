import SpriteKit

enum SceneType {
    case mainMenu
    case game(SavegameDTO?)
    case registerHighscore(Int)
    case highscores
    case about
}

protocol ApplicationDelegate: class {
    func moveToScene(with type: SceneType)
    func presentScene(_ scene: SKScene)
}

class ApplicationMainController {
    
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

extension ApplicationMainController: ApplicationDelegate {
    
    func moveToScene(with type: SceneType) {
        switch type {
        case .mainMenu:
            if mainMenuController == nil {
                mainMenuController = MainMenuController(applicationDelegate: self)
            }
            mainMenuController.startMainMenue()
        case .game(let savegame):
            if gameController == nil {
                gameController = GameController(applicationDelegate: self, savegame: savegame)
            }
            gameController.startGame()
        case .registerHighscore(let score):
            break
        case .highscores:
            break
        case .about:
            break
        }
    }
    
    func presentScene(_ scene: SKScene) {
        scene.scaleMode = .aspectFit
        view.presentScene(scene, transition: .fade(withDuration: 1.0))
    }
}
