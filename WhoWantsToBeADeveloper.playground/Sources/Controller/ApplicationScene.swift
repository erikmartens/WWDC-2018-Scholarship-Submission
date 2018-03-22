import Foundation
import SpriteKit

enum NodeType: Int {
    case mainMenu
    case game
    case highscores
    case addQuestion
}

protocol ApplicationDelegate: class {
    var aplicationFrame: CGRect { get }
    func didSelectNode(with nodeType: NodeType)
}

protocol ApplicationGameDelegate: class {
    var aplicationFrame: CGRect { get }
    func presentGame(with gameNode: GameNode)
    func didPauseGame(with state: GameStateDTO)
    func didCompleteGame(with score: Int)
}

public class ApplicationScene: SKScene {
    
    // MARK: - Private Properties
    
    private var mainMenuNode: MainMenuNode?
    private var highscoresNode: HighscoresNode?
    private var questionAdditionNode: QuestionAdditionNode?
    
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
}

extension ApplicationScene: ApplicationDelegate {
    
    var aplicationFrame: CGRect {
        get {
            return frame
        }
    }
    
    func didSelectNode(with nodeType: NodeType) {
        switch nodeType {
        case .mainMenu:
            if mainMenuNode == nil {
                mainMenuNode = MainMenuNode(applicationDelegate: self)
            }
            removeAllChildren()
            addChild(mainMenuNode!)
        case .game:
            if gameController == nil {
                gameController = GameController(applicationGameDelegate: self)
            }
        case .highscores:
            if highscoresNode == nil {
                highscoresNode = HighscoresNode(applicationDelegate: self)
            }
            removeAllChildren()
            addChild(highscoresNode!)
        case .addQuestion:
            break
        }
    }
}

extension ApplicationScene: ApplicationGameDelegate {
    
    func presentGame(with gameNode: GameNode) {
        removeAllChildren()
        addChild(gameNode)
    }
    
    func didPauseGame(with state: GameStateDTO) {
        if mainMenuNode == nil {
            mainMenuNode = MainMenuNode(applicationDelegate: self)
        }
        // todo store game state
        // activate resume button
        removeAllChildren()
        addChild(mainMenuNode!)
        gameController = nil
    }
    
    func didCompleteGame(with score: Int) {
        if highscoresNode == nil {
            //highscoresNode = highscoresNode(applicationDelegate: self, score: Int) // todo
        }
        removeAllChildren()
        addChild(highscoresNode!)
        gameController = nil
    }
}
