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
    
    
    // MARK: - Input Event Handlers
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        
        if aboutNode.backButton.contains(location) {
            aboutNode.backButton.fillTexture = kButtonSelectedTexture
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        
        if aboutNode.backButton.contains(location) {
            aboutControllerDelegate.didTapBackButton()
        }
        aboutNode.backButton.fillTexture = kButtonActiveTexture
    }
}
