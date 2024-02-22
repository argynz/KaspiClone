import SwiftUI
class MaximizedImageViewModel: ObservableObject {
    @Published var selectedTab: Int = 0
    @Published var images: [String] = []
    @Published var showImageViewer = false {
        didSet {
            NotificationCenter.default.post(name: .didChangeTabBarVisibility, object: showImageViewer)
        }
    }
}
