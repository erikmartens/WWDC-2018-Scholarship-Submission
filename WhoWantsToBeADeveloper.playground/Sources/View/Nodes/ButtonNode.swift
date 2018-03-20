import SpriteKit

class ButtonNode: SKShapeNode {
    
    // MARK: - Properties
    
    var labelNode: SKLabelNode!
    var backgroundNode: SKSpriteNode!
    
    
    // MARK: - Initialization
    
    init(rect: CGRect, labelText: String, backgroundImageName: String) {
        super.init()
        
        path = CGPath(rect: rect, transform: nil)
        
        labelNode = SKLabelNode(text: labelText)
        labelNode.zPosition = 2
        
        backgroundNode = SKSpriteNode(imageNamed: backgroundImageName)
        backgroundNode.size = CGSize(width: rect.width, height: rect.height)
        backgroundNode.zPosition = 1
        
        addChild(labelNode)
        addChild(backgroundNode)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

