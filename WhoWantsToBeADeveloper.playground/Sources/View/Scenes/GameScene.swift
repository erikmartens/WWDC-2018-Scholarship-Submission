import SpriteKit

class GameScene: SKScene {
    
    // MARK: - Private Properties
    
    private weak var gameControllerDelegate: GameControllerDelegate!
    private var gameNode: GameNode!
    
    
    // MARK: - Overrides
    
//    override public func sceneDidLoad() {
//
//    }
    
    override public func didMove(to view: SKView) {
        size = view.frame.size
        gameNode = GameNode(frame: view.frame, gameControllerDelegate: gameControllerDelegate)
        addChild(gameNode)
    }
}
