import SpriteKit

class MainMenuScene: SKScene {
    
    // MARK: - Public Properties
    
    weak var mainMenuControllerDelegate: MainMenuControllerDelegate!
    
    
    // MARK: - Private Properties
    
    private var mainMenuNode: MainMenuNode!
    
    
    // MARK: - Overrides
    
    override func didMove(to view: SKView) {
        size = view.frame.size
        
        if mainMenuNode == nil {
            mainMenuNode = MainMenuNode(frame: view.frame, mainMenuControllerDelegate: mainMenuControllerDelegate)
        }
        addChild(mainMenuNode)
    }
    
    override func willMove(from: SKView) {
        removeAllChildren()
    }
    
    
    // MAKR: - Public Functions
    
    func configureResumeAvailable(_ available: Bool) {
        mainMenuNode.configureResumeAvailable(available)
    }
}
