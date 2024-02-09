import SwiftUI
import NetworkManager

class MainPageViewModel: ObservableObject{
    @Published var memes: [Meme] = []
    @Published var products: [NetworkManager.Product] = []
    
    @State var searchText = ""
    
    let creditColumns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    let productsColumns = [GridItem(.flexible()), GridItem(.flexible())]
    let gridItems = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
    ]
    
    func fetchMemes() {
        RandomMemeService.sharedMeme.fetchMemes { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedMemes):
                    self.memes = fetchedMemes
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func fetchProducts() {
        ProductsService.sharedProduct.fetchProducts { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let products):
                    self.products = products
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
