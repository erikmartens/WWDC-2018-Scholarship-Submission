import Foundation

protocol AboutControllerDelegate: class {
    func didTapBackButton()
}

class AboutController {
    // MARK: - Private Properties
    
    private weak var applicationDelegate: ApplicationDelegate!
    
    private var aboutScene: AboutScene
    private var aboutModel: AboutModel
    
    
    // MARK: - Initialization
    
    init(applicationDelegate: ApplicationDelegate) {
        self.applicationDelegate = applicationDelegate
        
        aboutScene = AboutScene()
        aboutModel = AboutModel()
    }
    
    
    // MARK: - Public Functions
    
    func startAbout() {
        aboutScene.aboutControllerDelegate = self
        applicationDelegate.presentScene(aboutScene)
        aboutScene.configure(with: aboutModel.aboutText)
    }
}

extension AboutController: AboutControllerDelegate {
    
    func didTapBackButton() {
        applicationDelegate.moveToScene(with: .mainMenu)
    }
}
