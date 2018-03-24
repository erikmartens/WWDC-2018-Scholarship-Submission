import Foundation
import PlaygroundSupport

enum FileType {
    case questions
    case highscores
    case savegame
}

class FileStorageService {
    
    static func storeJson<T: Encodable>(for codable: T, inFileWithType fileType: FileType) {
        
        guard let filePathURL = directoryURLForFile(with: fileType) else {
            print("💥 FileStorageService: Could not construct file path URL.")
            return
        }
    
        do {
            let data = try JSONEncoder().encode(codable)
            try data.write(to: filePathURL)
        } catch let error {
            print("💥 FileStorageService: Error while writing data to \(filePathURL.path). Error-Description: \(error.localizedDescription)")
        }
    }
    
    static func retrieveJson<T: Decodable>(fromFileWithType fileType: FileType, andDecodeAsType type: T.Type) -> T? {
        guard let filePathURL = directoryURLForFile(with: fileType) else {
            print("💥 FileStorageService: Could not construct file path URL.")
            return nil
        }
    
        if !FileManager.default.fileExists(atPath: filePathURL.path) {
            print("💥 FileStorageService: File at path \(filePathURL.path) does not exist!")
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
    
    
    // MARK: - Private Functions
    
    static private func directoryURLForFile(with fileType: FileType) -> URL? {
        let fileExtension = "json"
        
        var filePathUrl: URL?
        switch fileType {
        case .questions:
            filePathUrl = Bundle.main.url(forResource: "Question", withExtension: fileExtension)
        case .highscores:
            filePathUrl =  playgroundSharedDataDirectory.appendingPathComponent("Highscores").appendingPathExtension(fileExtension)
        case .savegame:
            filePathUrl =  playgroundSharedDataDirectory.appendingPathComponent("Savegame").appendingPathExtension(fileExtension)
        }
        return filePathUrl
    }
}
