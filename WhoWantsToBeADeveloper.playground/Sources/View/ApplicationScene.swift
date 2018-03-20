import Foundation
import SpriteKit

enum GameMode: Int {
    case classic
    case endless
}

enum NodeType: Int {
    case mainMenu
    case selectGameMode
    case game
    case highscore
    case addQuestion
}

protocol ApplicationDelegate: class {
    var aplicationFrame: CGRect { get }
    func didSelectNode(with nodeType: NodeType)
}

public class ApplicationScene: SKScene {
    
    // MARK: - Private Properties
    
    private var mainMenuNode: MainMenuNode?
//    private var gameModeSelectionNode: GameModeSelectionNode?
    private var gameNode: GameNode?
//    private var highscoreNode: HighscoreNode?
    private var questionAdditionNode: QuestionAdditionNode?
    
    private var currentNodeType: NodeType = .mainMenu
    
    
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
            break
        case .selectGameMode:
            break
        case .game:
            break
        case .highscore:
            break
        case .addQuestion:
            break
        }
    }
}
