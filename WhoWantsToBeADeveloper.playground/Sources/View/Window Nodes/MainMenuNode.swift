import SpriteKit

class MainMenuNode: SKSpriteNode {    
    
    // MARK: - Private Properties
    // implicitely force unwrap applicationGameDelegate
    // the delegate should never be nil and if it is we want to know by crashing the app, so we are alerted and can fix it
    
    private weak var mainMenuControllerDelegate: MainMenuControllerDelegate!
    
    private var resumeButton: ButtonNode!
    private var startButton: ButtonNode!
    private var highscoreButton: ButtonNode!
    private var aboutButton: ButtonNode!
    
    private var resumeAvailable: Bool!
    
    private let buttonsCount = 4
    private var buttons: [ButtonNode] {
        return [resumeButton, startButton, highscoreButton, aboutButton]
    }
    
    
    // MARK: - Initialization
    
    init(frame: CGRect, mainMenuControllerDelegate: MainMenuControllerDelegate) {
        super.init(texture: nil, color: .clear, size: .zero)
        
        // todo: add game logo node with animation
        
        /* Additional Configuration */        
        isUserInteractionEnabled = true
        size = CGSize(width: frame.size.width, height: frame.size.height)
        position = CGPoint(x: frame.midX, y: frame.midY)
        texture = SKTexture(imageNamed: "Images/background")
        
        /* Definitions */
        let verticalButtonSpace = size.height / CGFloat(buttonsCount)
        let horizontalPadding = size.width * 0.1
        let verticalPadding = verticalButtonSpace * 0.1
        let buttonSize = CGSize(width: size.width - 2 * horizontalPadding, height: verticalButtonSpace - 2 * verticalPadding)
        
        /* Initialize and configure all properties */
        self.mainMenuControllerDelegate = mainMenuControllerDelegate
        
        resumeButton = ButtonNode(size: buttonSize, labelText: "Resume Game") // texture set via external configuration
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init?(coder:) is not implemented")
    }
    
    
    // MARK: - Public Functions
    
    func configureResumeAvailable(_ available: Bool) {
        resumeAvailable = available
        resumeButton.fillTexture = available ? kButtonActiveTexture : kButtonInactiveTexture
    }
    
    
    // MARK: - UIEvent Handlers
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        
        if resumeAvailable && resumeButton.contains(location) {
            resumeButton.fillTexture = kButtonSelectedTexture
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
        
        if resumeAvailable && resumeButton.contains(location) {
            mainMenuControllerDelegate.didTapMenuButton(with: .resumeGame)
        }
        if startButton.contains(location) {
            mainMenuControllerDelegate.didTapMenuButton(with: .newGame)
        }
        if highscoreButton.contains(location) {
            mainMenuControllerDelegate.didTapMenuButton(with: .presentHighscores)
        }
        if aboutButton.contains(location) {
            mainMenuControllerDelegate.didTapMenuButton(with: .presentAbout)
        }
        resumeButton.fillTexture = resumeAvailable ? kButtonActiveTexture : kButtonInactiveTexture
        startButton.fillTexture = kButtonActiveTexture
        highscoreButton.fillTexture = kButtonActiveTexture
        aboutButton.fillTexture = kButtonActiveTexture
    }
}
