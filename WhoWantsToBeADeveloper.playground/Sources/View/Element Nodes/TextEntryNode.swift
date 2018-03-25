import SpriteKit

class TextEntryNode: SKShapeNode {
    
    // MARK: - Public Properties
    
    var labelText: String? {
        get { return labelNode.text }
        set { labelNode.text = newValue }
    }
    
    var enteredText: String? {
        get { return enteredTextNode.text }
        set { enteredTextNode.text = newValue }
    }
    
    
    // MARK: - Private Properties
    
    private var labelNode: SKLabelNode!
    private var enteredTextNode: SKLabelNode!
    
    
    // MARK: - Initialization
    
    init(size: CGSize, labelNodeText: String? = nil) {
        
        super.init()
        
        /* Definitions */
        let padding = size.width * 0.05
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
        labelNode = SKLabelNode(text: labelNodeText)
        labelNode.configure(size: size, fontName: "SanFrancisco-Bold")
        labelNode.position = CGPoint(x: 0, y: size.height / CGFloat(4))
        
        enteredTextNode = SKLabelNode(text: nil)
        enteredTextNode.configure(size: size, fontName: "SanFrancisco")
        enteredTextNode.position = CGPoint(x: 0, y: -(size.height / CGFloat(4)))
        
        addChild(labelNode)
        addChild(labelNode)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

fileprivate extension SKLabelNode {
    
    func configure(size: CGSize, fontName: String) {
        preferredMaxLayoutWidth = size.width * 0.95
        fontColor = .white
        fontSize *= 0.75
        self.fontName = fontName
        numberOfLines = 1
        lineBreakMode = .byWordWrapping
        verticalAlignmentMode = .center
        horizontalAlignmentMode = .center
        zPosition = 1
    }
}
