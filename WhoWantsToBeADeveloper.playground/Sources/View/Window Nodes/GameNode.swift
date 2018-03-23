import SpriteKit

class GameNode: SKSpriteNode {

    // MARK: - Private Properties
    // implicitely force unwrap gameControllerDelegate
    // they should never be nil and if it is we want to know by crashing the app, so we are alerted and can fix it

    private weak var gameControllerDelegate: GameControllerDelegate!

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
        let buttonSizeRegular = CGSize(width: size.width / 2 - horizontalPadding / 4, height: verticalButtonSpace - 2 * verticalPadding)
        let buttonSizeSmall = CGSize(width: size.width / 3 - horizontalPadding, height: verticalButtonSpace - 2 * verticalPadding)

        /* Initialize and configure all properties */
        self.gameControllerDelegate = gameControllerDelegate

        backgroundImage = SKSpriteNode(imageNamed: "Images/background")
        backgroundImage.size = frame.size
        backgroundImage.zPosition = -1

        questionLabel = QuestionLabelNode(size: questionLabelNodeSize)
        let questionLabelCoordinateY = size.height / CGFloat(2) - questionLabelNodeHeight / CGFloat(2)
        questionLabel.position = CGPoint(x: 0, y: questionLabelCoordinateY)

        let answerOptionsLeftCoordinateX = -(size.width / 4)
        let answerOptionsRightCoordinateX = size.width / 4
        let answerOptionsTopCoordinateY = verticalButtonSpace / CGFloat(2)
        let answerOptionsBottomCoordinateY = -(verticalButtonSpace / CGFloat(2))
        let bottomButtonsCoordinateY = -(verticalButtonSpace + verticalButtonSpace / CGFloat(2))

        answerOption_0 = ButtonNode(size: buttonSizeRegular, backgroundTexture: kButtonActiveTexture)
        answerOption_0.position = CGPoint(x: answerOptionsLeftCoordinateX, y: answerOptionsTopCoordinateY)

        answerOption_1 = ButtonNode(size: buttonSizeRegular, backgroundTexture: kButtonActiveTexture)
        answerOption_1.position = CGPoint(x: answerOptionsRightCoordinateX, y: answerOptionsTopCoordinateY)

        answerOption_2 = ButtonNode(size: buttonSizeRegular, backgroundTexture: kButtonActiveTexture)
        answerOption_2.position = CGPoint(x: answerOptionsLeftCoordinateX, y: answerOptionsBottomCoordinateY)

        answerOption_3 = ButtonNode(size: buttonSizeRegular, backgroundTexture: kButtonActiveTexture)
        answerOption_3.position = CGPoint(x: answerOptionsRightCoordinateX, y: answerOptionsBottomCoordinateY)

        jokerFiftyFiftyButton = ButtonNode(size: buttonSizeSmall, backgroundTexture: kJokerFiftyFiftyActiveTexture)
        jokerFiftyFiftyButton.position = CGPoint(x: -(size.width / 3), y: bottomButtonsCoordinateY)

        jokerAudienceButton = ButtonNode(size: buttonSizeSmall, backgroundTexture: kJokerAudienceActiveTexture)
        jokerAudienceButton.position = CGPoint(x: 0, y: bottomButtonsCoordinateY)

        pauseButton = ButtonNode(size: buttonSizeSmall, backgroundTexture: kButtonPauseActiveTexture)
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
    
    // MARK: - Public Properties & Function
    
    func configure(with question: QuestionDTO, questionNumber: Int, jokerFiftyFiftyActive: Bool, jokerAudienceActive: Bool) {
        
        // force unwrap, this should never fail and we want to know if it does, so we can fix the questions-file
        questionLabel.questionNumberLabelText = "Q# \(questionNumber)"
        questionLabel.questionLabelText = question.question
        
        answerOption_0.labelText = "A: \(question.answerOptions[.optionA]!)"
        answerOption_1.labelText = "B: \(question.answerOptions[.optionB]!)"
        answerOption_2.labelText = "C: \(question.answerOptions[.optionC]!)"
        answerOption_3.labelText = "D: \(question.answerOptions[.optionD]!)"
    }
    
    func updateTimer(with time: Int) { // todo: timeleft
        questionLabel.timerLabelText = "\(time)"
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
            gameControllerDelegate.didSelectAnswerOption(.optionA)
        }
        
        if answerOption_1.contains(location) {
            gameControllerDelegate.didSelectAnswerOption(.optionB)
        }
        
        if answerOption_2.contains(location) {
            gameControllerDelegate.didSelectAnswerOption(.optionC)
        }
        
        if answerOption_3.contains(location) {
            gameControllerDelegate.didSelectAnswerOption(.optionD)
        }
        
        if jokerFiftyFiftyButton.contains(location) {
            gameControllerDelegate.didSelectJokerOption(.fiftyFifty)
        }
        
        if jokerAudienceButton.contains(location) {
            gameControllerDelegate.didSelectJokerOption(.audience)
        }
        
        if pauseButton.contains(location) {
            gameControllerDelegate.didSelectPause()
        }

        answerOptionButtons.forEach { $0.fillTexture = kButtonActiveTexture }
        jokerFiftyFiftyButton.fillTexture = kJokerFiftyFiftyActiveTexture
        jokerAudienceButton.fillTexture = kJokerAudienceActiveTexture
        pauseButton.fillTexture = kButtonPauseSelectedTexture
    }
}
