import SpriteKit

protocol GameNodeDelegate: class {
    func configure(with model: GameModel)
    func updateTimer(with time: Int)
}

class GameNode: SKSpriteNode {

    // MARK: - Public Properties

    let nodeType: NodeType = .highscores


    // MARK: - Private Properties

    private weak var applicationDelegate: ApplicationDelegate?

    private var questionLabel: QuestionLabelNode!
    private var answerOption_0: ButtonNode!
    private var answerOption_1: ButtonNode!
    private var answerOption_2: ButtonNode!
    private var answerOption_3: ButtonNode!
    private var jokerFiftyFiftyButton: ButtonNode!
    private var jokerAudienceButton: ButtonNode!
    private var dropoutButton: ButtonNode!

    private var backgroundImage: SKSpriteNode!

    private let rowsCount = 3
    private let buttonsCount = 7
    private var buttons: [ButtonNode] {
        return [answerOption_0, answerOption_1, answerOption_2, answerOption_3, jokerFiftyFiftyButton, jokerAudienceButton, dropoutButton]
    }


    // MARK: - Initialization

    init(applicationDelegate: ApplicationDelegate) {

        super.init(texture: nil, color: .clear, size: .zero)

        /* Additional Configuration */
        isUserInteractionEnabled = true
        size = CGSize(width: applicationDelegate.aplicationFrame.size.width, height: applicationDelegate.aplicationFrame.size.height)
        position = CGPoint(x: applicationDelegate.aplicationFrame.midX, y: applicationDelegate.aplicationFrame.midY)

        /* Definitions */
        let questionLabelNodeHeight = size.height * 0.25
        let questionLabelNodeSize = CGSize(width: size.width, height: questionLabelNodeHeight)

        let verticalButtonSpace = (size.height - questionLabelNodeHeight) / CGFloat(rowsCount)
        let horizontalPadding = size.width * 0.1
        let verticalPadding = verticalButtonSpace * 0.1
        let buttonSizeRegular = CGSize(width: size.width / 2 - 2 * horizontalPadding, height: verticalButtonSpace - 2 * verticalPadding)
        let buttonSizeSmall = CGSize(width: size.width / 3 - 4 * horizontalPadding, height: verticalButtonSpace - 4 * verticalPadding)

        /* Initialize and configure all properties */
        self.applicationDelegate = applicationDelegate

        backgroundImage = SKSpriteNode(imageNamed: "Images/background")
        backgroundImage.size = applicationDelegate.aplicationFrame.size
        backgroundImage.zPosition = -1

        questionLabel = QuestionLabelNode(size: questionLabelNodeSize, questionNumberLabelText: "", questionLabelText: "", timeLabelText: "") // todo
        let questionLabelCoordinateY = size.height / CGFloat(2) - instructionNodeHeight / CGFloat(2)
        questionLabel.position = CGPoint(x: 0, y: instructionLabelCoordinateY)

        classicModeButton = ButtonNode(size: buttonSizeRegular, labelText: "Classic Mode", backgroundTexture: kButtonActiveTexture) // todo
        let classicModeButtonCoordinateY = verticalButtonSpace / CGFloat(2)
        classicModeButton.position = CGPoint(x: 0, y: classicModeButtonCoordinateY)

        arcadeModeButton = ButtonNode(size: buttonSizeRegular, labelText: "Arcade Mode", backgroundTexture: kButtonActiveTexture)
        let arcadeModeButtonCoordinateY = verticalButtonSpace / CGFloat(2)
        arcadeModeButton.position = CGPoint(x: 0, y: -arcadeModeButtonCoordinateY)

        backButton = ButtonNode(size: buttonSizeSmall, labelText: "Back", backgroundTexture: kButtonActiveTexture)
        let backButtonCoordinateY = verticalButtonSpace + verticalButtonSpace / CGFloat(2)
        backButton.position = CGPoint(x: 0, y: -backButtonCoordinateY)

        addChild(questionLabel)
        addChild(answerOption_0)
        addChild(answerOption_0)
        addChild(answerOption_0)
        addChild(answerOption_0)
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

        buttons.forEach { $0.fillTexture = kButtonActiveTexture }
    }
}

extension GameNode: GameNodeDelegate {
    
    func configure(with model: GameModel) {
        
    }
    
    func updateTimer(with time: Int) {
        
    }
}
