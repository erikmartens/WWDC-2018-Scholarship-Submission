import SpriteKit

class HighscoreLabelNode: SKShapeNode {
    
    // MARK: - Properties
    
    private var nameLabelNode_0 = SKLabelNode(text: nil)
    private var nameLabelNode_1 = SKLabelNode(text: nil)
    private var nameLabelNode_2 = SKLabelNode(text: nil)
    private var nameLabelNode_3 = SKLabelNode(text: nil)
    private var nameLabelNode_4 = SKLabelNode(text: nil)
    
    private var nameLabelNodes: [SKLabelNode] {
        return [nameLabelNode_0, nameLabelNode_1, nameLabelNode_2, nameLabelNode_3, nameLabelNode_4]
    }
    
    private var dateLabelNode_0 = SKLabelNode(text: nil)
    private var dateLabelNode_1 = SKLabelNode(text: nil)
    private var dateLabelNode_2 = SKLabelNode(text: nil)
    private var dateLabelNode_3 = SKLabelNode(text: nil)
    private var dateLabelNode_4 = SKLabelNode(text: nil)
    
    private var dateLabelNodes: [SKLabelNode] {
        return [dateLabelNode_0, dateLabelNode_1, dateLabelNode_2, dateLabelNode_3, dateLabelNode_4]
    }
    
    private var scoreLabelNode_0 = SKLabelNode(text: nil)
    private var scoreLabelNode_1 = SKLabelNode(text: nil)
    private var scoreLabelNode_2 = SKLabelNode(text: nil)
    private var scoreLabelNode_3 = SKLabelNode(text: nil)
    private var scoreLabelNode_4 = SKLabelNode(text: nil)
    
    private var scoreLabelNodes: [SKLabelNode] {
        return [scoreLabelNode_0, scoreLabelNode_1, scoreLabelNode_2, scoreLabelNode_3, scoreLabelNode_4]
    }
    
    
    // MARK: - Initialization
    
    init(size: CGSize) {
        
        super.init()
        
        /* Definitions */
        let padding = size.width * 0.05
        let pathOriginX = size.width / CGFloat(2)
        let pathOriginY = size.height / CGFloat(2)
        let pathRect = CGRect(x: -pathOriginX, y: -pathOriginY, width: size.width, height: size.height)
        let labelPreferredWidth = size.width / 3 - padding * 2

        /* Additional Configuration */
        isUserInteractionEnabled = false
        path = CGPath(rect: pathRect, transform: nil)
        strokeColor = .clear
        fillColor = .white
        fillTexture = SKTexture(imageNamed: "Images/label_background")
        
        /* Configure all Properties */
        let verticalLabelSpace = size.height / 5
        
        let labelYDistance = verticalLabelSpace * 0.85
        let labelYDistanceFurthest = verticalLabelSpace * 1.75
        let labelCoordinatesY = [labelYDistanceFurthest,
                                 labelYDistance,
                                 0,
                                 -labelYDistance,
                                 -labelYDistanceFurthest]
        
        let nameLabelNodesCoordinateX = -(labelPreferredWidth + labelPreferredWidth / 2)
        nameLabelNodes.forEach { $0.configure(with: labelPreferredWidth) }
        nameLabelNode_0.position = CGPoint(x: nameLabelNodesCoordinateX, y: labelCoordinatesY[0])
        nameLabelNode_1.position = CGPoint(x: nameLabelNodesCoordinateX, y: labelCoordinatesY[1])
        nameLabelNode_2.position = CGPoint(x: nameLabelNodesCoordinateX, y: labelCoordinatesY[2])
        nameLabelNode_3.position = CGPoint(x: nameLabelNodesCoordinateX, y: labelCoordinatesY[3])
        nameLabelNode_4.position = CGPoint(x: nameLabelNodesCoordinateX, y: labelCoordinatesY[4])
        
        let dateLabelNodesCoordinateX: CGFloat = 0
        dateLabelNodes.forEach { $0.configure(with: labelPreferredWidth) }
        dateLabelNode_0.position = CGPoint(x: dateLabelNodesCoordinateX, y: labelCoordinatesY[0])
        dateLabelNode_1.position = CGPoint(x: dateLabelNodesCoordinateX, y: labelCoordinatesY[1])
        dateLabelNode_2.position = CGPoint(x: dateLabelNodesCoordinateX, y: labelCoordinatesY[2])
        dateLabelNode_3.position = CGPoint(x: dateLabelNodesCoordinateX, y: labelCoordinatesY[3])
        dateLabelNode_4.position = CGPoint(x: dateLabelNodesCoordinateX, y: labelCoordinatesY[4])
        
        let scoreLabelNodesCoordinateX = labelPreferredWidth + labelPreferredWidth / 2
        scoreLabelNodes.forEach { $0.configure(with: labelPreferredWidth) }
        scoreLabelNode_0.position = CGPoint(x: scoreLabelNodesCoordinateX, y: labelCoordinatesY[0])
        scoreLabelNode_1.position = CGPoint(x: scoreLabelNodesCoordinateX, y: labelCoordinatesY[1])
        scoreLabelNode_2.position = CGPoint(x: scoreLabelNodesCoordinateX, y: labelCoordinatesY[2])
        scoreLabelNode_3.position = CGPoint(x: scoreLabelNodesCoordinateX, y: labelCoordinatesY[3])
        scoreLabelNode_4.position = CGPoint(x: scoreLabelNodesCoordinateX, y: labelCoordinatesY[4])
        
        nameLabelNodes.forEach { addChild($0) }
        dateLabelNodes.forEach { addChild($0) }
        scoreLabelNodes.forEach { addChild($0) }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Public Functions
    
    func configure(with highscores: [HighscoreDTO]) {
        for index in 0..<min(highscores.count, 5) {
            nameLabelNodes[index].text = highscores[index].name
            dateLabelNodes[index].text = "\(highscores[index].date)" // todo
            scoreLabelNodes[index].text = "\(highscores[index].score)"
        }
    }
}

fileprivate extension SKLabelNode {
    
    func configure(with width: CGFloat) {
        preferredMaxLayoutWidth = width
        fontColor = .white
        fontSize *= 0.75
        numberOfLines = 1
        lineBreakMode = .byTruncatingTail
        verticalAlignmentMode = .center
        horizontalAlignmentMode = .center
        zPosition = 1
    }
}

