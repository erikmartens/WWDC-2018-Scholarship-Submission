import SpriteKit

class HighscoresNode: SKSpriteNode {
    
    // MARK: - Public Properties
    
    let nodeType: NodeType = .highscores
    
    
    // MARK: - Private Properties
    
    private weak var applicationDelegate: ApplicationDelegate?
    
    private var instructionLabel: LabelNode!
    
    private var classicModeButton: ButtonNode!
    private var arcadeModeButton: ButtonNode!
    private var backButton: ButtonNode!
    
    private var backgroundImage: SKSpriteNode!
    
    private let labelsCount =  3
    private var labels: [ButtonNode] {
        return [classicModeButton, arcadeModeButton, backButton]
    }
    
    
    // MARK: - Initialization
    
    init(applicationDelegate: ApplicationDelegate) {
        super.init(texture: nil, color: .clear, size: .zero)
        
        self.applicationDelegate = applicationDelegate
        
        isUserInteractionEnabled = true
        size = CGSize(width: applicationDelegate.aplicationFrame.size.width, height: applicationDelegate.aplicationFrame.size.height)
        position = CGPoint(x: applicationDelegate.aplicationFrame.midX, y: applicationDelegate.aplicationFrame.midY)
        
        backgroundImage = SKSpriteNode(imageNamed: "Images/background")
        backgroundImage.size = applicationDelegate.aplicationFrame.size
        backgroundImage.zPosition = -1
        
        let instructionNodeHeight = size.height * 0.25
        let instructionNodeSize = CGSize(width: size.width, height: instructionNodeHeight)
        
        let verticalButtonSpace = (size.height - instructionNodeHeight) / CGFloat(labelsCount)
        let horizontalPadding = size.width * 0.1
        let verticalPadding = verticalButtonSpace * 0.1
        let buttonSizeRegular = CGSize(width: size.width - 2 * horizontalPadding, height: verticalButtonSpace - 2 * verticalPadding)
        let buttonSizeSmall = CGSize(width: size.width / 2 - 2 * horizontalPadding, height: verticalButtonSpace - 4 * verticalPadding)
        
        instructionLabel = LabelNode(size: instructionNodeSize, labelText: "Select a game mode!")
        let instructionLabelCoordinateY = size.height / CGFloat(2) - instructionNodeHeight / CGFloat(2)
        instructionLabel.position = CGPoint(x: 0, y: instructionLabelCoordinateY)
        
        classicModeButton = ButtonNode(size: buttonSizeRegular, labelText: "Classic Mode", backgroundTexture: kButtonActiveTexture) // todo
        let classicModeButtonCoordinateY = verticalButtonSpace / CGFloat(2)
        classicModeButton.position = CGPoint(x: 0, y: classicModeButtonCoordinateY)
        
        arcadeModeButton = ButtonNode(size: buttonSizeRegular, labelText: "Arcade Mode", backgroundTexture: kButtonActiveTexture)
        let arcadeModeButtonCoordinateY = verticalButtonSpace / CGFloat(2)
        arcadeModeButton.position = CGPoint(x: 0, y: -arcadeModeButtonCoordinateY)
        
        backButton = ButtonNode(size: buttonSizeSmall, labelText: "Back", backgroundTexture: kButtonActiveTexture)
        let backButtonCoordinateY = verticalButtonSpace + verticalButtonSpace / CGFloat(2)
        backButton.position = CGPoint(x: 0, y: -backButtonCoordinateY)
        
        addChild(instructionLabel)
        addChild(classicModeButton)
        addChild(arcadeModeButton)
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
        
        if classicModeButton.contains(location) {
            classicModeButton.fillTexture = kButtonSelectedTexture // todo
            return
        }
        
        if arcadeModeButton.contains(location) {
            arcadeModeButton.fillTexture = kButtonSelectedTexture
            return
        }
        
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
        
        if classicModeButton.contains(location) {
            classicModeButton.fillTexture = kButtonActiveTexture
            applicationDelegate?.didSelectNode(with: .game)
            return
        }
        
        if arcadeModeButton.contains(location) {
            arcadeModeButton.fillTexture = kButtonActiveTexture
            applicationDelegate?.didSelectNode(with: .game)
            return
        }
        
        if backButton.contains(location) {
            backButton.fillTexture = kButtonActiveTexture
            applicationDelegate?.didSelectNode(with: .mainMenu)
            return
        }
        
        labels.forEach { $0.fillTexture = kButtonActiveTexture }
    }
}
