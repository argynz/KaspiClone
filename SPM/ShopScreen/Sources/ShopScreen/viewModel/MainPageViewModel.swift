import SwiftUI
import NetworkManager

public class MainPageViewModel: ObservableObject {
    @Published public var memes: [Meme] = Array(repeating: Meme.sample[0], count: 4)
    @Published public var products: [Product] = Array(repeating: Product.sample[0], count: 2)
    @Published public var isMemeLoading: Bool = true
    @Published public var isProductLoading: Bool = true
    
    @State var searchText = ""
    
    let networkManager = NetworkManagerImpl()
    
    public init() {}
    
    let creditColumns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    let productsColumns = [GridItem(.flexible()), GridItem(.flexible())]
    let gridItems = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    func fetchMemes() {
            networkManager.fetchMemes { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let fetchedMemes):
                        self.memes = fetchedMemes
                        self.isMemeLoading.toggle()
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }

        func fetchProducts() {
            networkManager.fetchProducts { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let products):
                        self.products = products
                        self.isProductLoading.toggle()
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
}
