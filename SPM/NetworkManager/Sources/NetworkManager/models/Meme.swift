import Foundation

public struct Meme: Codable {
    public let title: String
    public let url: String
    
    public static let sample = [
        Meme(title: "title", url: "url"),
        Meme(title: "title", url: "url"),
        Meme(title: "title", url: "url"),
        Meme(title: "title", url: "url")
    ]
}
