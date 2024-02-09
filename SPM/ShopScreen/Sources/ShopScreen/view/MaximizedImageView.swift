import SwiftUI

struct MaximizedImageView: View{
    @EnvironmentObject var maximizedImageViewModel: MaximizedImageViewModel
    
    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea()
            
            VStack {
                TabView(selection: $maximizedImageViewModel.selectedTab){
                    ForEach(0..<maximizedImageViewModel.images.count, id: \.self) { index in
                        if let url = URL(string: maximizedImageViewModel.images[index]) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                
                            } placeholder: {
                                Color.white
                            }
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                HStack(spacing: 6) {
                    ForEach(0..<maximizedImageViewModel.images.count, id: \.self) { index in
                        Circle()
                            .fill(index == maximizedImageViewModel.selectedTab ? Color.red : Colors.lightGrayColor)
                            .frame(width: 6, height: 6)
                    }
                }
                .padding(.bottom, 10)
            }
            .overlay(
                Button(action: {
                    maximizedImageViewModel.showImageViewer.toggle()
                }, label: {
                    Image(systemName: "xmark")
                        .foregroundColor(Color.red)
                        .frame(width: 30,height: 30)
                })
                .padding(10)
                ,alignment: .topTrailing
            )
        }
    }
}
