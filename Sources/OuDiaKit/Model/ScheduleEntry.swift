import Foundation

public struct ScheduleEntry: Identifiable, Equatable, Sendable { // インデント数: 5
    public var id: UUID
    public var arrivalStatus: ArrivalStatus
    @Time public var arrival: String?
    @Time public var departure: String?

    public init(
        id: UUID = UUID(),
        arrivalStatus: ArrivalStatus,
        arrival: String? = nil,
        departure: String? = nil
    ) {
        self.id = id
        self.arrivalStatus = arrivalStatus
        self.arrival = arrival
        self.departure = departure
    }
}

extension ScheduleEntry: Codable {
    enum CodingKeys: CodingKey {
        case arrivalStatus
        case arrival
        case departure
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.arrivalStatus = try container.decode(ArrivalStatus.self, forKey: .arrivalStatus)
        self.arrival = try container.decode(String?.self, forKey: .arrival)
        self.departure = try container.decode(String?.self, forKey: .departure)
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
