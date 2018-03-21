import SpriteKit

class LabelNode: SKShapeNode {
    
    // MARK: - Properties
    
    private var labelNode: SKLabelNode!
    
    
    // MARK: - Initialization
    
    init(size: CGSize, labelText: String) {
        
labelNode = SKLabelNode(text: labelText)
        super.init()
        
        /* Definitions */
        let pathOriginX = size.width / CGFloat(2)
        let pathOriginY = size.height / CGFloat(2)
        let pathRect = CGRect(x: -pathOriginX, y: -pathOriginY, width: size.width, height: size.height)
        
        /* Additional Configuration */
        isUserInteractionEnabled = false
        path = CGPath(rect: pathRect, transform: nil)
        strokeColor = .clear
        fillColor = .white
        fillTexture = SKTexture(imageNamed: "Images/label_background")
        
        /* Initialize and configure all properties */
        labelNode = SKLabelNode(text: labelText)
        labelNode.preferredMaxLayoutWidth = size.width * 0.98
        labelNode.fontName = "SanFrancisco-Bold"
        labelNode.fontColor = .white
        labelNode.numberOfLines = 2
        labelNode.lineBreakMode = .byWordWrapping
        labelNode.verticalAlignmentMode = .center
        labelNode.zPosition = 1
        
        addChild(labelNode)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

