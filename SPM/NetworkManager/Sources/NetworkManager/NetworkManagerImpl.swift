import Foundation
import UIKit

public class NetworkManagerImpl {
    private let productsService = ProductsService()
    private let randomMemeService = RandomMemeService()
    private let randomPhotoService = RandomPhotoService()
    
    public init() {
        
    }
    
    public func fetchProducts (completion: @escaping (Result<[Product], Error>) -> Void) {
        productsService.fetchProducts(completion: completion)
    }
    
    public func fetchMemes (completion: @escaping (Result<[Meme], Error>) -> Void) {
        randomMemeService.fetchMemes(completion: completion)
    }
    
    public func fetchRandomImage (completion: @escaping (UIImage?, Error?) -> Void) {
        randomPhotoService.fetchRandomImage(completion: completion)
    }
    
}
