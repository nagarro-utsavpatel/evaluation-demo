import Foundation

struct Model: Codable {
  var id: String
  var makeId: Int
  var makeName: String
  var makeNiceName: String
  var makeNiceId: String
  var name: String
  var niceName: String
  var adTargetId: String
  var niceId: String
  var modelLinkCode: String
  var make: Make
  var modelYears: [ModelYears]
  var attributeGroups: AttributeGroups
  var categoryValues: [String]
  var publicationStates: [String]

  enum CodingKeys: String, CodingKey {
    case id
    case makeId
    case makeName
    case makeNiceName
    case makeNiceId
    case name
    case niceName
    case adTargetId
    case niceId
    case modelLinkCode
    case make
    case modelYears
    case attributeGroups
    case categoryValues
    case publicationStates
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id                = try values.decodeIfPresent(String.self, forKey: .id                ) ?? ""
    makeId            = try values.decodeIfPresent(Int.self, forKey: .makeId            ) ?? 0
    makeName          = try values.decodeIfPresent(String.self, forKey: .makeName          ) ?? ""
    makeNiceName      = try values.decodeIfPresent(String.self, forKey: .makeNiceName      ) ?? ""
    makeNiceId        = try values.decodeIfPresent(String.self, forKey: .makeNiceId        ) ?? ""
    name              = try values.decodeIfPresent(String.self, forKey: .name              ) ?? ""
    niceName          = try values.decodeIfPresent(String.self, forKey: .niceName          ) ?? ""
    adTargetId        = try values.decodeIfPresent(String.self, forKey: .adTargetId        ) ?? ""
    niceId            = try values.decodeIfPresent(String.self, forKey: .niceId            ) ?? ""
    modelLinkCode     = try values.decodeIfPresent(String.self, forKey: .modelLinkCode     ) ?? ""
    make              = try values.decodeIfPresent(Make.self, forKey: .make              ) ?? Make()
    modelYears        = try values.decodeIfPresent([ModelYears].self, forKey: .modelYears        ) ?? []
    attributeGroups   = try values.decodeIfPresent(AttributeGroups.self, forKey: .attributeGroups) ?? AttributeGroups()
    categoryValues    = try values.decodeIfPresent([String].self, forKey: .categoryValues    ) ?? []
    publicationStates = try values.decodeIfPresent([String].self, forKey: .publicationStates ) ?? []
  }
}
