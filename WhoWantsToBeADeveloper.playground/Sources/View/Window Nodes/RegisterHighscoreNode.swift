import SpriteKit

fileprivate let kTitleText = "Game Over"

fileprivate let kTitleTextAttributes = [
    [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 28),
     NSAttributedStringKey.foregroundColor: UIColor.white,
     NSAttributedStringKey.paragraphStyle: NSMutableParagraphStyle(alignment: .center)],
    
    [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16),
     NSAttributedStringKey.foregroundColor: UIColor.white,
     NSAttributedStringKey.paragraphStyle: NSMutableParagraphStyle(alignment: .center)]
]

class RegisterHighscoreNode: SKSpriteNode {
    
    // MARK: - Private Properties
    
    private weak var highscoreControllerDelegate: HighscoreControllerDelegate!
    private var score: Int!
    
    private var instructionLabel: LabelNode!
    private var enterNameNode: TextEntryNode!
    private var triggerNameEntryButton: ButtonNode!
    private var saveButton: ButtonNode!
    
    private var buttons: [ButtonNode] {
        return [triggerNameEntryButton, saveButton]
    }
    
    // MARK: - Initialization
    
    init(frame: CGRect, highscoreControllerDelegate: HighscoreControllerDelegate, score: Int) {
        
        super.init(texture: nil, color: .clear, size: .zero)
        
        /* Additional Configuration */
        isUserInteractionEnabled = true
        size = CGSize(width: frame.size.width, height: frame.size.height)
        position = CGPoint(x: frame.midX, y: frame.midY)
        texture = SKTexture(imageNamed: "Images/background")
        
        /* Definitions */
        let instructionNodeHeight = size.height * 0.25
        let instructionNodeSize = CGSize(width: size.width, height: instructionNodeHeight)
        
        let enterNameNodeWidth = size.width * 0.75
        let enterNameNodeHeight = size.height * 0.25
        let enterNameNodeSize = CGSize(width: enterNameNodeWidth, height: enterNameNodeHeight)
        
        let verticalButtonSpace = (size.height * 0.75) / CGFloat(6)
        let horizontalPadding = size.width * 0.1
        let verticalPadding = verticalButtonSpace * 0.1
        let buttonSizeSmall = CGSize(width: size.width / 2 - 2 * horizontalPadding, height: verticalButtonSpace - 2 * verticalPadding)
        
        /* Initialize and configure all properties */
        self.highscoreControllerDelegate = highscoreControllerDelegate
        self.score = score
        
        instructionLabel = LabelNode(size: instructionNodeSize)
        let instructionLabelCoordinateY = size.height / CGFloat(2) - instructionNodeHeight / CGFloat(2)
        instructionLabel.position = CGPoint(x: 0, y: instructionLabelCoordinateY)
        let pluralModifierString = score != 1 ? "s" : ""
        let texts = [kTitleText, String(format: "You Answered %d Question%@", score, pluralModifierString)]
        let instructionString = texts.joined(separator: "\n")
        let attributedInstructionString = NSMutableAttributedString(string: instructionString)
        for index in 0..<texts.count {
            attributedInstructionString.setAttributes(kTitleTextAttributes[index], range: (instructionString as NSString).range(of: texts[index]))
        }
        instructionLabel.labelAttributedText = attributedInstructionString
        
        enterNameNode = TextEntryNode(size: enterNameNodeSize, labelNodeText: "Enter Your Name:")
        //let enterNameNodeCoordinateY_0 = verticalButtonSpace + verticalButtonSpace / CGFloat(2)
        enterNameNode.position = CGPoint(x: 0, y: 0)
        
        let bottomButtonsCoordinateY = verticalButtonSpace * 3 + verticalButtonSpace / CGFloat(2)
        
        triggerNameEntryButton = ButtonNode(size: buttonSizeSmall, labelText: "Change Name", backgroundTexture: kButtonActiveTexture)
        triggerNameEntryButton.position = CGPoint(x: -(size.width / CGFloat(4)), y: -bottomButtonsCoordinateY)
        
        saveButton = ButtonNode(size: buttonSizeSmall, labelText: "Save", backgroundTexture: kButtonActiveTexture)
        saveButton.position = CGPoint(x: size.width / CGFloat(4), y: -bottomButtonsCoordinateY)
        
        addChild(instructionLabel)
        addChild(enterNameNode)
        addChild(triggerNameEntryButton)
        addChild(saveButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init?(coder:) is not implemented")
    }
    
    
    // MARK: - Event Handlers
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        
        if triggerNameEntryButton.contains(location) {
            triggerNameEntryButton.fillTexture = kButtonSelectedTexture
        }
        if saveButton.contains(location) {
            saveButton.fillTexture = kButtonSelectedTexture
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        
        if triggerNameEntryButton.contains(location) {
            highscoreControllerDelegate.triggerNameEntryAlertController { playerName in
                self.enterNameNode.enteredText = playerName
            }
        }
        if saveButton.contains(location) {
            highscoreControllerDelegate.didCompleteHighscoreInput(with: enterNameNode.enteredText)
        }
        buttons.forEach { $0.fillTexture = kButtonActiveTexture }
    }
    
    override func keyDown(with event: NSEvent) {
        print(event.keyCode)
//        switch event.keyCode {
//        case 0:
//        case 1:
//        case 2:
//        case 13:
//        case 31:
//        case 49: // space
//        default:
//            break
//        }
    }
}
