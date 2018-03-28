import SpriteKit

class RegisterHighscoreNode: SKSpriteNode {
    
    // MARK: - Private Properties
    
    private weak var registerHighscoreControllerDelegate: RegisterHighscoreControllerDelegate!
    
    private var instructionLabel: LabelNode!
    private var enterNameNode: TextEntryNode!
    private(set) var saveButton: ButtonNode!
    
    
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
        
        let enterNameNodeWidth = size.width * 0.75
        let enterNameNodeHeight = size.height * 0.25
        let enterNameNodeSize = CGSize(width: enterNameNodeWidth, height: enterNameNodeHeight)
        
        let verticalButtonSpace = (size.height * 0.75) / CGFloat(6)
        let horizontalPadding = size.width * 0.1
        let verticalPadding = verticalButtonSpace * 0.1
        let buttonSizeSmall = CGSize(width: size.width / 2 - 2 * horizontalPadding, height: verticalButtonSpace - 2 * verticalPadding)
        
        /* Initialize and configure all properties */
        self.registerHighscoreControllerDelegate = registerHighscoreControllerDelegate
        
        instructionLabel = LabelNode(size: instructionNodeSize)
        let instructionLabelCoordinateY = size.height / CGFloat(2) - instructionNodeHeight / CGFloat(2)
        instructionLabel.position = CGPoint(x: 0, y: instructionLabelCoordinateY)
        
        enterNameNode = TextEntryNode(size: enterNameNodeSize, labelNodeText: "Enter Your Name:")
        //let enterNameNodeCoordinateY_0 = verticalButtonSpace + verticalButtonSpace / CGFloat(2)
        enterNameNode.position = CGPoint(x: 0, y: 0)
        
        saveButton = ButtonNode(size: buttonSizeSmall, labelText: "Save", backgroundTexture: kButtonActiveTexture)
        let saveButtonCoordinateY = verticalButtonSpace * 3 + verticalButtonSpace / CGFloat(2)
        saveButton.position = CGPoint(x: 0, y: -saveButtonCoordinateY)
        
        addChild(instructionLabel)
        addChild(enterNameNode)
        addChild(saveButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init?(coder:) is not implemented")
    }

    
    // MARK: - Public Functions & Properties
    
    func configure(with scoreText: NSMutableAttributedString) {
        instructionLabel.labelAttributedText = scoreText
    }
    
    func configureEnteredName(with name: String) {
        enterNameNode.enteredText = name
    }
    
    var enteredName: String? {
        return enterNameNode.enteredText
    }
}
