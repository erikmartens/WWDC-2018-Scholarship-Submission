import SpriteKit

class AboutScene: SKScene {
    
    // MARK: - Public Properties
    
    weak var aboutControllerDelegate: AboutControllerDelegate!
    
    
    // MARK: - Private Properties
    
    private var aboutNode: AboutNode!
    
    
    // MARK: - Overrides
    
    override func didMove(to view: SKView) {
        size = view.frame.size
        
        if aboutNode == nil {
            aboutNode = AboutNode(frame: view.frame, aboutControllerDelegate: aboutControllerDelegate)
        }
        addChild(aboutNode)
    }
    
    override func willMove(from: SKView) {
        removeAllChildren()
    }
    
    
    // MARK: - Public Functions
    
    func configure(with aboutText: NSMutableAttributedString) {
        aboutNode.configure(with: aboutText)
    }
}
