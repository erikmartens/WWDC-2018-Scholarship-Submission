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
    
    // todo: maybe delete this convenience accessor
    var timerLabelText: String? {
        get { return timerLabelNode.text }
        set { timerLabelNode.text = newValue }
    }
    
    
    // MARK: - Private Properties
    
    private var questionNumberLabelNode: SKLabelNode!
    private var questionLabelNode: SKLabelNode!
    private var timerLabelNode: SKLabelNode!
    
    
    // MARK: - Initialization
    
    init(size: CGSize, questionNumberLabelText: String, questionLabelText: String, timeLabelText: String) {
        
        super.init()
        
        /* Definitions */
        let padding = size.width * 0.05
        let pathOriginX = size.width / CGFloat(2)
        let pathOriginY = size.height / CGFloat(2)
        let pathRect = CGRect(x: -pathOriginX, y: -pathOriginY, width: size.width, height: size.height)
        let largeLabelPreferredWidth = size.width * 0.6 - padding * 2
        let smallLabelPreferredWidth = size.width / 0.2 - padding * 2
        
        /* Additional Configuration */
        isUserInteractionEnabled = false
        path = CGPath(rect: pathRect, transform: nil)
        strokeColor = .clear
        fillColor = .white
        fillTexture = SKTexture(imageNamed: "Images/label_background")
        
        /* Initialize and configure all properties */
        questionNumberLabelNode.configure(with: smallLabelPreferredWidth, lines: 1)
        questionNumberLabelNode.position = CGPoint(x: -(largeLabelPreferredWidth + smallLabelPreferredWidth / 2), y: 0)
        
        questionLabelNode.configure(with: largeLabelPreferredWidth, lines: 2)
        questionLabelNode.position = CGPoint(x: 0, y: 0)
        
        timerLabelNode.configure(with: smallLabelPreferredWidth, lines: 2)
        timerLabelNode.position = CGPoint(x: -(largeLabelPreferredWidth + smallLabelPreferredWidth / 2), y: 0)
        
        addChild(questionNumberLabelNode)
        addChild(questionLabelNode)
        addChild(timerLabelNode)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - Public FunctionsaDecoder
    
    /**
     * @param timeLft: remaining time in seconds
     */
    func updateTimer(timeLeft: Int) {
        timerLabelNode.text = "\(timeLeft)" // todo
        if timeLeft < 10 {
            timerLabelNode.fontColor = .orange
            return
        }
        timerLabelNode.fontColor = .white
    }
}

fileprivate extension SKLabelNode {
    
    func configure(with width: CGFloat, lines: Int) {
        preferredMaxLayoutWidth = width
        fontColor = .white
        numberOfLines = lines
        lineBreakMode = .byWordWrapping
        verticalAlignmentMode = .center
        horizontalAlignmentMode = .center
        zPosition = 1
    }
}
