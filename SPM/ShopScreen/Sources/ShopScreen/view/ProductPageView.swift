import SwiftUI
import NetworkManager
import Const

struct ProductPageView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var productViewModel: ProductViewModel
    @StateObject private var maximizedImageViewModel = MaximizedImageViewModel()
    
    init(product: Product) {
        _productViewModel = StateObject(wrappedValue: ProductViewModel(product: product))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            searchBarView
            ScrollView {
                VStack(spacing: 10) {
                    topView
                    bonusLabelView
                    installmentView
                    shopsView
                }
            }
            .background(Color.backgroundGrayColor)
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
        HStack(spacing: 0) {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image("backArrow")
                    .frame(width: 28, height: 28)
            }
            .padding(.trailing, 6)
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color.mediumGrayColor)
                    .padding(.horizontal, 8)
                TextField("Поиск по Kaspi.kz", text: $productViewModel.searchText)
                    .foregroundColor(Color(red: 158/255.0, green: 158/255.0, blue: 158/255.0))
                    .padding(.vertical, 10)
            }
            .background(Color.backgroundGrayColor)
            .cornerRadius(10)
            .padding(.vertical, 8)
            .padding(.horizontal, 8)
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image("closeBtn")
                    .frame(width: 32, height: 32)
            }
        }
        .padding(.horizontal, 8)
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.lightGrayColor),
            alignment: .bottom
        )
    }
    
    private var topView: some View {
        VStack(spacing: 1) {
            picView
            titleView
            priceView
        }
    }
    
    private var picView: some View {
        ZStack(alignment: .leading) {
            VStack {
                TabView(selection: $productViewModel.selectedTab) {
                    ForEach(0..<productViewModel.product.images.count, id: \.self) { index in
                        Button(action: {
                            maximizedImageViewModel.showImageViewer.toggle()
                            maximizedImageViewModel.images = productViewModel.product.images
                            maximizedImageViewModel.selectedTab = index
                        }, label: {
                            Rectangle()
                                .fill(Color.white)
                                .overlay {
                                    if let url = URL(string: productViewModel.product.images[index]) {
                                        AsyncImage(url: url) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(maxWidth: .infinity)
                                        } placeholder: {
                                            Color.gray.opacity(0.3)
                                        }
                                    }
                                }
                                .tag(index)
                                .padding(.horizontal, 18)
                        })
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                HStack(spacing: 6) {
                    ForEach(0..<productViewModel.product.images.count, id: \.self) { index in
                        Circle()
                            .fill(index == productViewModel.selectedTab ? Color.red : Color.lightGrayColor)
                            .frame(width: 6, height: 6)
                    }
                }
                .padding(.bottom, 10)
                
            }
            .frame(height: 375)
            .background(Color.white)
            .padding(.top, 8)
            VStack(spacing: 6) {
                Image("0012")
                    .resizable()
                    .frame(width: 60, height: 32)
                Image("5bonus")
                    .resizable()
                    .frame(width: 60, height: 32)
            }.padding(.leading, 12)
        }
        
    }
    
    private var titleView: some View {
        VStack {
            HStack {
                Text(productViewModel.product.title)
                    .font(.system(size: 18))
                    .padding(.leading, 18)
                Spacer()
                Image("heart")
                    .frame(width: 32, height: 32)
                    .padding(.top, 10)
                    .padding(.trailing, 10)
                Image("share")
                    .frame(width: 26, height: 26)
                    .padding(.top, 10)
                    .padding(.trailing, 18)
            }
            HStack {
                HStack(spacing: 2) {
                    Image("star")
                        .frame(width: 13, height: 13)
                    Image("star")
                        .frame(width: 13, height: 13)
                    Image("star")
                        .frame(width: 13, height: 13)
                    Image("star")
                        .frame(width: 13, height: 13)
                    Image("star")
                        .frame(width: 13, height: 13)
                }
                .padding(.bottom, 14)
                .padding(.leading, 18)
                Spacer()
                Text("Код товара: 106112563")
                    .font(.system(size: 12))
                    .padding(.bottom, 14)
                    .foregroundColor(Color.mediumGrayColor)
                    .padding(.trailing, 18)
            }
        }
        .background(Color.white)
    }
    
    private var priceView: some View {
        HStack(spacing: 3) {
            Text(String(productViewModel.actualPrice)+" $")
                .font(.system(size: 18))
                .bold()
                .padding(.leading, 18)
            Text(productViewModel.price+" $")
                .font(.system(size: 12))
                .strikethrough()
                .padding(.top, 6)
            
            Spacer()
            
            Text("В рассрочку")
                .font(.system(size: 12))
                .foregroundColor(Color.mediumGrayColor)
            Rectangle()
                .fill(Color.customYellowColor)
                .frame(width: 44, height: 18)
                .overlay(
                    Text(String(productViewModel.installmentPrice)+" $")
                        .font(.system(size: 12))
                        .bold()
                )
            Text("x " + String(productViewModel.installmentPeriod) + " мес")
                .font(.system(size: 12))
                .foregroundColor(Color.mediumGrayColor)
                .padding(.trailing, 18)
        }
        .frame(height: 64)
        .background(Color.white)
    }
    
    private var bonusLabelView: some View {
        VStack {
            Rectangle()
                .fill(Color.customDarkGreenColor)
                .frame(height: 54)
                .overlay(
                    HStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 30, height: 30)
                            .overlay(
                                Text("5%")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color.customDarkGreenColor)
                            )
                        VStack(alignment: .leading) {
                            Text("5% Бонусов при оплате Kaspi Gold!")
                                .font(.system(size: 12))
                                .foregroundColor(Color.white)
                            Text("Бонусы будут начислены после получения товара.")
                                .font(.system(size: 12))
                                .foregroundColor(Color.white)
                        }
                        .padding(.leading, 14)
                    }
                )
            Rectangle()
                .fill(Color.clear)
                .frame(height: 40)
                .overlay(
                    Text("ПРОДАВЦЫ")
                        .font(.system(size: 12))
                        .foregroundColor(Color.mediumGrayColor)
                        .padding(.leading, 18),
                    alignment: .bottomLeading
                )
        }
    }
    
    private var installmentView: some View {
        HStack {
            Text("В рассрочку")
                .font(.system(size: 12))
                .padding(.leading, 18)
            Spacer()
            HStack(spacing: 0) {
                ForEach(0..<productViewModel.segments.count, id: \.self) { index in
                    Text(productViewModel.segments[index])
                        .font(.system(size: 12))
                        .foregroundColor(productViewModel.selectedMonthIndex == index ? .white : .red)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 30)
                        .border(Color.red, width: 1)
                        .background(productViewModel.selectedMonthIndex == index ? Color.red : Color.clear)
                        .onTapGesture {
                            withAnimation {
                                productViewModel.selectedMonthIndex = index
                                productViewModel.updateInstallmentPrice()
                            }
                        }
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.red, lineWidth: 1)
            )
            .padding(.horizontal, 18)
        }
        .frame(height: 54)
        .background(Color.white)
    }
    
    private var shopsView: some View {
        VStack(spacing: 1) {
            deliveryView
            SellerCardView()
            SellerCardView()
            SellerCardView()
            bottomView
        }
        .environmentObject(productViewModel)
    }
    
    private var deliveryView: some View {
        HStack(spacing: 14) {
            Text("Доставка")
                .font(.system(size: 14))
                .padding(.leading, 18)
            
            ZStack {
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: 86, height: 26)
                    .cornerRadius(14)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.lightGrayColor, lineWidth: 1)
                    )
                
                Text("До 5 дней")
                    .font(.system(size: 14))
            }
            
            ZStack {
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: 86, height: 26)
                    .cornerRadius(14)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.lightGrayColor, lineWidth: 1)
                    )
                
                Text("До 7 дней")
                    .font(.system(size: 14))
            }
            
            Spacer()
        }
        .frame(height: 54)
        .background(Color.white)
    }
    
    private var bottomView: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Еще 5 продавца")
                    .font(.system(size: 15))
                    .bold()
                    .foregroundColor(Color(red: 50/255, green: 155/255, blue: 229/255))
                Spacer()
                Image("blueArrow")
            }
            .padding(18)
            
            HStack(spacing: 8) {
                Button(action: {
                }) {
                    Text("Оформить сейчас")
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                        .frame(height: 52)
                        .frame(maxWidth: .infinity)
                        .background(Color.buttonGreenColor)
                        .cornerRadius(4)
                }
                
                Button(action: {
                }) {
                    Text("Добавить в корзину")
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                        .frame(height: 52)
                        .frame(maxWidth: .infinity)
                        .background(Color.buttonBlueColor)
                        .cornerRadius(4)
                }
            }
            .padding(6)
        }
        .background(Color.white)
    }
}
