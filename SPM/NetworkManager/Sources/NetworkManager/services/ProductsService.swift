import Foundation

public class ProductsService{
    public static let sharedProduct = ProductsService()
    
    public func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        guard let url = URL(string: APIEndpoint.products.rawValue) else {
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
                let productList = try JSONDecoder().decode(ProductList.self, from: data)
                completion(.success(productList.products))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
