import SpriteKit

class LoadingNode: SKSpriteNode {
    
    // MARK: - Private Properties
    
    private var gameLogoNode: SKSpriteNode!
    
    
    // MARK: - Initialization
    
    init(frame: CGRect) {
        
        super.init(texture: nil, color: .clear, size: .zero)
        
        /* Additional Configuration */
        isUserInteractionEnabled = false
        size = CGSize(width: frame.size.width, height: frame.size.height)
        position = CGPoint(x: frame.midX, y: frame.midY)
        texture = SKTexture(imageNamed: "Images/background")
        
        /* Definitions */
        let gameLogoNodeSize = CGSize(width: size.height * 0.75, height: size.height * 0.75)
        
        /* Initialize and configure all properties */
        let gameLogoTexture = SKTexture(imageNamed: "Images/wwd_logo")
        gameLogoNode = SKSpriteNode(texture: gameLogoTexture)
        gameLogoNode.size = gameLogoNodeSize
        gameLogoNode.position = CGPoint(x: 0, y: 0)
       
        addChild(gameLogoNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init?(coder:) is not implemented")
    }
}
