import SpriteKit

class HighscoresNode: SKSpriteNode {    
    
    // MARK: - Private Properties
    
    private weak var highscoresControllerDelegate: HighscoresControllerDelegate!
    
    private var instructionLabel: LabelNode!
    private var highscoresLabelNode: HighscoreLabelNode!
    private(set) var backButton: ButtonNode!
    
    private let elementsCount =  6
    private var buttons: [ButtonNode] {
        return [backButton]
    }
    
    
    // MARK: - Initialization
    
    init(frame: CGRect, highscoresControllerDelegate: HighscoresControllerDelegate) {
        
        super.init(texture: nil, color: .clear, size: .zero)
        
        /* Additional Configuration */
        isUserInteractionEnabled = true
        size = CGSize(width: frame.size.width, height: frame.size.height)
        position = CGPoint(x: frame.midX, y: frame.midY)
        texture = SKTexture(imageNamed: "Images/background")
        
        /* Definitions */
        let instructionNodeHeight = size.height * 0.25
        let instructionNodeSize = CGSize(width: size.width, height: instructionNodeHeight)
        
        let verticalButtonSpace = (size.height - instructionNodeHeight) / CGFloat(elementsCount)
        let horizontalPadding = size.width * 0.1
        let verticalPadding = verticalButtonSpace * 0.1
        let highscoresLabelSize = CGSize(width: size.width - horizontalPadding / 2, height: size.height * 0.6)
        let buttonSizeSmall = CGSize(width: size.width / 2 - 2 * horizontalPadding, height: verticalButtonSpace - 2 * verticalPadding)
        
        /* Initialize and configure all properties */
        self.highscoresControllerDelegate = highscoresControllerDelegate
        
        instructionLabel = LabelNode(size: instructionNodeSize, labelText: "Top 5 Highscores")
        let instructionLabelCoordinateY = size.height / CGFloat(2) - instructionNodeHeight / CGFloat(2)
        instructionLabel.position = CGPoint(x: 0, y: instructionLabelCoordinateY)
        
        highscoresLabelNode = HighscoreLabelNode(size: highscoresLabelSize)
        let highscoresLabelNodeCoordinateY = verticalButtonSpace / CGFloat(2)
        highscoresLabelNode.position = CGPoint(x: 0, y: -highscoresLabelNodeCoordinateY)
        
        backButton = ButtonNode(size: buttonSizeSmall, labelText: "Back", backgroundTexture: kButtonActiveTexture)
        let backButtonCoordinateY = verticalButtonSpace * 3 + verticalButtonSpace / CGFloat(2)
        backButton.position = CGPoint(x: 0, y: -backButtonCoordinateY)
        
        addChild(instructionLabel)
        addChild(highscoresLabelNode)
        addChild(backButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init?(coder:) is not implemented")
    }
    
    // MARK: - Public Functions
    
    func configure(with highscores: [HighscoreDTO]) {
        highscoresLabelNode.configure(with: highscores)
    }
}
