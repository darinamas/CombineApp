import Foundation

struct WPPost: Codable {
    let id: Int
    let date: String
    let dateGmt: String
    var title: Content
    var content: Content
    let categories: [Int]

    enum CodingKeys: String, CodingKey {
        case id, date
        case dateGmt = "date_gmt"
        case title, content
        case categories
    }
}


// MARK: - Content
struct Content: Codable {
    var rendered: String
}
