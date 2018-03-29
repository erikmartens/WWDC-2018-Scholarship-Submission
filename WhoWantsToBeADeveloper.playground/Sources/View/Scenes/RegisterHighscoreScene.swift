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
    
    
    // MARK: - Input Event Handlers
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        
        if registerHighscoreNode.saveButton.contains(location) {
            registerHighscoreNode.saveButton.fillTexture = kButtonSelectedTexture
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        
        if registerHighscoreNode.saveButton.contains(location) {
            registerHighscoreControllerDelegate.didTapSaveButton(withNameEntered: registerHighscoreNode.enteredName ?? "PlayerUnkown")
        }
        registerHighscoreNode.saveButton.fillTexture = kButtonActiveTexture
    }
}
