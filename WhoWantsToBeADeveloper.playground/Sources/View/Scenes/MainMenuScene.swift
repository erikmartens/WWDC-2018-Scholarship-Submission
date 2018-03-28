import SpriteKit

class MainMenuScene: SKScene {
    
    // MARK: - Public Properties
    
    weak var mainMenuControllerDelegate: MainMenuControllerDelegate!
    
    
    // MARK: - Private Properties
    
    private var mainMenuNode: MainMenuNode!
    
    
    // MARK: - Overrides
    
    override func didMove(to view: SKView) {
        size = view.frame.size
        
        if mainMenuNode == nil {
            mainMenuNode = MainMenuNode(frame: view.frame, mainMenuControllerDelegate: mainMenuControllerDelegate)
        }
        addChild(mainMenuNode)
    }
    
    override func willMove(from: SKView) {
        removeAllChildren()
    }
    
    
    // MAKR: - Public Functions
    
    func configureResumeAvailable(_ available: Bool) {
        mainMenuNode.configureResumeAvailable(available)
    }
    
    
    // MARK: - Event Handlers
    
    override func mouseDown(with event: NSEvent) {
        let mousePoint = convertPoint(fromView: CGPoint(x: event.locationInWindow.x, y: event.locationInWindow.y))
        guard let touchedNode = nodes(at: mousePoint).first else {
            return
        }
        if resumeAvailable && touchedNode == mainMenuNode.resumeButton {
            mainMenuNode.resumeButton.fillTexture = kButtonSelectedTexture
        }
        if touchedNode == mainMenuNode.startButton {
            mainMenuNode.startButton.fillTexture = kButtonSelectedTexture
        }
        if touchedNode == mainMenuNode.highscoreButton {
            mainMenuNode.highscoreButton.fillTexture = kButtonSelectedTexture
        }
        if touchedNode == mainMenuNode.aboutButton {
            mainMenuNode.aboutButton.fillTexture = kButtonSelectedTexture
        }
    }
    
    override func mouseUp(with event: NSEvent) {
        let mousePoint = convertPoint(fromView: CGPoint(x: event.locationInWindow.x, y: event.locationInWindow.y))
        guard let touchedNode = nodes(at: mousePoint).first else {
            return
        }
        if resumeAvailable && touchedNode == mainMenuNode.resumeButton {
            mainMenuControllerDelegate.didTapMenuButton(with: .resumeGame)
        }
        if touchedNode == mainMenuNode.startButton {
            mainMenuControllerDelegate.didTapMenuButton(with: .newGame)
        }
        if touchedNode == mainMenuNode.highscoreButton {
            mainMenuControllerDelegate.didTapMenuButton(with: .presentHighscores)
        }
        if touchedNode == mainMenuNode.aboutButton {
            mainMenuControllerDelegate.didTapMenuButton(with: .presentAbout)
        }
        mainMenuNode.resumeButton.fillTexture = resumeAvailable ? kButtonActiveTexture : kButtonInactiveTexture
        mainMenuNode.startButton.fillTexture = kButtonActiveTexture
        mainMenuNode.highscoreButton.fillTexture = kButtonActiveTexture
        mainMenuNode.aboutButton.fillTexture = kButtonActiveTexture
    }
}
