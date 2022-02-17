import Foundation

struct Attributes: Codable {
  var useInNew: UseInNew?      = UseInNew()
  var epiCategoryId: EpiCategoryId? = EpiCategoryId()

  enum CodingKeys: String, CodingKey {
    case useInNew      = "USE_IN_NEW"
    case epiCategoryId = "EPI_CATEGORY_ID"
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

      useInNew      = try values.decodeIfPresent(UseInNew.self, forKey: .useInNew      )
      epiCategoryId = try values.decodeIfPresent(EpiCategoryId.self, forKey: .epiCategoryId )
  }

  init() {
  }
}
