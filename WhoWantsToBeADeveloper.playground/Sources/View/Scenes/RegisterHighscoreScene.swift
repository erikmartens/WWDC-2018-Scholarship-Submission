import SpriteKit

class RegisterHighscoreScene: SKScene {
    
    // MARK: - Public Properties
    
    weak var registerHighscoreControllerDelegate: RegisterHighscoreControllerDelegate!
    
    
    // MARK: - Private Properties
    
    private var registerHighscoreNode: RegisterHighscoreNode!
    
    
    // MARK: - Overrides
    
    override func didMove(to view: SKView) {
        size = view.frame.size
        
        if registerHighscoreNode == nil {
            registerHighscoreNode = RegisterHighscoreNode(frame: view.frame, registerHighscoreControllerDelegate: registerHighscoreControllerDelegate)
        }
        addChild(registerHighscoreNode)
    }
    
    override func willMove(from: SKView) {
        removeAllChildren()
    }
    
    
    // MARK: - Public Functions
    
    func configure(with scoreText: NSMutableAttributedString) {
        registerHighscoreNode.configure(with: scoreText)
    }
    
    func configureEnteredName(with name: String) {
        registerHighscoreNode.configureEnterNameNode(with: name)
    }
    
    
    // MARK: - Input Event Handlers
    
    override func mouseDown(with event: NSEvent) {
        let mousePoint = convertPoint(fromView: CGPoint(x: event.locationInWindow.x, y: event.locationInWindow.y))
        guard let touchedNode = nodes(at: mousePoint).first else {
            return
        }
        if touchedNode == registerHighscoreNode.saveButton {
            registerHighscoreNode.saveButton.fillTexture = kButtonSelectedTexture
        }
    }
    
    override func mouseUp(with event: NSEvent) {
        let mousePoint = convertPoint(fromView: CGPoint(x: event.locationInWindow.x, y: event.locationInWindow.y))
        guard let touchedNode = nodes(at: mousePoint).first else {
            return
        }
        if touchedNode == registerHighscoreNode.saveButton {
            registerHighscoreControllerDelegate.didTapSaveButton(withNameEntered: registerHighscoreNode.enteredName ?? "PlayerUnkown")
        }
        registerHighscoreNode.saveButton.fillTexture = kButtonActiveTexture
    }
    
    override func keyDown(with event: NSEvent) {
        var selectedCharacter = ""
        
        switch event.keyCode {
        case 0: selectedCharacter = "a"
        case 1: selectedCharacter = "s"
        case 2: selectedCharacter = "d"
        case 3: selectedCharacter = "f"
        case 4: selectedCharacter = "h"
        case 5: selectedCharacter = "g"
        case 6: selectedCharacter = "z"
        case 7: selectedCharacter = "x"
        case 8: selectedCharacter = "c"
        case 9: selectedCharacter = "v"
        case 11: selectedCharacter = "b"
        case 12: selectedCharacter = "q"
        case 13: selectedCharacter = "w"
        case 14: selectedCharacter = "e"
        case 15: selectedCharacter = "r"
        case 16: selectedCharacter = "y"
        case 17: selectedCharacter = "t"
        case 18: selectedCharacter = "1"
        case 19: selectedCharacter = "2"
        case 20: selectedCharacter = "3"
        case 21: selectedCharacter = "4"
        case 22: selectedCharacter = "6"
        case 23: selectedCharacter = "5"
        //case 24: selectedCharacter = "="
        case 25: selectedCharacter = "9"
        case 26: selectedCharacter = "7"
        case 27: selectedCharacter = "-"
        case 28: selectedCharacter = "8"
        case 29: selectedCharacter = "0"
        case 30: selectedCharacter = "]"
        case 31: selectedCharacter = "o"
        case 32: selectedCharacter = "u"
        case 33: selectedCharacter = "["
        case 34: selectedCharacter = "i"
        case 35: selectedCharacter = "p"
        case 36:
            registerHighscoreControllerDelegate.didPressKeyboardKey(.enter(registerHighscoreNode.enteredName ?? "PlayerUnkown"))
            return
        case 37: selectedCharacter = "l"
        case 38: selectedCharacter = "j"
        case 39: selectedCharacter = "'"
        case 40: selectedCharacter = "k"
        //case 41: selectedCharacter = ";"
        //case 42: selectedCharacter = "\\"
        case 43: selectedCharacter = ","
        //case 44: selectedCharacter = "/"
        case 45: selectedCharacter = "n"
        case 46: selectedCharacter = "m"
        case 47: selectedCharacter = "."
        case 49: selectedCharacter = " "
        case 50: selectedCharacter = "`"
        case 51:
            let currentName = registerHighscoreNode.enteredName
            if currentName != nil && !currentName!.isEmpty {
                registerHighscoreControllerDelegate.didPressKeyboardKey(.backspace(currentName!))
            }
            return
        default: return
        }
        
        registerHighscoreControllerDelegate.didPressKeyboardKey(.character(registerHighscoreNode.enteredName ?? "", selectedCharacter))
    }
}
