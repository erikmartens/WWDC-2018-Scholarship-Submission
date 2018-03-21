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
        let pathOriginX = size.width / CGFloat(2)
        let pathOriginY = size.height / CGFloat(2)
        let pathRect = CGRect(x: -pathOriginX, y: -pathOriginY, width: size.width, height: size.height)
        
        /* Initialize all Properties */
        nameLabelNode = SKLabelNode(text: namelabelText)
        dateLabelNode = SKLabelNode(text: namelabelText)
        scoreLabelNode = SKLabelNode(text: namelabelText)
        
        /* Additional Configuration */
        isUserInteractionEnabled = false
        path = CGPath(rect: pathRect, transform: nil)
        strokeColor = .clear
        fillColor = .white
        fillTexture = SKTexture(imageNamed: "Images/label_background")
        
        nameLabelNode.configure(with: size.width * 0.4)
        nameLabelNode.position = CGPoint(x: -pathOriginX + nameLabelNode.frame.size.width / 2, y: 0)
        
        dateLabelNode.configure(with: size.width * 0.4)
        dateLabelNode.position = CGPoint(x: -pathOriginX + nameLabelNode.frame.size.width + dateLabelNode.frame.size.width / 2, y: 0)
        
        scoreLabelNode.configure(with: size.width * 0.2)
        scoreLabelNode.position = CGPoint(x: -pathOriginX + nameLabelNode.frame.size.width + dateLabelNode.frame.size.width + scoreLabelNode.frame.size.width / 2, y: 0)
        
        addChild(nameLabelNode)
        addChild(dateLabelNode)
        addChild(scoreLabelNode)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        nameLabelNode = SKLabelNode(text: nil)
        dateLabelNode = SKLabelNode(text: nil)
        scoreLabelNode = SKLabelNode(text: nil)
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
        zPosition = 1
    }
}

