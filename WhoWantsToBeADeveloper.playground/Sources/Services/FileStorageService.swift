import Foundation
import PlaygroundSupport

fileprivate enum FileType {
    case questions
    case highscores
    case savegame
}

class FileStorageService {
    
    // MARK: - Public Properties
    
    static var questions: [QuestionDTO]? {
        get {
            let questionWrapper = FileStorageService.retrieveJson(fromFileWithType: .questions, andDecodeAsType: QuestionArrayWrapper.self)
            return questionWrapper?.questions
        }
    }
    
    static var highscores: [HighscoreDTO]? {
        get {
            let highscoreWrapper = FileStorageService.retrieveJson(fromFileWithType: .highscores, andDecodeAsType: HighscoreArrayWrapper.self)
            return highscoreWrapper?.highscores
        }
    }
    
    static func appendHighscore(_ highscore: HighscoreDTO) {
        var highscores = [HighscoreDTO]()
        if let previousHighscores = FileStorageService.retrieveJson(fromFileWithType: .highscores, andDecodeAsType: HighscoreArrayWrapper.self)?.highscores {
            highscores = previousHighscores
            highscores.append(highscore)
            highscores.sort { return $0.score >= $1.score }
        } else {
            highscores.append(highscore)
        }
        let highscoresWrapper = HighscoreArrayWrapper(highscores: highscores)
        FileStorageService.storeJson(for: highscoresWrapper, inFileWithType: .highscores)
    }
    
    static var savegame: SavegameDTO? {
        get {
            return FileStorageService.retrieveJson(fromFileWithType: .savegame, andDecodeAsType: SavegameDTO.self)
        }
        set {
            FileStorageService.storeJson(for: newValue, inFileWithType: .savegame)
        }
    }
    
    static func invalidateSavegame() {
        deleteFile(with: .savegame)
    }
    
    
    // MARK: - Private Functions
    
    private static func storeJson<T: Encodable>(for codable: T, inFileWithType fileType: FileType) {
        guard fileType != .questions else {
            // this filetype cannot be written to, as it is located inside the main bundle
            return
        }
        
        guard let filePathURL = directoryURLForFile(with: fileType) else {
            print("💥 FileStorageService: Could not construct file path URL.")
            return
        }
        
        do {
            let data = try JSONEncoder().encode(codable)
            try data.write(to: filePathURL, options: [])
        } catch let error {
            print("💥 FileStorageService: Error while writing data to \(filePathURL.path). Error-Description: \(error.localizedDescription)")
        }
    }
    
    private static func retrieveJson<T: Decodable>(fromFileWithType fileType: FileType, andDecodeAsType type: T.Type) -> T? {
        guard let filePathURL = directoryURLForFile(with: fileType) else {
            print("💥 FileStorageService: Could not construct file path URL.")
            return nil
        }
    
        if !FileManager.default.fileExists(atPath: filePathURL.path) {
            return nil
        }
        do {
            let data = try Data(contentsOf: filePathURL)
            let model = try JSONDecoder().decode(type, from: data)
            return model
        } catch let error {
            print("💥 FileStorageService: Error while retrieving data from \(filePathURL.path). Error-Description: \(error.localizedDescription)")
            return nil
        }
    }
    
    
    @discardableResult private static func deleteFile(with fileType: FileType) -> Bool {
        guard let filePathURL = directoryURLForFile(with: fileType) else {
            print("💥 FileStorageService: Could not construct file path URL.")
            return false
        }
        if !FileManager.default.fileExists(atPath: filePathURL.path) {
            return true
        }
        do {
            try FileManager.default.removeItem(atPath: filePathURL.path)
            return true
        } catch {
             print("💥 FileStorageService: Error while deleting file at \(filePathURL.path). Error-Description: \(error.localizedDescription)")
            return false
        }
    }
    
    private static func directoryURLForFile(with fileType: FileType) -> URL? {
        let fileExtension = "json"
        
        var filePathUrl: URL?
        switch fileType {
        case .questions:
            filePathUrl = Bundle.main.url(forResource: "Data/Questions", withExtension: fileExtension)
        case .highscores:
            filePathUrl = playgroundSharedDataDirectory.appendingPathComponent("Highscores").appendingPathExtension(fileExtension)
        case .savegame:
            filePathUrl = playgroundSharedDataDirectory.appendingPathComponent("Savegame").appendingPathExtension(fileExtension)
        }
        return filePathUrl
    }
}
