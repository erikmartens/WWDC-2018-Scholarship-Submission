import SpriteKit

class QuestionLabelNode: SKShapeNode {
    
    // MARK: - Public Properties
    
    var questionNumberLabelText: String? {
        get { return questionNumberLabelNode.text }
        set { questionNumberLabelNode.text = newValue }
    }
    
    var questionLabelText: String? {
        get { return questionLabelNode.text }
        set { questionLabelNode.text = newValue }
    }
    
    var timerLabelText: String? {
        get { return timerLabelNode.text }
        set { timerLabelNode.text = newValue }
    }
    
    var timerLabelFontColor: NSColor? {
        get { return timerLabelNode.fontColor }
        set { timerLabelNode.fontColor = newValue }
    }
    
    
    // MARK: - Private Properties
    
    private var questionNumberLabelNode: SKLabelNode!
    private var questionLabelNode: SKLabelNode!
    private var timerLabelNode: SKLabelNode!
    
    
    // MARK: - Initialization
    
    init(size: CGSize, questionNumberLabelText: String? = nil, questionLabelText: String? = nil, timeLabelText: String? = nil) {
        
        super.init()
        
        /* Definitions */
        let padding = size.width * 0.05
        let pathOriginX = size.width / CGFloat(2)
        let pathOriginY = size.height / CGFloat(2)
        let pathRect = CGRect(x: -pathOriginX, y: -pathOriginY, width: size.width, height: size.height)
        let largeLabelPreferredWidth = size.width * 0.6
        let smallLabelPreferredWidth = size.width * 0.2 - padding * 2
        
        /* Additional Configuration */
        isUserInteractionEnabled = false
        path = CGPath(rect: pathRect, transform: nil)
        strokeColor = .clear
        fillColor = .white
        fillTexture = SKTexture(imageNamed: "Images/label_background")
        
        /* Initialize and configure all properties */
        questionNumberLabelNode = SKLabelNode(text: questionNumberLabelText)
        questionNumberLabelNode.configure(with: smallLabelPreferredWidth, lines: 1)
        questionNumberLabelNode.position = CGPoint(x: -(size.width / 2 - (smallLabelPreferredWidth + 2 * padding) / 2), y: 0)
        
        questionLabelNode = SKLabelNode(text: questionLabelText)
        questionLabelNode.configure(with: largeLabelPreferredWidth, lines: 2, fontSizeFactor: 0.6, fontName: "SanFrancisco-Bold")
        questionLabelNode.position = CGPoint(x: 0, y: 0)
        
        timerLabelNode = SKLabelNode(text: timeLabelText)
        timerLabelNode.configure(with: smallLabelPreferredWidth, lines: 2)
        timerLabelNode.position = CGPoint(x: largeLabelPreferredWidth / 2 + (smallLabelPreferredWidth + 2 * padding) / 2, y: 0)
        
        addChild(questionNumberLabelNode)
        addChild(questionLabelNode)
        addChild(timerLabelNode)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

fileprivate extension SKLabelNode {
    
    func configure(with width: CGFloat, lines: Int, fontSizeFactor: CGFloat = 0.75, fontName: String? = nil) {
        preferredMaxLayoutWidth = width
        fontColor = .white
        fontSize *= fontSizeFactor
        if let fontName = fontName { self.fontName = fontName }
        numberOfLines = lines
        lineBreakMode = .byWordWrapping
        verticalAlignmentMode = .center
        horizontalAlignmentMode = .center
        zPosition = 1
    }
}
