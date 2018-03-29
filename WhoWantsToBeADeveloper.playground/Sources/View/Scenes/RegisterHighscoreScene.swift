import SpriteKit

class RegisterHighscoreScene: SKScene {
    
    // MARK: - Public Properties
    
    weak var registerHighscoreControllerDelegate: RegisterHighscoreControllerDelegate!
    
    
    // MARK: - Private Properties
    
    private var registerHighscoreNode: RegisterHighscoreNode!
    
    
    // MARK: - Overrides
    
    override func didMove(to view: SKView) {
        size = view.frame.size
        
        if registerHighscoreNode == nil {
            registerHighscoreNode = RegisterHighscoreNode(frame: view.frame, registerHighscoreControllerDelegate: registerHighscoreControllerDelegate)
        }
        addChild(registerHighscoreNode)
    }
    
    override func willMove(from: SKView) {
        removeAllChildren()
    }
    
    
    // MARK: - Public Functions
    
    func configure(with scoreText: NSMutableAttributedString) {
        registerHighscoreNode.configure(with: scoreText)
    }
    
    func configureEnteredName(with name: String) {
        registerHighscoreNode.configureEnterNameNode(with: name)
    }
}
