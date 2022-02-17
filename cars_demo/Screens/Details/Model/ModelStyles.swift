import Foundation

struct ModelStyles: Codable {
    var id: Int?
    var makeId: Int?
    var year: Int?
    var makeName: String?
    var makeNiceName: String?
    var makeNiceId: String?
    var modelId: String?
    var modelName: String?
    var modelNiceName: String?
    var modelNiceId: String?
    var modelYearId: Int?
    var modelLinkCode: String?
    var transmissionType: String?
    var engineType: String?
    var engineCompressorType: String?
    var engineFuelType: String?
    var engineCylinder: Int?
    var engineSize: Double?
    var numberOfSeats: Int?
    var withBluetooth: Bool?
    var withNavigationSystem: Bool?
    var withHeatedSeats: Bool?
    var price: Price? = Price()
    var trim: Trim? = Trim()
    var categoryValues: [String]? = []
    var niceCategoryValues: [String]? = []
    var modelYear: ModelYear? = ModelYear()
    var attributeGroups: AttributeGroups? = AttributeGroups()
    var subModels: [SubModels]? = []
    var name: String?
    var niceName: String?
    var niceId: String?
    var publicationState: String?
    var standardEquipment: [StandardEquipment]? = []
    var optionalEquipment: [String]? = []
    var usedEquipment: [UsedEquipment]? = []
    var options: [Options]? = []
    var configurableEquipment: [String]? = []

    enum CodingKeys: String, CodingKey {
        case id
        case makeId
        case year
        case makeName
        case makeNiceName
        case makeNiceId
        case modelId
        case modelName
        case modelNiceName
        case modelNiceId
        case modelYearId
        case modelLinkCode
        case transmissionType
        case engineType
        case engineCompressorType
        case engineFuelType
        case engineCylinder
        case engineSize
        case numberOfSeats
        case withBluetooth
        case withNavigationSystem
        case withHeatedSeats
        case price
        case trim
        case categoryValues
        case niceCategoryValues
        case modelYear
        case attributeGroups
        case subModels
        case name
        case niceName
        case niceId
        case publicationState
        case standardEquipment
        case optionalEquipment
        case usedEquipment
        case options
        case configurableEquipment
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        makeId = try values.decodeIfPresent(Int.self, forKey: .makeId)
        year = try values.decodeIfPresent(Int.self, forKey: .year)
        makeName = try values.decodeIfPresent(String.self, forKey: .makeName)
        makeNiceName = try values.decodeIfPresent(String.self, forKey: .makeNiceName)
        makeNiceId = try values.decodeIfPresent(String.self, forKey: .makeNiceId)
        modelId = try values.decodeIfPresent(String.self, forKey: .modelId)
        modelName = try values.decodeIfPresent(String.self, forKey: .modelName)
        modelNiceName = try values.decodeIfPresent(String.self, forKey: .modelNiceName)
        modelNiceId = try values.decodeIfPresent(String.self, forKey: .modelNiceId)
        modelYearId = try values.decodeIfPresent(Int.self, forKey: .modelYearId)
        modelLinkCode = try values.decodeIfPresent(String.self, forKey: .modelLinkCode)
        transmissionType = try values.decodeIfPresent(String.self, forKey: .transmissionType)
        engineType = try values.decodeIfPresent(String.self, forKey: .engineType)
        engineCompressorType = try values.decodeIfPresent(String.self, forKey: .engineCompressorType)
        engineFuelType = try values.decodeIfPresent(String.self, forKey: .engineFuelType)
        engineCylinder = try values.decodeIfPresent(Int.self, forKey: .engineCylinder)
        engineSize = try values.decodeIfPresent(Double.self, forKey: .engineSize)
        numberOfSeats = try values.decodeIfPresent(Int.self, forKey: .numberOfSeats)
        withBluetooth = try values.decodeIfPresent(Bool.self, forKey: .withBluetooth)
        withNavigationSystem = try values.decodeIfPresent(Bool.self, forKey: .withNavigationSystem)
        withHeatedSeats = try values.decodeIfPresent(Bool.self, forKey: .withHeatedSeats)
        price = try values.decodeIfPresent(Price.self, forKey: .price)
        trim = try values.decodeIfPresent(Trim.self, forKey: .trim)
        categoryValues = try values.decodeIfPresent([String].self, forKey: .categoryValues)
        niceCategoryValues = try values.decodeIfPresent([String].self, forKey: .niceCategoryValues)
        modelYear = try values.decodeIfPresent(ModelYear.self, forKey: .modelYear)
        attributeGroups = try values.decodeIfPresent(AttributeGroups.self, forKey: .attributeGroups)
        subModels = try values.decodeIfPresent([SubModels].self, forKey: .subModels)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        niceName = try values.decodeIfPresent(String.self, forKey: .niceName)
        niceId = try values.decodeIfPresent(String.self, forKey: .niceId)
        publicationState = try values.decodeIfPresent(String.self, forKey: .publicationState)
        standardEquipment = try values.decodeIfPresent([StandardEquipment].self, forKey: .standardEquipment)
        optionalEquipment = try values.decodeIfPresent([String].self, forKey: .optionalEquipment)
        usedEquipment = try values.decodeIfPresent([UsedEquipment].self, forKey: .usedEquipment)
        options = try values.decodeIfPresent([Options].self, forKey: .options)
        configurableEquipment = try values.decodeIfPresent([String].self, forKey: .configurableEquipment)
    }

    init() {
    }
}
