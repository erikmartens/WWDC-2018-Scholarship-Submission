import SpriteKit

class HighscoresScene: SKScene {
    
    // MARK: - Public Properties
    
    weak var highscoresControllerDelegate: HighscoresControllerDelegate!
    
    
    // MARK: - Private Properties
    
    private var highscoresNode: HighscoresNode!
    
    
    // MARK: - Overrides
    
    override func didMove(to view: SKView) {
        size = view.frame.size
        
        if highscoresNode == nil {
            highscoresNode = HighscoresNode(frame: view.frame, highscoresControllerDelegate: highscoresControllerDelegate)
        }
        addChild(highscoresNode)
    }
    
    override func willMove(from: SKView) {
        removeAllChildren()
    }
    
    
    // MARK: - Public Functions
    
    func configure(with highscores: [HighscoreDTO]) {
        highscoresNode.configure(with: highscores)
    }
    
    
    // MARK: - Input Event Handlers
    
    override func mouseDown(with event: NSEvent) {
        let mousePoint = convertPoint(fromView: CGPoint(x: event.locationInWindow.x, y: event.locationInWindow.y))
        guard let touchedNode = nodes(at: mousePoint).first else {
            return
        }
        if touchedNode == highscoresNode.backButton {
            highscoresNode.backButton.fillTexture = kButtonSelectedTexture
        }
    }
    
    override func mouseUp(with event: NSEvent) {
        let mousePoint = convertPoint(fromView: CGPoint(x: event.locationInWindow.x, y: event.locationInWindow.y))
        guard let touchedNode = nodes(at: mousePoint).first else {
            return
        }
        if touchedNode == highscoresNode.backButton {
            highscoresControllerDelegate.didTapBackButton()
        }
        highscoresNode.backButton.fillTexture = kButtonActiveTexture
    }
}
