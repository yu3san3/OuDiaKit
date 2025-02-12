import Foundation

public struct Timetable: Identifiable, Equatable, Sendable { // インデント数: 2
    public var id: UUID
    /// ダイヤ名 DiaName
    public var title: String
    /// 下り Kudari
    public var down: Down
    /// 上り Nobori
    public var up: Up

    public init(
        id: UUID = UUID(),
        title: String,
        down: Down,
        up: Up
    ) {
        self.id = id
        self.title = title
        self.down = down
        self.up = up
    }
}

extension Timetable: Codable {
    enum CodingKeys: String, CodingKey {
        case title = "DiaName"
        case down = "Kudari"
        case up = "Nobori"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.title = try container.decode(String.self, forKey: .title)
        self.down = try container.decode(Down.self, forKey: .down)
        self.up = try container.decode(Up.self, forKey: .up)
    }
}

// MARK: - Kudari

public struct Down: Equatable, Sendable { // インデント数: 3
    public var trains: [Train]

    public init(trains: [Train]) {
        self.trains = trains
    }
}

extension Down: Codable {
    enum CodingKeys: String, CodingKey {
        case trains = "Ressya"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.trains = try container.decodeIfPresent([Train].self, forKey: .trains) ?? []
    }
}

// MARK: - Nobori

public struct Up: Equatable, Sendable { // インデント数: 3
    public var trains: [Train]

    public init(trains: [Train]) {
        self.trains = trains
    }
}

extension Up: Codable {
    enum CodingKeys: String, CodingKey {
        case trains = "Ressya"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.trains = try container.decodeIfPresent([Train].self, forKey: .trains) ?? []
    }
}
