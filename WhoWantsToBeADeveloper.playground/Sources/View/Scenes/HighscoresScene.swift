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
    
    
    // MAKR: - Public Functions
    
    func configure(with highscores: [HighscoreDTO]) {
        highscoresNode.configure(with: highscores)
    }
}
