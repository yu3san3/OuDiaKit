import Foundation

public struct Eki: Identifiable, Equatable, Sendable { // インデント数: 2
    public var id: UUID
    public var ekimei: String
    public var ekijikokukeisiki: Ekijikokukeisiki
    public var ekikibo: Ekikibo
    public var kyoukaisen: String?
    public var diagramRessyajouhouHyoujiKudari: String?
    public var diagramRessyajouhouHyoujiNobori: String?

    public init(
        id: UUID = UUID(),
        ekimei: String,
        ekijikokukeisiki: Ekijikokukeisiki,
        ekikibo: Ekikibo,
        kyoukaisen: String? = nil,
        diagramRessyajouhouHyoujiKudari: String? = nil,
        diagramRessyajouhouHyoujiNobori: String? = nil
    ) {
        self.id = id
        self.ekimei = ekimei
        self.ekijikokukeisiki = ekijikokukeisiki
        self.ekikibo = ekikibo
        self.kyoukaisen = kyoukaisen
        self.diagramRessyajouhouHyoujiKudari = diagramRessyajouhouHyoujiKudari
        self.diagramRessyajouhouHyoujiNobori = diagramRessyajouhouHyoujiNobori
    }
}

extension Eki: Codable {
    enum CodingKeys: CodingKey {
        case ekimei,
             ekijikokukeisiki,
             ekikibo,
             kyoukaisen,
             diagramRessyajouhouHyoujiKudari,
             diagramRessyajouhouHyoujiNobori
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.ekimei = try container.decode(String.self, forKey: .ekimei)
        self.ekijikokukeisiki = try container.decode(Ekijikokukeisiki.self, forKey: .ekijikokukeisiki)
        self.ekikibo = try container.decode(Ekikibo.self, forKey: .ekikibo)
        self.kyoukaisen = try container.decodeIfPresent(String.self, forKey: .kyoukaisen)
        self.diagramRessyajouhouHyoujiKudari = try container
            .decodeIfPresent(String.self, forKey: .diagramRessyajouhouHyoujiKudari)
        self.diagramRessyajouhouHyoujiNobori = try container
            .decodeIfPresent(String.self, forKey: .diagramRessyajouhouHyoujiNobori)
    }
}

// MARK: - Enum

public enum Ekijikokukeisiki: String, Codable, Sendable{
    case hatsu = "Jikokukeisiki_Hatsu"
    case hatsuchaku = "Jikokukeisiki_Hatsuchaku"
    case kudariChaku = "Jikokukeisiki_KudariChaku"
    case noboriChaku = "Jikokukeisiki_NoboriChaku"
}

public enum Ekikibo: String, Codable, Sendable {
    case ippan = "Ekikibo_Ippan"
    case syuyou = "Ekikibo_Syuyou"
}
