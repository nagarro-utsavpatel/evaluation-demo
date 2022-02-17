import Foundation

struct Properties: Codable {
  var USEINNEW: String?
  var EPICATEGORYID: String?

  enum CodingKeys: String, CodingKey {
    case USEINNEW      = "USE_IN_NEW"
    case EPICATEGORYID = "EPI_CATEGORY_ID"
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    USEINNEW      = try values.decodeIfPresent(String.self, forKey: .USEINNEW      )
    EPICATEGORYID = try values.decodeIfPresent(String.self, forKey: .EPICATEGORYID )
  }

  init() {
  }
}
