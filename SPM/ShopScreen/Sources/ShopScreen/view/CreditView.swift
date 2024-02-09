import SwiftUI

struct CreditView: View {
    var iconName: String
    var title: String
    var discription: String
    
    var body: some View {
        HStack {
            Image(iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 61, height: 43)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 16))
                Text(discription)
                    .font(.system(size: 12))
                    .foregroundColor(Colors.mediumGrayColor)
            }
        }
        .padding(.horizontal, 18)
    
    }
}
