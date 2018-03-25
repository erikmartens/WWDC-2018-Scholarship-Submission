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
    func presentNode(_ node: SKSpriteNode)
    func didPauseGame()
    func presentNameEntryAlertController(completionHandler: @escaping ((String?) -> Void))
    func didCompleteGame(with highscore: HighscoreDTO)
}

public class ApplicationScene: SKScene {
    
    // MARK: - Private Properties
    
    private var encapsulatingView: SKView?
    
    private var mainMenuNode: MainMenuNode?
    private var highscoresNode: HighscoresNode?
    private var aboutNode: AboutNode?

    private var gameController: GameController?
    
    
    // MARK: - Setup
    
    override public func didMove(to view: SKView) {
        encapsulatingView = view
        size = view.frame.size
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
    
    func presentNode(_ node: SKSpriteNode) {
        removeAllChildren()
        addChild(node)
    }
    
    func didPauseGame() {
        presentMainMenu {
            self.gameController = nil
        }
    }
    
    func presentNameEntryAlertController(completionHandler: @escaping ((String?) -> Void)) {
        let alertController = UIAlertController(title: "Enter Your Name", message: "", preferredStyle: .alert)
        alertController.addTextField { $0.placeholder = nil }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            completionHandler(alertController.textFields?[0].text)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        let rootViewController = encapsulatingView?.window?.rootViewController
        if rootViewController?.presentedViewController == nil  {
            rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    func didCompleteGame(with highscore: HighscoreDTO) {
        FileStorageService.appendHighscore(highscore)
        presentMainMenu {
            self.gameController = nil
        }
    }
}
