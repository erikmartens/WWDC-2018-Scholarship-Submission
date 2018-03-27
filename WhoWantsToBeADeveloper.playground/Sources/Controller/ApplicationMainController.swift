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

public class ApplicationMainController: NSObject {
    
    // MARK: - Properties
    
    private let view: SKView
    
    private var mainMenuController: MainMenuController?
    private var gameController: GameController?
    private var highscoresController: HighscoresController?
    
    
    // MARK: - Initialization
    
    public init(view: SKView) {
        self.view = view
    }
    
    
    // MARK: - Private Helpers
    
    /**
     * Starts the game
     * The initial scene is always the main menu
     */
    public func runApplication() {
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
            mainMenuController!.startMainMenu()
        case .game(let savegame):
            if gameController == nil {
                gameController = GameController(applicationDelegate: self, savegame: savegame)
            }
            gameController!.startGame()
        case .registerHighscore(let score):
            break
        case .highscores:
            if highscoresController == nil {
                highscoresController = HighscoresController(applicationDelegate: self)
            }
            highscoresController!.startHighscores()
        case .about:
            break
        }
    }
    
    func presentScene(_ scene: SKScene) {
        scene.scaleMode = .aspectFit
        
        let transition = SKTransition.fade(withDuration: 0.2)
        transition.pausesOutgoingScene = true
        view.presentScene(scene, transition: transition)
    }
}
