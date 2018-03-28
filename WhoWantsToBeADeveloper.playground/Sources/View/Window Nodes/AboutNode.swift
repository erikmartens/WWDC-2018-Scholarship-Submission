import SpriteKit

class AboutNode: SKSpriteNode {
    
    // MARK: - Private Properties
    
    private weak var aboutControllerDelegate: AboutControllerDelegate!
    
    private var aboutLabel: LabelNode!
    private var backButton: ButtonNode!
    
    
    // MARK: - Initialization
    
    init(frame: CGRect, aboutControllerDelegate: AboutControllerDelegate) {
        
        super.init(texture: nil, color: .clear, size: .zero)
        
        /* Additional Configuration */
        isUserInteractionEnabled = true
        size = CGSize(width: frame.size.width, height: frame.size.height)
        position = CGPoint(x: frame.midX, y: frame.midY)
        texture = SKTexture(imageNamed: "Images/background")
        
        /* Definitions */
        let aboutNodeHeight = size.height * 0.85
        let aboutNodeSize = CGSize(width: size.width, height: aboutNodeHeight)
        
        let verticalButtonSpace = (size.height * 0.75) / CGFloat(6)
        let horizontalPadding = size.width * 0.1
        let verticalPadding = verticalButtonSpace * 0.1
        let buttonSizeSmall = CGSize(width: size.width / 2 - 2 * horizontalPadding, height: verticalButtonSpace - 2 * verticalPadding)
        
        /* Initialize and configure all properties */
        self.aboutControllerDelegate = aboutControllerDelegate
        
        aboutLabel = LabelNode(size: aboutNodeSize)
        let aboutLabelCoordinateY =  size.height / CGFloat(2) - aboutNodeHeight / CGFloat(2)
        aboutLabel.position = CGPoint(x: 0, y: aboutLabelCoordinateY)
        
        backButton = ButtonNode(size: buttonSizeSmall, labelText: "Back", backgroundTexture: kButtonActiveTexture)
        let backButtonCoordinateY = verticalButtonSpace * 3 + verticalButtonSpace / CGFloat(2)
        backButton.position = CGPoint(x: 0, y: -backButtonCoordinateY)
        
        addChild(aboutLabel)
        addChild(backButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init?(coder:) is not implemented")
    }
    
    
    // MARK: - Public Functions
    
    func configure(with aboutText: NSMutableAttributedString) {
        aboutLabel.labelAttributedText = aboutText
    }
    
    
    // MARK: - UIEvent Handlers
    
    override func mouseDown(with event: NSEvent) {
        let mousePoint = convertPoint(fromView: CGPoint(x: event.locationInWindow.x, y: event.locationInWindow.y))
        guard let touchedNode = nodes(at: mousePoint).first else {
            return
        }
        if touchedNode == backButton {
            backButton.fillTexture = kButtonSelectedTexture
        }
    }
    
    override func mouseUp(with event: NSEvent) {
        let mousePoint = convertPoint(fromView: CGPoint(x: event.locationInWindow.x, y: event.locationInWindow.y))
        guard let touchedNode = nodes(at: mousePoint).first else {
            return
        }
        if touchedNode == backButton {
            aboutControllerDelegate.didTapBackButton()
        }
        backButton.fillTexture = kButtonActiveTexture
    }
}
