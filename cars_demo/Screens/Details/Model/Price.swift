import Foundation

struct Price: Codable {
  var usedTmvRetail: Int?
  var usedPrivateParty: Int?
  var usedTradeIn: Int?
  var estimateTmv: Bool?

  enum CodingKeys: String, CodingKey {
    case usedTmvRetail
    case usedPrivateParty
    case usedTradeIn
    case estimateTmv
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    usedTmvRetail    = try values.decodeIfPresent(Int.self, forKey: .usedTmvRetail    )
    usedPrivateParty = try values.decodeIfPresent(Int.self, forKey: .usedPrivateParty )
    usedTradeIn      = try values.decodeIfPresent(Int.self, forKey: .usedTradeIn      )
    estimateTmv      = try values.decodeIfPresent(Bool.self, forKey: .estimateTmv      )
  }

  init() {
  }
}
