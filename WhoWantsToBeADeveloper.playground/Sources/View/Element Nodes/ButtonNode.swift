import SpriteKit

let kButtonActiveTexture = SKTexture(imageNamed: "Images/button_active")
let kButtonInactiveTexture = SKTexture(imageNamed: "Images/button_inactive")
let kButtonSelectedTexture = SKTexture(imageNamed: "Images/button_selected")

let kButtonDropuoutActiveTexture = SKTexture(imageNamed: "Images/button_dropout")
let kButtonDropuoutSelectedTexture = SKTexture(imageNamed: "Images/button_dropout_selected")

let kJokerFiftyFiftyActiveTexture = SKTexture(imageNamed: "Images/joker_fiftyFifty_active")
let kJokerFiftyFiftyInactiveTexture = SKTexture(imageNamed: "Images/joker_fiftyFifty_inactive")

let kJokerAudienceActiveTexture = SKTexture(imageNamed: "Images/joker_audience_active")
let kJokerAudienceInactiveTexture = SKTexture(imageNamed: "Images/joker_audience_inactive")

class ButtonNode: SKShapeNode {
    
    // MARK: - Properties
    
    private var labelNode: SKLabelNode!
    
    
    // MARK: - Initialization
    
    init(size: CGSize, labelText: String, backgroundTexture: SKTexture) {
        
        super.init()
        
        /* Definitions */
        let pathOriginX = size.width / CGFloat(2)
        let pathOriginY = size.height / CGFloat(2)
        let pathRect = CGRect(x: -pathOriginX, y: -pathOriginY, width: size.width, height: size.height)
        
        /* Additional Configuration */
        path = CGPath(rect: pathRect, transform: nil)
        strokeColor = .clear
        fillColor = .white
        fillTexture = backgroundTexture
        
        /* Initialize and configure all properties */
        labelNode = SKLabelNode(text: labelText)
        labelNode.preferredMaxLayoutWidth = size.width * 0.98
        labelNode.fontName = "SanFrancisco-Bold"
        labelNode.fontColor = .white
        labelNode.fontSize *= 0.75
        labelNode.numberOfLines = 1
        labelNode.lineBreakMode = .byTruncatingTail
        labelNode.verticalAlignmentMode = .center
        labelNode.zPosition = 1
        
        addChild(labelNode)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

