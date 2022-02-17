import Foundation

struct SubModels: Codable {
  var id: Int
  var name: String
  var niceId: String
  var identifier: String
  var ruleType: String

  enum CodingKeys: String, CodingKey {
    case id
    case name
    case niceId
    case identifier
    case ruleType
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id         = try values.decodeIfPresent(Int.self, forKey: .id         ) ?? 0
    name       = try values.decodeIfPresent(String.self, forKey: .name       ) ?? ""
    niceId     = try values.decodeIfPresent(String.self, forKey: .niceId     ) ?? ""
    identifier = try values.decodeIfPresent(String.self, forKey: .identifier ) ?? ""
    ruleType   = try values.decodeIfPresent(String.self, forKey: .ruleType   ) ?? ""
  }
}
