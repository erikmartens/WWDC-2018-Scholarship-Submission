//import Foundation
//
//enum GameMode: Int {
//    case classic
//    case endless
//}
//
//enum SceneType {
//    case mainMenu
//    case selectGameMode
//    case game(GameMode)
//    case highScore
//    case addQuestion
//}
//
//protocol CoordinatorDelegate: class {
//    func sceneDidChange(to sceneType: SceneType)
//}
//
//class Coordinator {
//    
//    static var shared: Coordinator! {
//        if shared == nil {
//            shared = Coordinator()
//        }
//        return shared
//    }
//    
//    
//    // MARK: - Public Properties
//    
//    
//    
//    
//    // MARK: - Private Properties
//    
//    private weak var delegate: CoordinatorDelegate?
//    
//    private var currentSceneType: SceneType
//    
//    
//    // MARK: - Initializer
//    
//    private init() {
//        self.currentSceneType = .mainMenu
//        //self.delegate = Presenter.sharedInstance
//    }
//}
//
