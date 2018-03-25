import SpriteKit

class HighscoresNode: SKSpriteNode {    
    
    // MARK: - Private Properties
    
    private weak var applicationDelegate: ApplicationDelegate?
    
    private var instructionLabel: LabelNode!
    private var labelNode_0: HighscoreLabelNode!
    private var labelNode_1: HighscoreLabelNode!
    private var labelNode_2: HighscoreLabelNode!
    private var labelNode_3: HighscoreLabelNode!
    private var labelNode_4: HighscoreLabelNode!
    private var backButton: ButtonNode!
    
    private var backgroundImage: SKSpriteNode!
    
    private let elementsCount =  6
    private var buttons: [ButtonNode] {
        return [backButton]
    }
    
    
    // MARK: - Initialization
    
    init(applicationDelegate: ApplicationDelegate) {
        
        super.init(texture: nil, color: .clear, size: .zero)
        
        /* Additional Configuration */
        isUserInteractionEnabled = true
        size = CGSize(width: applicationDelegate.applicationFrame.size.width, height: applicationDelegate.applicationFrame.size.height)
        position = CGPoint(x: applicationDelegate.applicationFrame.midX, y: applicationDelegate.applicationFrame.midY)
        
        /* Definitions */
        let instructionNodeHeight = size.height * 0.25
        let instructionNodeSize = CGSize(width: size.width, height: instructionNodeHeight)
        
        let verticalButtonSpace = (size.height - instructionNodeHeight) / CGFloat(elementsCount)
        let horizontalPadding = size.width * 0.1
        let verticalPadding = verticalButtonSpace * 0.1
        let buttonSizeRegular = CGSize(width: size.width - 2 * horizontalPadding, height: verticalButtonSpace - 2 * verticalPadding)
        let buttonSizeSmall = CGSize(width: size.width / 2 - 2 * horizontalPadding, height: verticalButtonSpace - 2 * verticalPadding)
        
        /* Initialize and configure all properties */
        self.applicationDelegate = applicationDelegate
        
        backgroundImage = SKSpriteNode(imageNamed: "Images/background")
        backgroundImage.size = applicationDelegate.applicationFrame.size
        backgroundImage.zPosition = -1
        
        instructionLabel = LabelNode(size: instructionNodeSize, labelText: "Arcade Mode Highscores")
        let instructionLabelCoordinateY = size.height / CGFloat(2) - instructionNodeHeight / CGFloat(2)
        instructionLabel.position = CGPoint(x: 0, y: instructionLabelCoordinateY)
        
        labelNode_0 = HighscoreLabelNode(size: buttonSizeRegular, namelabelText: "Test1", dateLabelText: "01.01.1990", scoreLabelText: "99")
        let labelNodeCoordinateY_0 = verticalButtonSpace + verticalButtonSpace / CGFloat(2)
        labelNode_0.position = CGPoint(x: 0, y: labelNodeCoordinateY_0)
        
        labelNode_1 = HighscoreLabelNode(size: buttonSizeRegular, namelabelText: "Test2", dateLabelText: "01.01.1990", scoreLabelText: "99")
        let labelNodeCoordinateY_1 = verticalButtonSpace / CGFloat(2)
        labelNode_1.position = CGPoint(x: 0, y: labelNodeCoordinateY_1)
        
        labelNode_2 = HighscoreLabelNode(size: buttonSizeRegular, namelabelText: "Test3", dateLabelText: "01.01.1990", scoreLabelText: "99")
        let labelNodeCoordinateY_2 = verticalButtonSpace / CGFloat(2)
        labelNode_2.position = CGPoint(x: 0, y: -labelNodeCoordinateY_2)
        
        labelNode_3 = HighscoreLabelNode(size: buttonSizeRegular, namelabelText: "Test4", dateLabelText: "01.01.1990", scoreLabelText: "99")
        let labelNodeCoordinateY_3 = verticalButtonSpace + verticalButtonSpace / CGFloat(2)
        labelNode_3.position = CGPoint(x: 0, y: -labelNodeCoordinateY_3)
        
        labelNode_4 = HighscoreLabelNode(size: buttonSizeRegular, namelabelText: "Test5", dateLabelText: "01.01.1990", scoreLabelText: "99")
        let labelNodeCoordinateY_4 = verticalButtonSpace * 2 + verticalButtonSpace / CGFloat(2)
        labelNode_4.position = CGPoint(x: 0, y: -labelNodeCoordinateY_4)
        
        backButton = ButtonNode(size: buttonSizeSmall, labelText: "Back", backgroundTexture: kButtonActiveTexture)
        let backButtonCoordinateY = verticalButtonSpace * 3 + verticalButtonSpace / CGFloat(2)
        backButton.position = CGPoint(x: 0, y: -backButtonCoordinateY)
        
        addChild(instructionLabel)
        addChild(labelNode_0)
        addChild(labelNode_1)
        addChild(labelNode_2)
        addChild(labelNode_3)
        addChild(labelNode_4)
        addChild(backButton)
        addChild(backgroundImage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - UIEvent Handlers
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        
        if backButton.contains(location) {
            backButton.fillTexture = kButtonSelectedTexture
            return
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        
        if backButton.contains(location) {
            backButton.fillTexture = kButtonActiveTexture
            applicationDelegate?.didSelectNode(with: .mainMenu)
            return
        }
        
        buttons.forEach { $0.fillTexture = kButtonActiveTexture }
    }
}
