import Foundation
import SpriteKit

class GameNode: SKSpriteNode {

    // MARK: - Private Properties
    // implicitely force unwrap gameControllerDelegate
    // they should never be nil and if it is we want to know by crashing the app, so we are alerted and can fix it

    private weak var gameControllerDelegate: GameControllerDelegate!

    private var questionLabel: QuestionLabelNode!
    private(set) var answerOption_0: ButtonNode!
    private(set) var answerOption_1: ButtonNode!
    private(set) var answerOption_2: ButtonNode!
    private(set) var answerOption_3: ButtonNode!
    private(set) var jokerFiftyFiftyButton: ButtonNode!
    private(set) var jokerAudienceButton: ButtonNode!
    private(set) var pauseButton: ButtonNode!
    
    /* Store Current Model Properties for Round */
    
    private(set) var answerOptionActive_0 = true
    private(set) var answerOptionActive_1 = true
    private(set) var answerOptionActive_2 = true
    private(set) var answerOptionActive_3 = true


    // MARK: - Initialization

    init(frame: CGRect, gameControllerDelegate: GameControllerDelegate) {
        
        super.init(texture: nil, color: .clear, size: .zero)

        /* Additional Configuration */
        isUserInteractionEnabled = true
        size = CGSize(width: frame.size.width, height: frame.size.height)
        position = CGPoint(x: frame.midX, y: frame.midY)
        texture = SKTexture(imageNamed: "Images/background")

        /* Definitions */
        let questionLabelNodeHeight = size.height * 0.25
        let questionLabelNodeSize = CGSize(width: size.width, height: questionLabelNodeHeight)

        let verticalButtonSpace = (size.height - questionLabelNodeHeight) / CGFloat(3)
        let horizontalPadding = size.width * 0.1
        let verticalPadding = verticalButtonSpace * 0.1
        let buttonSizeRegular = CGSize(width: size.width / 2 - horizontalPadding / 4, height: verticalButtonSpace - 2 * verticalPadding)
        let buttonSizeSmall = CGSize(width: size.width / 3 - horizontalPadding, height: verticalButtonSpace - 2 * verticalPadding)

        /* Initialize and configure all properties */
        self.gameControllerDelegate = gameControllerDelegate

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
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init?(coder:) is not implemented")
    }

    
    // MARK: - Public Properties & Function
    
    func configure(with question: QuestionDTO, questionIndex: Int, jokerFiftyFiftyActive: Bool, jokerAudienceActive: Bool) {
        
        isUserInteractionEnabled = true
        
        // force unwrap, this should never fail and we want to know if it does, so we can fix the questions-file
        questionLabel.questionNumberLabelText = "Q# \(questionIndex + 1)"
        questionLabel.questionLabelText = question.question
        
        answerOption_0.fillTexture = kButtonActiveTexture
        answerOption_1.fillTexture = kButtonActiveTexture
        answerOption_2.fillTexture = kButtonActiveTexture
        answerOption_3.fillTexture = kButtonActiveTexture
        
        answerOptionActive_0 = true
        answerOptionActive_1 = true
        answerOptionActive_2 = true
        answerOptionActive_3 = true
        
        answerOption_0.labelText = "A: \(question.answerOptions[.optionA]!)"
        answerOption_1.labelText = "B: \(question.answerOptions[.optionB]!)"
        answerOption_2.labelText = "C: \(question.answerOptions[.optionC]!)"
        answerOption_3.labelText = "D: \(question.answerOptions[.optionD]!)"
        
        jokerFiftyFiftyButton.fillTexture = jokerFiftyFiftyActive ? kJokerFiftyFiftyActiveTexture : kJokerFiftyFiftyInactiveTexture
        jokerAudienceButton.fillTexture = jokerAudienceActive ? kJokerAudienceActiveTexture : kJokerAudienceInactiveTexture
    }
    
    func updateTimer(with timeLeft: TimeInterval) {
        questionLabel.timerLabelText = "\(timeLeft.stringFromTime)"
        guard timeLeft < 10 else {
            questionLabel.timerLabelFontColor = .white
            return
        }
        questionLabel.timerLabelFontColor = .orange
    }
    
    func markAnswerOption(_ option: AnswerOption, usingTexture texture: SKTexture) {
        switch option {
        case .optionA:
            answerOption_0.fillTexture = texture
        case .optionB:
            answerOption_1.fillTexture = texture
        case .optionC:
            answerOption_2.fillTexture = texture
        case .optionD:
            answerOption_3.fillTexture = texture
        }
    }
    
    func markAnswerOptionInactive(_ option: AnswerOption) {
        switch option {
        case .optionA:
            answerOptionActive_0 = false
            answerOption_0.fillTexture = kButtonInactiveTexture
        case .optionB:
            answerOptionActive_1 = false
            answerOption_1.fillTexture = kButtonInactiveTexture
        case .optionC:
            answerOptionActive_2 = false
            answerOption_2.fillTexture = kButtonInactiveTexture
        case .optionD:
            answerOptionActive_3 = false
            answerOption_3.fillTexture = kButtonInactiveTexture
        }
    }
}

fileprivate extension TimeInterval {
    
    var stringFromTime: String {
        return String(format: "%02d : %02d", Int((self/60.0).truncatingRemainder(dividingBy: 60)), Int((self).truncatingRemainder(dividingBy: 60)))
    }
}
