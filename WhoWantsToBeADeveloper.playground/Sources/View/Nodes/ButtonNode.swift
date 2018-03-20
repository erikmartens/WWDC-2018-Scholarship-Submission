import SpriteKit

class ButtonNode: SKShapeNode {
    
    // MARK: - Properties
    
    var labelNode: SKLabelNode!
    
    
    // MARK: - Initialization
    
    init(size: CGSize, labelText: String, backgroundImageName: String) {
        super.init()
        
        let pathOriginX = size.width / CGFloat(2)
        let pathOriginY = size.height / CGFloat(2)
        let pathRect = CGRect(x: -pathOriginX, y: -pathOriginY, width: size.width, height: size.height)
        
        path = CGPath(rect: pathRect, transform: nil)
        strokeColor = .clear
        
        labelNode = SKLabelNode(text: labelText)
        labelNode.fontColor = .white
        labelNode.numberOfLines = 1
        labelNode.verticalAlignmentMode = .center
        labelNode.zPosition = 2
        
        fillColor = .white
        let texture = SKTexture(imageNamed: backgroundImageName)
        fillTexture = texture
        
//        let texture = SKTexture(imageNamed: backgroundImageName)
//        backgroundNode = SKSpriteNode(texture: texture)
//        backgroundNode.size = CGSize(width: rect.width, height: rect.height)
//        backgroundNode.zPosition = 1
        
        addChild(labelNode)
//        addChild(backgroundNode)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

