import SpriteKit

class MainMenuNode: SKSpriteNode {
    
    // MARK: - Public Properties
    
    let nodeType: NodeType = .mainMenu
    
    
    // MARK: - Private Properties
    
    private weak var applicationDelegate: ApplicationDelegate?
    
    private let buttonCount = 3
    private var startButton: SKSpriteNode!
    private var highscoreButton: SKSpriteNode!
    private var addQuestionButton: SKSpriteNode!
    
    private var backgroundImage: SKSpriteNode!
    
    
    // MARK: - Initialization
    
    init(applicationDelegate: ApplicationDelegate) {
        let texture = SKTexture(imageNamed: "Images/background")
        super.init(texture: texture, color: .clear, size: .zero)
        
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
//        let buttonCoordinateX = size.width / CGFloat(2)
        
        startButton = SKSpriteNode(imageNamed: "Images/button_active")
        startButton.size = CGSize(width: size.width - 2 * horizontalPadding, height: verticalButtonSpace - 2 * verticalPadding)
        let startButtonCoordinateY = verticalButtonSpace / CGFloat(2)
        startButton.position = CGPoint(x: 0, y: -startButtonCoordinateY)
        
        highscoreButton = SKSpriteNode(imageNamed: "Images/button_active")
        highscoreButton.size = CGSize(width: size.width - 2 * horizontalPadding, height: verticalButtonSpace - 2 * verticalPadding)
        let highscoreButtonCoordinateY = verticalButtonSpace + verticalButtonSpace / CGFloat(2)
        highscoreButton.position = CGPoint(x: 0, y: -highscoreButtonCoordinateY)
        
        addQuestionButton = SKSpriteNode(imageNamed: "Images/button_active")
        addQuestionButton.size = CGSize(width: size.width - 2 * horizontalPadding, height: verticalButtonSpace - 2 * verticalPadding)
        let addQuestionButtonCoordinateY = verticalButtonSpace * 2 + verticalButtonSpace / CGFloat(2)
        addQuestionButton.position = CGPoint(x: 0, y: -addQuestionButtonCoordinateY)

        addChild(startButton)
        addChild(highscoreButton)
        addChild(addQuestionButton)
        addChild(backgroundImage)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - UIEvent Handlers
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
                return
        }
        let location = touch.location(in: self)
        
        if startButton.contains(location) {
            startButton.texture = SKTexture(imageNamed: "Images/button_selected")
            applicationDelegate?.didSelectNode(with: .game)
            return
        }
        
        if highscoreButton.contains(location) {
            highscoreButton.texture = SKTexture(imageNamed: "Images/button_selected")
            applicationDelegate?.didSelectNode(with: .highscore)
            return
        }
        
        if addQuestionButton.contains(location) {
            addQuestionButton.texture = SKTexture(imageNamed: "Images/button_selected")
            applicationDelegate?.didSelectNode(with: .addQuestion)
            return
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    // MARK: - Private Helpers
}
