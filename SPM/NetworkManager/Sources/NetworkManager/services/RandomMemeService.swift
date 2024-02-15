import Foundation

class RandomMemeService{
    func fetchMemes(completion: @escaping (Result<[Meme], Error>) -> Void) {
        guard let url = URL(string: APIEndpoint.memes.rawValue) else {
            print("invalidURL")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("noData")
                return
            }
            
            do {
                let memeList = try JSONDecoder().decode(MemeList.self, from: data)
                completion(.success(memeList.memes))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
