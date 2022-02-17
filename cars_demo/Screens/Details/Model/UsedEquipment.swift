import Foundation

struct UsedEquipment: Codable {
  var id: String
  var href: String

  enum CodingKeys: String, CodingKey {
    case id
    case href
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id   = try values.decodeIfPresent(String.self, forKey: .id   ) ?? ""
    href = try values.decodeIfPresent(String.self, forKey: .href ) ?? ""
  }
}
