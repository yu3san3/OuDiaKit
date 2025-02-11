import Foundation

public struct Jikoku: Identifiable, Equatable, Sendable { // インデント数: 5
    public var id: UUID
    public var arrivalStatus: ArrivalStatus
    @Time public var chaku: String?
    @Time public var hatsu: String?

    public init(
        id: UUID = UUID(),
        arrivalStatus: ArrivalStatus,
        chaku: String? = nil,
        hatsu: String? = nil
    ) {
        self.id = id
        self.arrivalStatus = arrivalStatus
        self.chaku = chaku
        self.hatsu = hatsu
    }
}

extension Jikoku: Codable {
    enum CodingKeys: CodingKey {
        case arrivalStatus,
             chaku,
             hatsu
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.arrivalStatus = try container.decode(ArrivalStatus.self, forKey: .arrivalStatus)
        self.chaku = try container.decode(String?.self, forKey: .chaku)
        self.hatsu = try container.decode(String?.self, forKey: .hatsu)
    }
}

// MARK: - Enum

public enum ArrivalStatus: String, Codable, Sendable {
    case notOperate = ""
    case stop = "1"
    case pass = "2"
    case notGoThrough = "3"

    public init(rawValueOrNotOperate rawValue: String) {
        self = .init(rawValue: rawValue) ?? .notOperate
    }
}
