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
    
    
    // MARK: - Input Event Handlers
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        
        if mainMenuControllerDelegate.resumeAvailable
            && mainMenuNode.resumeButton.contains(location) {
            mainMenuNode.resumeButton.fillTexture = kButtonSelectedTexture
        }
        if mainMenuNode.startButton.contains(location) {
            mainMenuNode.startButton.fillTexture = kButtonSelectedTexture
        }
        if mainMenuNode.highscoreButton.contains(location) {
            mainMenuNode.highscoreButton.fillTexture = kButtonSelectedTexture
        }
        if mainMenuNode.aboutButton.contains(location) {
            mainMenuNode.aboutButton.fillTexture = kButtonSelectedTexture
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        
        if mainMenuControllerDelegate.resumeAvailable
            && mainMenuNode.resumeButton.contains(location) {
            mainMenuControllerDelegate.didTapMenuButton(with: .resumeGame)
        }
        if mainMenuNode.startButton.contains(location) {
            mainMenuControllerDelegate.didTapMenuButton(with: .newGame)
        }
        if mainMenuNode.highscoreButton.contains(location) {
            mainMenuControllerDelegate.didTapMenuButton(with: .presentHighscores)
        }
        if mainMenuNode.aboutButton.contains(location) {
            mainMenuControllerDelegate.didTapMenuButton(with: .presentAbout)
        }
        mainMenuNode.resumeButton.fillTexture = mainMenuControllerDelegate.resumeAvailable ? kButtonActiveTexture : kButtonInactiveTexture
        mainMenuNode.startButton.fillTexture = kButtonActiveTexture
        mainMenuNode.highscoreButton.fillTexture = kButtonActiveTexture
        mainMenuNode.aboutButton.fillTexture = kButtonActiveTexture
    }
}
