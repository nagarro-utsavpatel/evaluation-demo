import Foundation

struct Main: Codable {
  var id: Int?
  var name: String?
  var properties: Properties? = Properties()
  var attributes: Attributes? = Attributes()

  enum CodingKeys: String, CodingKey {
    case id
    case name
    case properties
    case attributes
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id         = try values.decodeIfPresent(Int.self, forKey: .id         )
    name       = try values.decodeIfPresent(String.self, forKey: .name       )
    properties = try values.decodeIfPresent(Properties.self, forKey: .properties )
    attributes = try values.decodeIfPresent(Attributes.self, forKey: .attributes )
  }

  init() {
  }
}
