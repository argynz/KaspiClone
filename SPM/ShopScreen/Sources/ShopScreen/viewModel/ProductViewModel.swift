import SwiftUI
import NetworkManager

class ProductViewModel: ObservableObject{
    @Published var searchText = ""
    @Published var selectedMonthIndex = 1
    @Published var selectedTab = 0
    @Published var installmentPrice = 0
    @Published var installmentPeriod = 6
    
    var price: String
    var actualPrice: Int
    let segments = ["3 Мес", "6 Мес", "12 Мес", "24 Мес"]
    let product: NetworkManager.Product
    
    init(product: NetworkManager.Product) {
        self.product = product
        self.price = String(Int(product.price))
        self.actualPrice = Int(product.price * ((100 - product.discountPercentage) / 100))
        
        updateInstallmentPrice()
    }
    
    func updateInstallmentPrice() {
        installmentPeriod = 3 * Int(pow(2, Double(selectedMonthIndex)))
        installmentPrice = actualPrice / installmentPeriod
    }
}
