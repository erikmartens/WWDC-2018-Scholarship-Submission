import SpriteKit

class LabelNode: SKShapeNode {
    
    // MARK: - Properties
    
    private var labelNode: SKLabelNode!
    
    
    // MARK: - Initialization
    
    init(size: CGSize, labelText: String) {
        super.init()
        
        isUserInteractionEnabled = false
        
        let pathOriginX = size.width / CGFloat(2)
        let pathOriginY = size.height / CGFloat(2)
        let pathRect = CGRect(x: -pathOriginX, y: -pathOriginY, width: size.width, height: size.height)
        
        path = CGPath(rect: pathRect, transform: nil)
        strokeColor = .clear
        
        labelNode = SKLabelNode(text: labelText)
        labelNode.fontColor = .white
        labelNode.numberOfLines = 4
        labelNode.verticalAlignmentMode = .top
        labelNode.zPosition = 2
        
        fillColor = .white
        fillTexture = SKTexture(imageNamed: "Images/label_background")
        
        addChild(labelNode)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

