import SpriteKit

public class LoadingScene: SKScene {
    
    // MARK: - Private Properties
    
    public var loadingNode: SKSpriteNode!
    
    
    // MARK: - Overrides
    
    override public func didMove(to view: SKView) {
        size = view.frame.size
        
        if loadingNode == nil {
            loadingNode = LoadingNode(frame: view.frame)
        }
        addChild(loadingNode)
    }
    
    override public func willMove(from: SKView) {
        removeAllChildren()
    }
}
