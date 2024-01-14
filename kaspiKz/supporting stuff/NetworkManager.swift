import Foundation
import UIKit

struct PhotoLink: Decodable {
    let urls: Urls
    struct Urls: Decodable {
        let thumb: String
    }
}

class NetworkManager {
    static let shared = NetworkManager() // Singleton instance

    private let baseURL = "https://api.unsplash.com/photos/random"
    private let accessKey = "OKZnWHhzHPBYwvpYXa2CZmhYePGgufl_4QgiDOb3Obo"
    
    func fetchRandomImage(completion: @escaping (UIImage?, Error?) -> Void) {
        guard let url = URL(string: "\(baseURL)?client_id=\(accessKey)&orientation=squarish") else {
            completion(nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "", code: -2, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let photoLink = try decoder.decode(PhotoLink.self, from: data)
                
                if let thumbURL = URL(string: photoLink.urls.thumb), let imageData = try? Data(contentsOf: thumbURL) {
                    let image = UIImage(data: imageData)
                    completion(image, nil)
                } else {
                    completion(nil, NSError(domain: "", code: -3, userInfo: [NSLocalizedDescriptionKey: "Unable to form image"]))
                }
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
}
