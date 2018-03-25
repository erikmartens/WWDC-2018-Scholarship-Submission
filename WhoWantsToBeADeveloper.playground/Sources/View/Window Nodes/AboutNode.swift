import SpriteKit

fileprivate let kAboutLabelText = "Who Wants to Be a Developer\ncreated by Erik Maximilian Martens"

class AboutNode: SKSpriteNode {
    
    // MARK: - Private Properties
    
    private weak var applicationDelegate: ApplicationDelegate?
    
    private var aboutLabel: LabelNode!
    private var backButton: ButtonNode!
    
    private var backgroundImage: SKSpriteNode!
    
    
    // MARK: - Initialization
    
    init(applicationDelegate: ApplicationDelegate) {
        
        super.init(texture: nil, color: .clear, size: .zero)
        
        /* Additional Configuration */
        isUserInteractionEnabled = true
        size = CGSize(width: applicationDelegate.aplicationFrame.size.width, height: applicationDelegate.aplicationFrame.size.height)
        position = CGPoint(x: applicationDelegate.aplicationFrame.midX, y: applicationDelegate.aplicationFrame.midY)
        
        /* Definitions */
        let aboutNodeHeight = size.height * 0.85
        let aboutNodeSize = CGSize(width: size.width, height: aboutNodeHeight)
        
        let verticalButtonSpace = (size.height * 0.75) / CGFloat(6)
        let horizontalPadding = size.width * 0.1
        let verticalPadding = verticalButtonSpace * 0.1
        let buttonSizeSmall = CGSize(width: size.width / 2 - 2 * horizontalPadding, height: verticalButtonSpace - 4 * verticalPadding)
        
        /* Initialize and configure all properties */
        self.applicationDelegate = applicationDelegate
        
        backgroundImage = SKSpriteNode(imageNamed: "Images/background")
        backgroundImage.size = applicationDelegate.aplicationFrame.size
        backgroundImage.zPosition = -1
        
        aboutLabel = LabelNode(size: aboutNodeSize, labelText: kAboutLabelText)
        let aboutLabelCoordinateY =  size.height / CGFloat(2) - aboutNodeHeight / CGFloat(2)
        aboutLabel.position = CGPoint(x: 0, y: aboutLabelCoordinateY)
        
        backButton = ButtonNode(size: buttonSizeSmall, labelText: "Back", backgroundTexture: kButtonActiveTexture)
        let backButtonCoordinateY = verticalButtonSpace * 3 + verticalButtonSpace / CGFloat(2)
        backButton.position = CGPoint(x: 0, y: -backButtonCoordinateY)
        
        addChild(aboutLabel)
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
        
        backButton.fillTexture = kButtonActiveTexture
    }
}
