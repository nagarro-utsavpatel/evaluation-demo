import Foundation

struct Trim: Codable {
  var name: String?
  var niceName: String?
  var slug: String?

  enum CodingKeys: String, CodingKey {
    case name
    case niceName
    case slug
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    name     = try values.decodeIfPresent(String.self, forKey: .name     )
    niceName = try values.decodeIfPresent(String.self, forKey: .niceName )
    slug     = try values.decodeIfPresent(String.self, forKey: .slug     )
  }

  init() {
  }
}
