import SpriteKit

fileprivate let kTextLines = ["Who Wants to Be a Developer",
                              "Created with 💜 by Erik Maximilian Martens, Sounds by Various Artists (See Credits File)\n",
                              "Answer as many questions as possible in this arcade style quiz game. Try to set a new highscore and even compete with your friends locally. Simply set your nickname in the player-name-file. The fifty-fifty-joker gets reactivated every 10 rounds after it was used.",
                              "This game comes pre-loaded with questions based on the Basics chapter of the Swift documentation (link in the credits-file). Start by extending the library of questions using more advanced chapters of the documentation. You will learn a lot just from creating them. Once you are ready, try to extend the game's functionality. Here's an idea: Build an algorithm that allows you play the questions in order of their difficulty (that you define for each question).",
                              "👩‍💻 Hope to meet you at the WWDC 18 👨‍💻"]

fileprivate let kTextAttributes = [
    [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 28),
     NSAttributedStringKey.foregroundColor: UIColor.white,
     NSAttributedStringKey.paragraphStyle: NSMutableParagraphStyle(alignment: .center)],
    
    [NSAttributedStringKey.font: UIFont.italicSystemFont(ofSize: 16),
     NSAttributedStringKey.foregroundColor: UIColor.white,
     NSAttributedStringKey.paragraphStyle: NSMutableParagraphStyle(alignment: .center)],
    
    [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12),
     NSAttributedStringKey.foregroundColor: UIColor.white,
     NSAttributedStringKey.paragraphStyle: NSMutableParagraphStyle(alignment: .justified)],
    
    [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12),
     NSAttributedStringKey.foregroundColor: UIColor.white,
     NSAttributedStringKey.paragraphStyle: NSMutableParagraphStyle(alignment: .justified)],
    
    [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16),
     NSAttributedStringKey.foregroundColor: UIColor.white,
     NSAttributedStringKey.paragraphStyle: NSMutableParagraphStyle(alignment: .center)]
]

class AboutModel {
    
    // MARK: - Public Properties
    
    var aboutText: NSMutableAttributedString {
        let aboutString = kTextLines.joined(separator: "\n")
        let attributedAboutString = NSMutableAttributedString(string: aboutString)
        for index in 0..<kTextLines.count {
            attributedAboutString.setAttributes(kTextAttributes[index], range: (aboutString as NSString).range(of: kTextLines[index]))
        }
        return attributedAboutString
    }
}
