import Foundation

struct Make: Codable {
  var id: Int?
  var href: String?

  enum CodingKeys: String, CodingKey {
    case id
    case href
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id   = try values.decodeIfPresent(Int.self, forKey: .id   )
    href = try values.decodeIfPresent(String.self, forKey: .href )
  }

  init() {
  }
}
