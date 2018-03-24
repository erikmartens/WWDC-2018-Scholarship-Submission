import SpriteKit

class MainMenuNode: SKSpriteNode {
    
    // MARK: - Public Properties
    
    let nodeType: NodeType = .mainMenu
    
    
    // MARK: - Private Properties
    
    private weak var applicationDelegate: ApplicationDelegate?
    
    private var resumeButton: ButtonNode!
    private var startButton: ButtonNode!
    private var highscoreButton: ButtonNode!
    private var aboutButton: ButtonNode!
    
    private var backgroundImage: SKSpriteNode!
    
    private let buttonsCount = 4
    private var buttons: [ButtonNode] {
        return [resumeButton, startButton, highscoreButton, aboutButton]
    }
    
    
    // MARK: - Initialization
    
    init(applicationDelegate: ApplicationDelegate) {
        super.init(texture: nil, color: .clear, size: .zero)
        
        // todo: add game logo node with animation
        
        self.applicationDelegate = applicationDelegate
        
        isUserInteractionEnabled = true
        size = CGSize(width: applicationDelegate.aplicationFrame.size.width, height: applicationDelegate.aplicationFrame.size.height)
        position = CGPoint(x: applicationDelegate.aplicationFrame.midX, y: applicationDelegate.aplicationFrame.midY)
        
        backgroundImage = SKSpriteNode(imageNamed: "Images/background")
        backgroundImage.size = applicationDelegate.aplicationFrame.size
        backgroundImage.zPosition = -1
        
        let verticalButtonSpace = size.height / CGFloat(buttonsCount)
        let horizontalPadding = size.width * 0.1
        let verticalPadding = verticalButtonSpace * 0.1
        let buttonSize = CGSize(width: size.width - 2 * horizontalPadding, height: verticalButtonSpace - 2 * verticalPadding)
        
        resumeButton = ButtonNode(size: buttonSize, labelText: "Resume Game", backgroundTexture: kButtonInactiveTexture) // todo
        let resumeButtonCoordinateY = verticalButtonSpace + verticalButtonSpace / CGFloat(2)
        resumeButton.position = CGPoint(x: 0, y: resumeButtonCoordinateY)
        
        startButton = ButtonNode(size: buttonSize, labelText: "Start New Game", backgroundTexture: kButtonActiveTexture)
        let startButtonCoordinateY = verticalButtonSpace / CGFloat(2)
        startButton.position = CGPoint(x: 0, y: startButtonCoordinateY)
        
        highscoreButton = ButtonNode(size: buttonSize, labelText: "Highscores", backgroundTexture: kButtonActiveTexture)
        let highscoreButtonCoordinateY = verticalButtonSpace / CGFloat(2)
        highscoreButton.position = CGPoint(x: 0, y: -highscoreButtonCoordinateY)
        
        aboutButton = ButtonNode(size: buttonSize, labelText: "About", backgroundTexture: kButtonActiveTexture)
        let aboutButtonCoordinateY = verticalButtonSpace + verticalButtonSpace / CGFloat(2)
        aboutButton.position = CGPoint(x: 0, y: -aboutButtonCoordinateY)
        
        addChild(resumeButton)
        addChild(startButton)
        addChild(highscoreButton)
        addChild(aboutButton)
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
        
        if resumeButton.contains(location) {
            resumeButton.fillTexture = kButtonSelectedTexture // todo
            return
        }
        if startButton.contains(location) {
            startButton.fillTexture = kButtonSelectedTexture
            return
        }
        if highscoreButton.contains(location) {
            highscoreButton.fillTexture = kButtonSelectedTexture
            return
        }
        if aboutButton.contains(location) {
            aboutButton.fillTexture = kButtonSelectedTexture
            return
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        
        if resumeButton.contains(location) {
            applicationDelegate?.didSelectNode(with: .game) // todo
        }
        if startButton.contains(location) {
            applicationDelegate?.didSelectNode(with: .game)
        }
        if highscoreButton.contains(location) {
            applicationDelegate?.didSelectNode(with: .highscores)
        }
        if aboutButton.contains(location) {
            applicationDelegate?.didSelectNode(with: .about)
        }
        buttons.forEach { $0.fillTexture = kButtonActiveTexture } // todo: resume button texture
    }
}
