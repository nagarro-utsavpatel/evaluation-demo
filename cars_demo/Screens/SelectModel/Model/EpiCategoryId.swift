import Foundation

struct EpiCategoryId: Codable {
  var id: Int?
  var name: String?
  var value: String?

  enum CodingKeys: String, CodingKey {
    case id
    case name
    case value
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id    = try values.decodeIfPresent(Int.self, forKey: .id    )
    name  = try values.decodeIfPresent(String.self, forKey: .name  )
    value = try values.decodeIfPresent(String.self, forKey: .value )
  }

  init() {
  }
}
