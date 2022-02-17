import Foundation

struct AttributeGroups: Codable {
  var main: Main? = Main()

  enum CodingKeys: String, CodingKey {
    case main = "MAIN"
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    main = try values.decodeIfPresent(Main.self, forKey: .main )
  }

  init() {
  }
}
