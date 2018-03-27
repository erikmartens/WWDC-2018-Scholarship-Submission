import SpriteKit

class MainMenuScene: SKScene {
    
    // MARK: - Private Properties
    
    private weak var mainMenuControllerDelegate: MainMenuControllerDelegate!
    private var mainMenuNode: MainMenuNode!
    
    
    // MARK: - Overrides
    
    override public func didMove(to view: SKView) {
        size = view.frame.size
        mainMenuNode = MainMenuNode(frame: view.frame, mainMenuControllerDelegate: mainMenuControllerDelegate)
        addChild(mainMenuNode)
        mainMenuNode.configureResumeAvailable()
    }
}
