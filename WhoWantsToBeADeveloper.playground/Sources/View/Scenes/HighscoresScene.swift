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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        
        if highscoresNode.backButton.contains(location) {
            highscoresNode.backButton.fillTexture = kButtonSelectedTexture
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        
        if highscoresNode.backButton.contains(location) {
            highscoresControllerDelegate.didTapBackButton()
        }
        highscoresNode.backButton.fillTexture = kButtonActiveTexture
    }
}
