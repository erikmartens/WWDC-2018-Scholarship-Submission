import Foundation

class HighscoresModel {
    
    // MARK: - Public Properties
    
    var highscores: [HighscoreDTO] {
        return FileStorageService.highscores ?? [HighscoreDTO]()
    }
}
