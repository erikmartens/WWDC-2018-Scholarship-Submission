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

class RegisterHighscoreModel {
    
    // MARK: - Public Properties
    
    var score: Int!
    
    var scoreText: NSMutableAttributedString {
        let pluralModifierString = score != 1 ? "s" : ""
        let texts = [kTitleText, String(format: "You Answered %d Question%@", score, pluralModifierString)]
        let instructionString = texts.joined(separator: "\n")
        let attributedInstructionString = NSMutableAttributedString(string: instructionString)
        for index in 0..<texts.count {
            attributedInstructionString.setAttributes(kTitleTextAttributes[index], range: (instructionString as NSString).range(of: texts[index]))
        }
        return attributedInstructionString
    }
}
