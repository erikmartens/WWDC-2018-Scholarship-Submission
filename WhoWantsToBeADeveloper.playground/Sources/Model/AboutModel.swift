import SpriteKit

fileprivate let kTextLines = ["Who Wants to Be a Developer",
                              "Created with 💜 by Erik Maximilian Martens\n",
                              "This Playground was built to live on past the WWDC 2018 scholarship application process. When developing the game the idea was always to share it with the community after the judging process had been completed. Hopefully this project will accelerate the personal journeys of those who want to shape the world, by providing a platform and code examples for learning. Therefore the complete code will be open sourced via GitHub. The repository will be subject to the MIT license, meaning anyone can use, modify or redistribute the contents of this project in part or its entirety in any way they please.\n",
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
