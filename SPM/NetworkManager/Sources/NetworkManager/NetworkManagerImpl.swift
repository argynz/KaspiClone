import Foundation
import UIKit

public class NetworkManagerImpl {
    private let productsService = ProductsService()
    private let randomMemeService = RandomMemeService()
    private let randomPhotoService = RandomPhotoService()
    
    public init() {}
    
    private func fetchProducts (completion: @escaping (Result<[Product], Error>) -> Void) {
        productsService.fetchProducts(completion: completion)
    }
    
    private func fetchMemes (completion: @escaping (Result<[Meme], Error>) -> Void) {
        randomMemeService.fetchMemes(completion: completion)
    }
    
    public func fetchRandomImage (completion: @escaping (UIImage?, Error?) -> Void) {
        randomPhotoService.fetchRandomImage(completion: completion)
    }
    
    public func fetchMainPageData(completion: @escaping (Result<[Product], Error>, Result<[Meme], Error>) -> Void) {
        let group = DispatchGroup()
        
        var productsResult: Result<[Product], Error>?
        var memesResult: Result<[Meme], Error>?
        
        group.enter()
        fetchProducts { result in
            productsResult = result
            group.leave()
        }
        
        group.enter()
        fetchMemes { result in
            memesResult = result
            group.leave()
        }
        
        group.notify(queue: .main) {
            let finalProductsResult = productsResult ?? .failure(
                NSError(domain: "com.yourapp.network", code: -1, 
                        userInfo: [NSLocalizedDescriptionKey: "Failed to fetch products"]))
            let finalMemesResult = memesResult ?? .failure(
                NSError(domain: "com.yourapp.network", code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "Failed to fetch memes"]))
            
            completion(finalProductsResult, finalMemesResult)
        }
    }
}
