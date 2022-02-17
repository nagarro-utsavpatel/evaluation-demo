import Foundation

struct ModelYears: Codable {
  var id: Int?
  var name: String?
  var year: Int?
  var publicationStates: [String]? = []
  var href: String?

  enum CodingKeys: String, CodingKey {
    case id
    case name
    case year
    case publicationStates
    case href
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id                = try values.decodeIfPresent(Int.self, forKey: .id                )
    name              = try values.decodeIfPresent(String.self, forKey: .name              )
    year              = try values.decodeIfPresent(Int.self, forKey: .year              )
    publicationStates = try values.decodeIfPresent([String].self, forKey: .publicationStates )
    href              = try values.decodeIfPresent(String.self, forKey: .href              )
  }

  init() {
  }
}
