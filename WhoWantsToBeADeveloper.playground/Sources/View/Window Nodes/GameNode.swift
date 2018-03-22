import SpriteKit

protocol GameNodeDelegate: class {
    func configure(with model: GameModel)
    func updateTimer(with time: Int)
}

class GameNode: SKSpriteNode {

    // MARK: - Public Properties

    let nodeType: NodeType = .highscores


    // MARK: - Private Properties

    private weak var gameControllerDelegate: GameControllerDelegate?

    private var questionLabel: QuestionLabelNode!
    private var answerOption_0: ButtonNode!
    private var answerOption_1: ButtonNode!
    private var answerOption_2: ButtonNode!
    private var answerOption_3: ButtonNode!
    private var jokerFiftyFiftyButton: ButtonNode!
    private var jokerAudienceButton: ButtonNode!
    private var pauseButton: ButtonNode!

    private var backgroundImage: SKSpriteNode!

    private let rowsCount = 3
    private var answerOptionButtons: [ButtonNode] {
        return [answerOption_0, answerOption_1, answerOption_2, answerOption_3]
    }


    // MARK: - Initialization

    init(frame: CGRect, gameControllerDelegate: GameControllerDelegate) {
        
        super.init(texture: nil, color: .clear, size: .zero)

        /* Additional Configuration */
        isUserInteractionEnabled = true
        size = CGSize(width: frame.size.width, height: frame.size.height)
        position = CGPoint(x: frame.midX, y: frame.midY)

        /* Definitions */
        let questionLabelNodeHeight = size.height * 0.25
        let questionLabelNodeSize = CGSize(width: size.width, height: questionLabelNodeHeight)

        let verticalButtonSpace = (size.height - questionLabelNodeHeight) / CGFloat(rowsCount)
        let horizontalPadding = size.width * 0.1
        let verticalPadding = verticalButtonSpace * 0.1
        let buttonSizeRegular = CGSize(width: size.width / 2 - 2 * horizontalPadding, height: verticalButtonSpace - 2 * verticalPadding)
        let buttonSizeSmall = CGSize(width: size.width / 3 - 4 * horizontalPadding, height: verticalButtonSpace - 4 * verticalPadding)

        /* Initialize and configure all properties */
        self.gameControllerDelegate = gameControllerDelegate

        backgroundImage = SKSpriteNode(imageNamed: "Images/background")
        backgroundImage.size = frame.size
        backgroundImage.zPosition = -1

        questionLabel = QuestionLabelNode(size: questionLabelNodeSize, questionNumberLabelText: "", questionLabelText: "", timeLabelText: "") // todo
        let questionLabelCoordinateY = size.height / CGFloat(2) - questionLabelNodeHeight / CGFloat(2)
        questionLabel.position = CGPoint(x: 0, y: questionLabelCoordinateY)

        let answerOptionsLeftCoordinateX = -(size.width / 4)
        let answerOptionsRightCoordinateX = size.width / 4
        let answerOptionsTopCoordinateY = verticalButtonSpace + verticalButtonSpace / CGFloat(2)
        let answerOptionsBottomCoordinateY: CGFloat = 0
        let bottomButtonsCoordinateY = -(verticalButtonSpace + verticalButtonSpace / CGFloat(2))
        
        answerOption_0 = ButtonNode(size: buttonSizeRegular, labelText: "Option A", backgroundTexture: kButtonActiveTexture) // todo
        answerOption_0.position = CGPoint(x: answerOptionsLeftCoordinateX, y: answerOptionsTopCoordinateY)
        
        answerOption_1 = ButtonNode(size: buttonSizeRegular, labelText: "Option A", backgroundTexture: kButtonActiveTexture) // todo
        answerOption_1.position = CGPoint(x: answerOptionsRightCoordinateX, y: answerOptionsTopCoordinateY)
        
        answerOption_2 = ButtonNode(size: buttonSizeRegular, labelText: "Option A", backgroundTexture: kButtonActiveTexture) // todo
        answerOption_2.position = CGPoint(x: answerOptionsLeftCoordinateX, y: answerOptionsBottomCoordinateY)
        
        answerOption_3 = ButtonNode(size: buttonSizeRegular, labelText: "Option A", backgroundTexture: kButtonActiveTexture) // todo
        answerOption_3.position = CGPoint(x: answerOptionsRightCoordinateX, y: answerOptionsBottomCoordinateY)
        
        jokerFiftyFiftyButton = ButtonNode(size: buttonSizeSmall, labelText: "Classic Mode", backgroundTexture: kJokerFiftyFiftyActiveTexture) // todo
        jokerFiftyFiftyButton.position = CGPoint(x: -(size.width / 3), y: bottomButtonsCoordinateY)

        jokerAudienceButton = ButtonNode(size: buttonSizeSmall, labelText: "Arcade Mode", backgroundTexture: kJokerAudienceActiveTexture) // todo
        jokerAudienceButton.position = CGPoint(x: 0, y: bottomButtonsCoordinateY)

        pauseButton = ButtonNode(size: buttonSizeSmall, labelText: "Back", backgroundTexture: kButtonPauseActiveTexture) // todo
        pauseButton.position = CGPoint(x: size.width / 3, y: bottomButtonsCoordinateY)

        addChild(questionLabel)
        addChild(answerOption_0)
        addChild(answerOption_1)
        addChild(answerOption_2)
        addChild(answerOption_3)
        addChild(jokerFiftyFiftyButton)
        addChild(jokerAudienceButton)
        addChild(pauseButton)
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

        if answerOption_0.contains(location) {
            answerOption_0.fillTexture = kButtonSelectedTexture
            return
        }
        
        if answerOption_1.contains(location) {
            answerOption_1.fillTexture = kButtonSelectedTexture
            return
        }
        
        if answerOption_2.contains(location) {
            answerOption_2.fillTexture = kButtonSelectedTexture
            return
        }
        
        if answerOption_3.contains(location) {
            answerOption_3.fillTexture = kButtonSelectedTexture
            return
        }

        if jokerFiftyFiftyButton.contains(location) {
            jokerFiftyFiftyButton.fillTexture = kJokerFiftyFiftySelectedTexture
            return
        }
        
        if jokerAudienceButton.contains(location) {
            jokerAudienceButton.fillTexture = kJokerAudienceSelectedTexture
            return
        }

        if pauseButton.contains(location) {
            pauseButton.fillTexture = kButtonPauseSelectedTexture
            return
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)

        if answerOption_0.contains(location) {
            gameControllerDelegate?.didSelectAnswerOption(.optionA)
        }
        
        if answerOption_1.contains(location) {
            gameControllerDelegate?.didSelectAnswerOption(.optionB)
        }
        
        if answerOption_2.contains(location) {
            gameControllerDelegate?.didSelectAnswerOption(.optionC)
        }
        
        if answerOption_3.contains(location) {
            gameControllerDelegate?.didSelectAnswerOption(.optionD)
        }
        
        if jokerFiftyFiftyButton.contains(location) {
            gameControllerDelegate?.didSelectJokerOption(.fiftyFifty)
        }
        
        if jokerAudienceButton.contains(location) {
            gameControllerDelegate?.didSelectJokerOption(.audience)
        }
        
        if pauseButton.contains(location) {
            gameControllerDelegate?.didSelectPause()
        }

        answerOptionButtons.forEach { $0.fillTexture = kButtonActiveTexture }
        jokerFiftyFiftyButton.fillTexture = kJokerFiftyFiftyActiveTexture
        jokerAudienceButton.fillTexture = kJokerAudienceActiveTexture
        pauseButton.fillTexture = kButtonPauseSelectedTexture
    }
}

extension GameNode: GameNodeDelegate {
    
    func configure(with model: GameModel) {
        
    }
    
    func updateTimer(with time: Int) {
        
    }
}
