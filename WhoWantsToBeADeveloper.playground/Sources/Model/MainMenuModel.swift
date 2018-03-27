import Foundation

class MainMenuModel {
    
    // MARK: - Public Properties
    
    var savegame: SavegameDTO? {
        return FileStorageService.savegame
    }
    
    
    // MARK: - Initialization
    
    init() {}
}
