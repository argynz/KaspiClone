import SwiftUI
import NetworkManager

public struct MainPageView: View {
    @ObservedObject public var mainPageViewModel = MainPageViewModel()
    @StateObject private var maximizedImageViewModel = MaximizedImageViewModel()
    
    public init(mainPageViewModel: MainPageViewModel) {
        UIScrollView.appearance().bounces = false
        self.mainPageViewModel = mainPageViewModel
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            searchBarView
            ScrollView {
                VStack(spacing: 10) {
                    advertsView
                    middleView
                    samsungAd
                    productsView
                }
            }
            .background(Colors.backgroundGrayColor)
            .navigationBarHidden(true)
        }
        .overlay {
            ZStack {
                if maximizedImageViewModel.showImageViewer {
                    MaximizedImageView()
                }
            }
        }
        .environmentObject(maximizedImageViewModel)
    }
    
    private var searchBarView: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Colors.mediumGrayColor)
                .padding(.horizontal, 8)
            TextField("Поиск по Kaspi.kz", text: $mainPageViewModel.searchText)
                .foregroundColor(Color(red: 158/255.0, green: 158/255.0, blue: 158/255.0))
                .padding(.vertical, 10)
        }
        .background(Colors.backgroundGrayColor)
        .cornerRadius(10)
        .padding(.vertical, 8)
        .padding(.horizontal, 18)
        .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Colors.lightGrayColor), 
                alignment: .bottom
            )
    }
    
    private var advertsView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(0..<mainPageViewModel.memes.count, id: \.self) { index in
                    VStack {
                        Button(action: {
                            maximizedImageViewModel.showImageViewer.toggle()
                            maximizedImageViewModel.images = mainPageViewModel.memes.map { $0.url }
                            maximizedImageViewModel.selectedTab = index
                        }, label: {
                            Rectangle()
                                .fill(Colors.lightGrayColor)
                                .frame(width: 165, height: 100)
                                .cornerRadius(10)
                                .overlay {
                                    if let url = URL(string: mainPageViewModel.memes[index].url) {
                                        AsyncImage(url: url) { image in
                                            image.resizable()
                                        } placeholder: {
                                            Color.gray.opacity(0.3)
                                        }
                                        .cornerRadius(10)
                                    }
                                }
                        })
                        
                        Text(mainPageViewModel.memes[index].title)
                            .frame(maxWidth: 165, alignment: .leading)
                            .font(.system(size: 12))
                            .padding(.top, 4)
                            .padding(.bottom, 8)
                            .foregroundColor(Color(red: 144.0/255.0, green: 144.0/255.0, blue: 144.0/255.0))
                    }
                }
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 6)
        }
        .frame(height: 144)
        .background(Color.white)
    }
    
    private var middleView: some View {
        VStack(spacing: 1) {
            buttonsView
            magnumView
            creditsView
        }
    }
    
    private var buttonsView: some View {
        VStack {
            LazyVGrid(columns: mainPageViewModel.gridItems, spacing: 20) {
                CustomButtonsView(iconName: "QR", label: "Kaspi QR")
                CustomButtonsView(iconName: "Bank", label: "Мой Банк")
                CustomButtonsView(iconName: "Transactions", label: "Платежи")
                CustomButtonsView(iconName: "Transfers", label: "Переводы")
                CustomButtonsView(iconName: "Shop", label: "Магазин")
                CustomButtonsView(iconName: "Travel", label: "Travel")
                CustomButtonsView(iconName: "City", label: "Госуслуги")
                CustomButtonsView(iconName: "Adverts", label: "Объявления")
            }
            .padding()
        }
        .background(Color.white)
    }
    
    private var magnumView: some View {
        HStack {
            Image("Magnum")
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)
                .padding(.horizontal, 10)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text("Magnum")
                    .font(.system(size: 15))
                Text("Продукты питания с бесплатной доставкой")
                    .font(.system(size: 12))
                    .foregroundColor(Colors.mediumGrayColor)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(Colors.lightGrayColor)
        }
        .frame(height: 64)
        .padding(.leading, 8)
        .padding(.trailing, 12)
        .background(Color.white)
    }
    
    private var creditsView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyVGrid(columns: mainPageViewModel.creditColumns, alignment: .leading) {
                CreditView(iconName: "gold", title: "Kaspi Gold", discription: "Бесплатные переводы")
                CreditView(iconName: "kredit", title: "Кредит на Покупки", discription: "Кредит или рассрочка 0%")
                CreditView(iconName: "KN", title: "Кредит наличными", discription: "До 1 млн ₸ на Kaspi Gold")
                CreditView(iconName: "red", title: "Kaspi RED", discription: "Рассрочка 0%")
                CreditView(iconName: "deposit", title: "Kaspi Депозит", discription: "Эффективная ставка 15%")
                CreditView(iconName: "KN_entrep", title: "Кредит для ИП", discription: "До 2 млн тенге")
            }
        }
        .padding(.vertical, 20)
        .background(Color.white)
    }
    
    private var samsungAd: some View {
        Image("samsungAd")
            .resizable()
            .frame(height: 120)
    }
    
    private var productsView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Вас могут заинтересовать")
                .font(.system(size: 18))
                .bold()
                .padding(.vertical, 18)
                .padding(.leading, 18)
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: mainPageViewModel.productsColumns, spacing: 20) {
                    ForEach(0..<mainPageViewModel.products.count, id: \.self) { index in
                        ProductCardView(product: mainPageViewModel.products[index])
                    }
                }
            }
        }
        .background(Color.white)
    }
}

extension Notification.Name {
    public static let didChangeTabBarVisibility = Notification.Name("didChangeTabBarVisibility")
}
