import Foundation

struct PhotoLink: Decodable {
    let urls: Urls
    struct Urls: Decodable {
        let thumb: String
    }
}
