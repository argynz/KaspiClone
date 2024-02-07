import Foundation

public struct Product: Codable {
    public let id: Int
    public let title: String
    public let description: String
    public let price: Double
    public let discountPercentage: Double
    public let rating: Double
    public let stock: Int
    public let brand: String
    public let category: String
    public let thumbnail: String
    public let images: [String]
}
