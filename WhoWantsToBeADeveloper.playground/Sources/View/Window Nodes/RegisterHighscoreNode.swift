import SpriteKit

class RegisterHighscoreNode: SKSpriteNode {
    
    // MARK: - Private Properties
    
    private weak var registerHighscoreControllerDelegate: RegisterHighscoreControllerDelegate!
    
    private var instructionLabel: LabelNode!
    private var nameNode: TextEntryNode!
    private var saveButton: ButtonNode!
    
    
    // MARK: - Initialization
    
    init(frame: CGRect, registerHighscoreControllerDelegate: RegisterHighscoreControllerDelegate) {
        
        super.init(texture: nil, color: .clear, size: .zero)
        
        /* Additional Configuration */
        isUserInteractionEnabled = true
        size = CGSize(width: frame.size.width, height: frame.size.height)
        position = CGPoint(x: frame.midX, y: frame.midY)
        texture = SKTexture(imageNamed: "Images/background")
        
        /* Definitions */
        let instructionNodeHeight = size.height * 0.25
        let instructionNodeSize = CGSize(width: size.width, height: instructionNodeHeight)
        
        let nameNodeWidth = size.width * 0.75
        let nameNodeHeight = size.height * 0.25
        let nameNodeSize = CGSize(width: nameNodeWidth, height: nameNodeHeight)
        
        let verticalButtonSpace = (size.height * 0.75) / CGFloat(6)
        let horizontalPadding = size.width * 0.1
        let verticalPadding = verticalButtonSpace * 0.1
        let buttonSizeSmall = CGSize(width: size.width / 2 - 2 * horizontalPadding, height: verticalButtonSpace - 2 * verticalPadding)
        
        /* Initialize and configure all properties */
        self.registerHighscoreControllerDelegate = registerHighscoreControllerDelegate
        
        instructionLabel = LabelNode(size: instructionNodeSize)
        let instructionLabelCoordinateY = size.height / CGFloat(2) - instructionNodeHeight / CGFloat(2)
        instructionLabel.position = CGPoint(x: 0, y: instructionLabelCoordinateY)
        
        nameNode = TextEntryNode(size: nameNodeSize, labelNodeText: "Your Name:")
        nameNode.position = CGPoint(x: 0, y: 0)
        
        saveButton = ButtonNode(size: buttonSizeSmall, labelText: "Save", backgroundTexture: kButtonActiveTexture)
        let saveButtonCoordinateY = verticalButtonSpace * 3 + verticalButtonSpace / CGFloat(2)
        saveButton.position = CGPoint(x: 0, y: -saveButtonCoordinateY)
        
        addChild(instructionLabel)
        addChild(nameNode)
        addChild(saveButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init?(coder:) is not implemented")
    }

    
    // MARK: - Public Functions & Properties
    
    func configure(with scoreText: NSMutableAttributedString, name: String) {
        instructionLabel.labelAttributedText = scoreText
        nameNode.enteredText = name
    }
    
    
    // MARK: - Input Event Handlers
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        
        if saveButton.contains(location) {
            saveButton.fillTexture = kButtonSelectedTexture
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        
        if saveButton.contains(location) {
            registerHighscoreControllerDelegate.didTapSaveButton()
        }
        saveButton.fillTexture = kButtonActiveTexture
    }
}
