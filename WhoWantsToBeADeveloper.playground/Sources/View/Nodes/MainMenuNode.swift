import SpriteKit

class MainMenuNode: SKSpriteNode {
    
    // MARK: - Public Properties
    
    let nodeType: NodeType = .mainMenu
    
    
    // MARK: - Private Properties
    
    private weak var applicationDelegate: ApplicationDelegate?
    
    private let buttonCount = 4
    private var resumeButton: ButtonNode!
    private var startButton: ButtonNode!
    private var highscoreButton: ButtonNode!
    private var addQuestionButton: ButtonNode!
    
    private var backgroundImage: SKSpriteNode!
    
    
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
        
        let verticalButtonSpace = size.height / CGFloat(buttonCount)
        let horizontalPadding = size.width * 0.1
        let verticalPadding = verticalButtonSpace * 0.1
        let buttonRect = CGRect(x: 0, y: 0, width: size.width - 2 * horizontalPadding, height: verticalButtonSpace - 2 * verticalPadding)
        
        resumeButton = ButtonNode(rect: buttonRect, labelText: "Resume Game", backgroundImageName: "Images/button_inactive") // todo
        let resumeButtonCoordinateY = verticalButtonSpace + verticalButtonSpace / CGFloat(2)
        resumeButton.position = CGPoint(x: 0, y: resumeButtonCoordinateY)
        
        startButton = ButtonNode(rect: buttonRect, labelText: "Start New Game", backgroundImageName: "Images/button_active")
        let startButtonCoordinateY = verticalButtonSpace / CGFloat(2)
        startButton.position = CGPoint(x: 0, y: startButtonCoordinateY)
        
        highscoreButton = ButtonNode(rect: buttonRect, labelText: "Highscores", backgroundImageName: "Images/button_active")
        let highscoreButtonCoordinateY = verticalButtonSpace / CGFloat(2)
        highscoreButton.position = CGPoint(x: 0, y: -highscoreButtonCoordinateY)
        
        addQuestionButton = ButtonNode(rect: buttonRect, labelText: "Add Questions", backgroundImageName: "Images/button_active")
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
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
                return
        }
        let location = touch.location(in: self)
        
        if resumeButton.contains(location) {
            resumeButton.backgroundNode.texture = SKTexture(imageNamed: "Images/button_selected") // todo
            return
        }
        
        if startButton.contains(location) {
            startButton.backgroundNode.texture = SKTexture(imageNamed: "Images/button_selected")
            return
        }
        
        if highscoreButton.contains(location) {
            highscoreButton.backgroundNode.texture = SKTexture(imageNamed: "Images/button_selected")
            return
        }
        
        if addQuestionButton.contains(location) {
            addQuestionButton.backgroundNode.texture = SKTexture(imageNamed: "Images/button_selected")
            return
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        
        if resumeButton.contains(location) {
            resumeButton.backgroundNode.texture = SKTexture(imageNamed: "Images/button_inactive") // todo
             applicationDelegate?.didSelectNode(with: .game) // todo
            return
        }
        
        if startButton.contains(location) {
            startButton.backgroundNode.texture = SKTexture(imageNamed: "Images/button_active")
            applicationDelegate?.didSelectNode(with: .game)
            return
        }
        
        if highscoreButton.contains(location) {
            highscoreButton.backgroundNode.texture = SKTexture(imageNamed: "Images/button_active")
            applicationDelegate?.didSelectNode(with: .highscore)
            return
        }
        
        if addQuestionButton.contains(location) {
            addQuestionButton.backgroundNode.texture = SKTexture(imageNamed: "Images/button_active")
            applicationDelegate?.didSelectNode(with: .addQuestion)
            return
        }
    }
    
    // MARK: - Private Helpers
}
