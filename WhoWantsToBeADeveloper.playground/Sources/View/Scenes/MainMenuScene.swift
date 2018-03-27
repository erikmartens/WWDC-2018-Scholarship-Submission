import SpriteKit

class MainMenuScene: SKScene {
    
    // MARK: - Public Properties
    
    weak var mainMenuControllerDelegate: MainMenuControllerDelegate!
    
    
    // MARK: - Private Properties
    
    private var mainMenuNode: MainMenuNode!
    
    
    // MARK: - Overrides
    
    override public func didMove(to view: SKView) {
        size = view.frame.size
        
        mainMenuNode = MainMenuNode(frame: view.frame, mainMenuControllerDelegate: mainMenuControllerDelegate)
        addChild(mainMenuNode)
    }
    
    
    // MAKR: - Public Functions
    
    func configureResumeAvailable(_ available: Bool) {
        mainMenuNode.configureResumeAvailable(available)
    }
}
