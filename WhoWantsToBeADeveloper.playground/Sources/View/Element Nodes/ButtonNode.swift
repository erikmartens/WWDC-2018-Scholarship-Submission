import SpriteKit

let kButtonActiveTexture = SKTexture(imageNamed: "Images/button_active")
let kButtonInactiveTexture = SKTexture(imageNamed: "Images/button_inactive")
let kButtonSelectedTexture = SKTexture(imageNamed: "Images/button_selected")
let kButtonLoggedTexture = SKTexture(imageNamed: "Images/button_answer_logged")
let kButtonCorrectTexture = SKTexture(imageNamed: "Images/button_answer_correct")
let kButtonIncorrectTexture = SKTexture(imageNamed: "Images/button_answer_incorrect")

let kButtonPauseActiveTexture = SKTexture(imageNamed: "Images/button_dropout")
let kButtonPauseSelectedTexture = SKTexture(imageNamed: "Images/button_dropout_selected")

let kJokerFiftyFiftyActiveTexture = SKTexture(imageNamed: "Images/joker_fiftyFifty_active")
let kJokerFiftyFiftyInactiveTexture = SKTexture(imageNamed: "Images/joker_fiftyFifty_inactive")
let kJokerFiftyFiftySelectedTexture = SKTexture(imageNamed: "Images/joker_fiftyFifty_selected")

let kMusicActiveTexture = SKTexture(imageNamed: "Images/music_active")
let kMusicInactiveTexture = SKTexture(imageNamed: "Images/music_inactive")

class ButtonNode: SKShapeNode {
    
    // MARK: - Public Properties
    
    var labelText: String? {
        get { return labelNode.text }
        set { labelNode.text = newValue }
    }
    
    
    // MARK: - Private Properties
    
    private var labelNode: SKLabelNode!
    
    
    // MARK: - Initialization
    
    init(size: CGSize, labelText: String? = nil, backgroundTexture: SKTexture? = nil, textSizeFactor: CGFloat = 0.75) {
        
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
        labelNode.fontSize *= textSizeFactor
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

