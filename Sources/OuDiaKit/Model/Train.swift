import Foundation

public struct Train: Identifiable, Equatable, Sendable { // インデント数: 4
    public var id: UUID
    /// 方向 Houkou
    public var direction: TrainDirection
    /// 種別 Syubetsu
    public var typeIndex: Int
    /// 列車番号 Ressyabangou
    public var number: String?
    /// 列車名 Ressyamei
    public var name: String?
    /// 号数 Gousuu
    public var suffixNumber: String?
    /// 駅時刻 EkiJikoku
    public var schedule: Schedule
    /// 備考 Bikou
    public var remark: String?

    public init(
        id: UUID = UUID(),
        direction: TrainDirection,
        typeIndex: Int,
        number: String? = nil,
        name: String? = nil,
        suffixNumber: String? = nil,
        schedule: Schedule,
        remark: String? = nil
    ) {
        self.id = id
        self.direction = direction
        self.typeIndex = typeIndex
        self.number = number
        self.name = name
        self.suffixNumber = suffixNumber
        self.schedule = schedule
        self.remark = remark
    }
}

extension Train: Codable {
    enum CodingKeys: String, CodingKey {
        case direction = "Houkou"
        case typeIndex = "Syubetsu"
        case number = "Ressyabangou"
        case name = "Ressyamei"
        case suffixNumber = "Gousuu"
        case schedule = "EkiJikoku"
        case remark = "Bikou"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.direction = try container.decode(TrainDirection.self, forKey: .direction)
        self.typeIndex = try container.decodeIntFromString(forKey: .typeIndex)
        self.number = try container.decodeIfPresent(String.self, forKey: .number)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.suffixNumber = try container.decodeIfPresent(String.self, forKey: .suffixNumber)
        self.schedule = try container.decodeScheduleFromString(forKey: .schedule)
        self.remark = try container.decodeIfPresent(String.self, forKey: .remark)
    }
}

// MARK: - Enum

public enum TrainDirection: String, Codable, Sendable {
    case down = "Kudari"
    case up = "Nobori"
}
