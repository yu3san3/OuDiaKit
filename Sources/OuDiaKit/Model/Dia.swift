import Foundation

public struct Dia: Identifiable, Equatable, Sendable { // インデント数: 2
    public var id: UUID
    public var diaName: String
    public var kudari: Kudari
    public var nobori: Nobori

    public init(
        id: UUID = UUID(),
        diaName: String,
        kudari: Kudari,
        nobori: Nobori
    ) {
        self.id = id
        self.diaName = diaName
        self.kudari = kudari
        self.nobori = nobori
    }
}

extension Dia: Codable {
    enum CodingKeys: CodingKey {
        case diaName,
             kudari,
             nobori
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.diaName = try container.decode(String.self, forKey: .diaName)
        self.kudari = try container.decode(Kudari.self, forKey: .kudari)
        self.nobori = try container.decode(Nobori.self, forKey: .nobori)
    }
}

// MARK: - Kudari

public struct Kudari: Equatable, Sendable { // インデント数: 3
    public var ressya: [Ressya]

    public init(ressya: [Ressya]) {
        self.ressya = ressya
    }
}

extension Kudari: Codable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.ressya = try container.decodeIfPresent([Ressya].self, forKey: .ressya) ?? []
    }
}

// MARK: - Nobori

public struct Nobori: Equatable, Sendable { // インデント数: 3
    public var ressya: [Ressya]

    public init(ressya: [Ressya]) {
        self.ressya = ressya
    }
}

extension Nobori: Codable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.ressya = try container.decodeIfPresent([Ressya].self, forKey: .ressya) ?? []
    }
}
