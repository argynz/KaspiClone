import SwiftUI
import Const

struct SellerCardView: View {
    @EnvironmentObject private var productViewModel: ProductViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("KORKEM KZ")
                        .font(.system(size: 18))
                    
                    HStack(spacing: 4) {
                        ForEach(0..<5) {_ in
                            Image("starGreen")
                        }
                        
                        Text("(1 отзыв)")
                            .font(.system(size: 12))
                    }
                }
                
                Spacer()
                
                Button(action: {
                }) {
                    Text("Выбрать")
                        .foregroundColor(.white)
                        .font(.system(size: 14))
                        .frame(width: 108, height: 31)
                        .background(Color.buttonBlueColor)
                        .cornerRadius(4)
                }
            }
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(productViewModel.price + " $")
                        .font(.system(size: 13))
                        .bold()
                    HStack {
                        Rectangle()
                            .fill(Color.customYellowColor)
                            .frame(width: 44, height: 20)
                            .overlay(
                                Text(String(productViewModel.installmentPrice)+" $")
                                    .font(.system(size: 12))
                                    .bold()
                            )
                        Text("x " + String(productViewModel.installmentPeriod) + " мес")
                            .font(.system(size: 12))
                            .foregroundColor(Color.mediumGrayColor)
                    }
                }
                
                Spacer()
                
                VStack {
                    HStack {
                        Image("box")
                        Text("Postomat, ").font(.system(size: 12)) +
                        Text("1 декабря").bold() .font(.system(size: 12)) +
                        Text(", бесплатно").font(.system(size: 12))
                    }
                    
                    HStack {
                        Image("van")
                        Text("Доставка, ").font(.system(size: 12)) +
                        Text("1 декабря").bold() .font(.system(size: 12)) +
                        Text(", бесплатно").font(.system(size: 12))
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
    }
}
