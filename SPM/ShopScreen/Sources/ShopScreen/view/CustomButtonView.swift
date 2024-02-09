import SwiftUI

struct CustomButtonsView: View {
    var iconName: String
    var label: String
    
    var body: some View {
        VStack {
            Image(iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
                .foregroundColor(.red)
            Text(label)
                .font(.system(size: 13))
                .foregroundColor(.black)
        }
    }
}
