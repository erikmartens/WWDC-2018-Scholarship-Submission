import SpriteKit

class MainMenuNode: SKSpriteNode {
    
    // MARK: - Public Properties
    
    let nodeType: NodeType = .mainMenu
    
    
    // MARK: - Private Properties
    
    private weak var applicationDelegate: ApplicationDelegate?
    
    private var resumeButton: ButtonNode!
    private var startButton: ButtonNode!
    private var highscoreButton: ButtonNode!
    private var addQuestionButton: ButtonNode!
    
    private var backgroundImage: SKSpriteNode!
    
    private var buttons: [ButtonNode] {
        return [resumeButton, startButton, highscoreButton, addQuestionButton]
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
        
        let verticalButtonSpace = size.height / CGFloat(4)
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
        
        addQuestionButton = ButtonNode(size: buttonSize, labelText: "Add Questions", backgroundTexture: kButtonActiveTexture)
        let addQuestionButtonCoordinateY = verticalButtonSpace + verticalButtonSpace / CGFloat(2)
        addQuestionButton.position = CGPoint(x: 0, y: -addQuestionButtonCoordinateY)
        
        addChild(resumeButton)
        addChild(startButton)
        addChild(highscoreButton)
        addChild(addQuestionButton)
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
        
        if addQuestionButton.contains(location) {
            addQuestionButton.fillTexture = kButtonSelectedTexture
            return
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        
        if resumeButton.contains(location) {
            resumeButton.fillTexture = kButtonInactiveTexture // todo
            applicationDelegate?.didSelectNode(with: .game) // todo
            return
        }
        
        if startButton.contains(location) {
            startButton.fillTexture = kButtonActiveTexture
            applicationDelegate?.didSelectNode(with: .game)
            return
        }
        
        if highscoreButton.contains(location) {
            highscoreButton.fillTexture = kButtonActiveTexture
            applicationDelegate?.didSelectNode(with: .highscore)
            return
        }
        
        if addQuestionButton.contains(location) {
            addQuestionButton.fillTexture = kButtonActiveTexture
            applicationDelegate?.didSelectNode(with: .addQuestion)
            return
        }
        
        buttons.forEach { $0.fillTexture = kButtonActiveTexture }
    }
}
