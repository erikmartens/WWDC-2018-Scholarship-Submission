import SpriteKit

fileprivate let kTextLines = ["Who Wants to Be a Developer",
                              "Created with 💜 by Erik Maximilian Martens, Sounds by Various Artists (See Credits File)\n",
                              "Answer as many questions as possible in this arcade style quiz game. Try to set a new highscore and even compete with your friends in local player mode. The fifty-fifty-joker gets reset every 10 rounds.",
                              "This Playground was built to live on past the WWDC 2018 scholarship application process. Hopefully this project will accelerate the personal journeys of those who want to shape the world, by providing a platform and code examples for learning. Therefore this project will be open sourced via GitHub. The complete code and assets will be subject to the MIT license, meaning anyone can use, modify or redistribute the contents of this project in part or its entirety.\n",
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
