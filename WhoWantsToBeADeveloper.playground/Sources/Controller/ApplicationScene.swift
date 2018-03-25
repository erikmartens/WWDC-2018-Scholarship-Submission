import Foundation
import SpriteKit

enum NodeType: Int {
    case mainMenu
    case resume
    case game
    case highscores
    case about
}

protocol ApplicationDelegate: class {
    var aplicationFrame: CGRect { get }
    var savegameAvailable: Bool { get }
    func didSelectNode(with nodeType: NodeType)
}

protocol ApplicationGameDelegate: class {
    var aplicationFrame: CGRect { get }
    func presentGame(with gameNode: GameNode)
    func didPauseGame()
    func didCompleteGame(with score: Int)
}

public class ApplicationScene: SKScene {
    
    // MARK: - Private Properties
    
    private var mainMenuNode: MainMenuNode?
    private var highscoresNode: HighscoresNode?
    private var aboutNode: AboutNode?
    
    private var gameController: GameController?
    
    
    // MARK: - Setup
    
    override public func didMove(to view: SKView) {
        self.size = view.frame.size
        run()
    }
    
    
    // MARK: - Private Helpers
    
    /**
     * Starts the game
     * The initial scene is always the main menu
     */
    private func run() {
        if mainMenuNode == nil {
            mainMenuNode = MainMenuNode(applicationDelegate: self)
        }
        addChild(mainMenuNode!)
    }
    
    /* Presenting Views */
    
    fileprivate func presentMainMenu(completionHandler: (() -> Void)? = nil) {
        if mainMenuNode == nil {
            mainMenuNode = MainMenuNode(applicationDelegate: self)
        }
        removeAllChildren()
        addChild(mainMenuNode!)
        mainMenuNode!.configureResumeAvailable()
        completionHandler?()
    }
}

extension ApplicationScene: ApplicationDelegate {
    
    var aplicationFrame: CGRect {
        get {
            return frame
        }
    }
    
    var savegameAvailable: Bool {
        return FileStorageService.savegame != nil
    }
    
    func didSelectNode(with nodeType: NodeType) {
        switch nodeType {
        case .mainMenu:
            presentMainMenu()
        case .resume:
            // force unwrap savegame, this should not be nil at this point. If it is something went wrong and we need to know by crashing
            let savegame = FileStorageService.savegame!
            FileStorageService.invalidateSavegame()
            if gameController == nil {
                gameController = GameController(applicationGameDelegate: self, savegame: savegame)
            }
        case .game:
            if gameController == nil {
                gameController = GameController(applicationGameDelegate: self) // game controller init starts game automatically
            }
        case .highscores:
            if highscoresNode == nil {
                highscoresNode = HighscoresNode(applicationDelegate: self)
            }
            removeAllChildren()
            addChild(highscoresNode!)
        case .about:
            if aboutNode == nil {
                aboutNode = AboutNode(applicationDelegate: self)
            }
            removeAllChildren()
            addChild(aboutNode!)
        }
    }
}

extension ApplicationScene: ApplicationGameDelegate {
    
    func presentGame(with gameNode: GameNode) {
        removeAllChildren()
        addChild(gameNode)
    }
    
    func didPauseGame() {
        presentMainMenu {
            self.gameController = nil
        }
    }
    
    func didCompleteGame(with score: Int) {
        /* test code -> remove */
        presentMainMenu {
            self.gameController = nil
        }
        /* test code -> remove */
        
//        if highscoresNode == nil {
//            //highscoresNode = highscoresNode(applicationDelegate: self, score: Int) // todo
//        }
//        removeAllChildren()
//        addChild(highscoresNode!)
//        gameController = nil
    }
}
