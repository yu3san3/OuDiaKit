import Foundation

public struct Ressya: Identifiable, Equatable, Sendable { // インデント数: 4
    public var id: UUID
    public var houkou: Houkou
    public var syubetsu: Int
    public var ressyabangou: String?
    public var ressyamei: String?
    public var gousuu: String?
    public var ekiJikoku: [Jikoku]
    public var bikou: String?

    public init(
        id: UUID = UUID(),
        houkou: Houkou,
        syubetsu: Int,
        ressyabangou: String? = nil,
        ressyamei: String? = nil,
        gousuu: String? = nil,
        ekiJikoku: [Jikoku],
        bikou: String? = nil
    ) {
        self.id = id
        self.houkou = houkou
        self.syubetsu = syubetsu
        self.ressyabangou = ressyabangou
        self.ressyamei = ressyamei
        self.gousuu = gousuu
        self.ekiJikoku = ekiJikoku
        self.bikou = bikou
    }
}

extension Ressya: Codable {
    enum CodingKeys: CodingKey {
        case houkou,
             syubetsu,
             ressyabangou,
             ressyamei,
             gousuu,
             ekiJikoku,
             bikou
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.houkou = try container.decode(Houkou.self, forKey: .houkou)
        self.syubetsu = try container.decodeIntFromString(forKey: .syubetsu)
        self.ressyabangou = try container.decodeIfPresent(String.self, forKey: .ressyabangou)
        self.ressyamei = try container.decodeIfPresent(String.self, forKey: .ressyamei)
        self.gousuu = try container.decodeIfPresent(String.self, forKey: .gousuu)
        self.ekiJikoku = try container.decodeJikokuFromString(forKey: .ekiJikoku)
        self.bikou = try container.decodeIfPresent(String.self, forKey: .bikou)
    }
}

// MARK: - Enum

public enum Houkou: String, Codable, Sendable {
    case kudari = "Kudari"
    case nobori = "Nobori"
}
