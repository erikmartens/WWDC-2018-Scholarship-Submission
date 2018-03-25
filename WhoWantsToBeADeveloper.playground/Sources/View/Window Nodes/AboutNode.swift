import SpriteKit

fileprivate let textLines = ["Who Wants to Be a Developer",
                             "Created with 💜 by Erik Maximilian Martens\n",
                             "This Playground was built to live on past the WWDC 2018 scholarship application process. When developing the game the idea was always to share it with the community, after the judging process had been completed. Hopefully this project will accelerate the personal journeys of those who want to shape the world, by providing a platform and code examples for learning. Therefore the complete code will be open sourced via GitHub. The repository will be subject to the MIT license, meaning anyone can use, modify or redistribute the contents of this project in part or its entirety in any way they please.",
                             "👩‍💻 Hope to meet you at the WWDC 18 👨‍💻"]

fileprivate let attributes = [
    [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 28),
     NSAttributedStringKey.foregroundColor: UIColor.white,
     NSAttributedStringKey.paragraphStyle: NSMutableParagraphStyle(alignment: .center)],
    
    [NSAttributedStringKey.font: UIFont.italicSystemFont(ofSize: 20),
     NSAttributedStringKey.foregroundColor: UIColor.white,
     NSAttributedStringKey.paragraphStyle: NSMutableParagraphStyle(alignment: .center)],
    
    [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12),
     NSAttributedStringKey.foregroundColor: UIColor.white,
     NSAttributedStringKey.paragraphStyle: NSMutableParagraphStyle(alignment: .justified)],
    
    [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 12),
     NSAttributedStringKey.foregroundColor: UIColor.white,
     NSAttributedStringKey.paragraphStyle: NSMutableParagraphStyle(alignment: .center)]
]

class AboutNode: SKSpriteNode {
    
    // MARK: - Private Properties
    
    private weak var applicationDelegate: ApplicationDelegate?
    
    private var aboutLabel: LabelNode!
    private var backButton: ButtonNode!
    
    private var backgroundImage: SKSpriteNode!
    
    
    // MARK: - Initialization
    
    init(applicationDelegate: ApplicationDelegate) {
        
        super.init(texture: nil, color: .clear, size: .zero)
        
        /* Additional Configuration */
        isUserInteractionEnabled = true
        size = CGSize(width: applicationDelegate.applicationFrame.size.width, height: applicationDelegate.applicationFrame.size.height)
        position = CGPoint(x: applicationDelegate.applicationFrame.midX, y: applicationDelegate.applicationFrame.midY)
        
        /* Definitions */
        let aboutNodeHeight = size.height * 0.85
        let aboutNodeSize = CGSize(width: size.width, height: aboutNodeHeight)
        
        let verticalButtonSpace = (size.height * 0.75) / CGFloat(6)
        let horizontalPadding = size.width * 0.1
        let verticalPadding = verticalButtonSpace * 0.1
        let buttonSizeSmall = CGSize(width: size.width / 2 - 2 * horizontalPadding, height: verticalButtonSpace - 2 * verticalPadding)
        
        /* Initialize and configure all properties */
        self.applicationDelegate = applicationDelegate
        
        backgroundImage = SKSpriteNode(imageNamed: "Images/background")
        backgroundImage.size = applicationDelegate.applicationFrame.size
        backgroundImage.zPosition = -1
        
        aboutLabel = LabelNode(size: aboutNodeSize)
        let aboutLabelCoordinateY =  size.height / CGFloat(2) - aboutNodeHeight / CGFloat(2)
        aboutLabel.position = CGPoint(x: 0, y: aboutLabelCoordinateY)
        
        let aboutString = textLines.joined(separator: "\n")
        let attrbutedAboutString = NSMutableAttributedString(string: aboutString)
        for index in 0..<textLines.count {
            attrbutedAboutString.setAttributes(attributes[index], range: (aboutString as NSString).range(of: textLines[index]))
        }
        
        aboutLabel.labelAttributedText = attrbutedAboutString
        
        backButton = ButtonNode(size: buttonSizeSmall, labelText: "Back", backgroundTexture: kButtonActiveTexture)
        let backButtonCoordinateY = verticalButtonSpace * 3 + verticalButtonSpace / CGFloat(2)
        backButton.position = CGPoint(x: 0, y: -backButtonCoordinateY)
        
        addChild(aboutLabel)
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
        
        if backButton.contains(location) {
            backButton.fillTexture = kButtonActiveTexture
            applicationDelegate?.didSelectNode(with: .mainMenu)
            return
        }
        backButton.fillTexture = kButtonActiveTexture
    }
}
