import SwiftUI
import NetworkManager

public class MainPageViewModel: ObservableObject {
    @Published public var memes: [Meme] = []
    @Published public var products: [Product] = []
    
    @State var searchText = ""
    
    public init() {}
    
    let creditColumns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    let productsColumns = [GridItem(.flexible()), GridItem(.flexible())]
    let gridItems = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
}
