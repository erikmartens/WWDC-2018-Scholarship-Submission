import SpriteKit

class HighscoreLabelNode: SKShapeNode {
    
    // MARK: - Properties
    
    private var nameLabelNode: SKLabelNode!
    private var dateLabelNode: SKLabelNode!
    private var scoreLabelNode: SKLabelNode!
    
    
    // MARK: - Initialization
    
    init(size: CGSize, namelabelText: String, dateLabelText: String, scoreLabelText: String) {
        
        super.init()
        
        /* Definitions */
        let padding = size.width * 0.05
        let pathOriginX = size.width / CGFloat(2)
        let pathOriginY = size.height / CGFloat(2)
        let pathRect = CGRect(x: -pathOriginX, y: -pathOriginY, width: size.width, height: size.height)
        let labelPreferredWidth = size.width / 3 - padding * 2

        /* Additional Configuration */
        isUserInteractionEnabled = false
        path = CGPath(rect: pathRect, transform: nil)
        strokeColor = .clear
        fillColor = .white
        fillTexture = SKTexture(imageNamed: "Images/label_background")
        
        /* Initialize all Properties */
        nameLabelNode = SKLabelNode(text: namelabelText)
        
        nameLabelNode.configure(with: labelPreferredWidth)
        nameLabelNode.position = CGPoint(x: -(labelPreferredWidth + labelPreferredWidth / 2), y: 0)
        
        dateLabelNode = SKLabelNode(text: dateLabelText)
        dateLabelNode.configure(with: labelPreferredWidth)
        dateLabelNode.position = CGPoint(x: 0, y: 0)
        
        scoreLabelNode = SKLabelNode(text: scoreLabelText)
        scoreLabelNode.configure(with: labelPreferredWidth)
        scoreLabelNode.position = CGPoint(x: labelPreferredWidth + labelPreferredWidth / 2, y: 0)
        
        addChild(nameLabelNode)
        addChild(dateLabelNode)
        addChild(scoreLabelNode)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

fileprivate extension SKLabelNode {
    
    func configure(with width: CGFloat) {
        preferredMaxLayoutWidth = width
        fontColor = .white
        numberOfLines = 1
        lineBreakMode = .byTruncatingTail
        verticalAlignmentMode = .center
        horizontalAlignmentMode = .center
        zPosition = 1
    }
}

