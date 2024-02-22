import SwiftUI
import NetworkManager
import Const

struct ProductCardView: View {
    var product: Product
    
    var body: some View {
        NavigationLink(destination: ProductPageView(product: product)) {
            VStack(alignment: .leading, spacing: 6) {
                ZStack(alignment: .topLeading) {
                    if let url = URL(string: product.thumbnail) {
                        AsyncImage(url: url) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray.opacity(0.3)
                        }
                        .frame(width: 164, height: 163)
                    } else {
                        Color.gray.opacity(0.3)
                            .frame(width: 164, height: 163)
                    }
                    VStack(spacing: 6) {
                        Image("0012")
                            .resizable()
                            .frame(width: 43, height: 23)
                        Image("5bonus")
                            .resizable()
                            .frame(width: 43, height: 23)
                    }
                }
                Text(product.title)
                    .font(.system(size: 16))
                    .foregroundColor(Color.black)
                Text(product.category)
                    .font(.system(size: 12))
                    .foregroundColor(Color.mediumGrayColor)
                HStack {
                    Text(String(Int(product.price*((100-product.discountPercentage)/100)))+" $")
                        .font(.system(size: 16))
                        .foregroundColor(Color.black)
                        .bold()
                    Spacer()
                    Text(String(Int(product.price))+" $")
                        .font(.system(size: 13))
                        .foregroundColor(Color.black)
                        .bold()
                        .strikethrough()
                }
                .frame(width: 164)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
