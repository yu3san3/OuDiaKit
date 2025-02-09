import SwiftUICore

public struct OuDiaDiagram: Equatable, Codable, Sendable {
    public var fileType: String
    public var rosen: Rosen
    public var dispProp: DispProp
    public var fileTypeAppComment: String

    public init(
        fileType: String,
        rosen: Rosen,
        dispProp: DispProp,
        fileTypeAppComment: String
    ) {
        self.fileType = fileType
        self.rosen = rosen
        self.dispProp = dispProp
        self.fileTypeAppComment = fileTypeAppComment
    }
}

public struct Rosen: Equatable, Codable, Sendable { // インデント数: 1
    public var rosenmei: String
    public var eki: [Eki]
    public var ressyasyubetsu: [Ressyasyubetsu]
    public var dia: [Dia]
    public var kitenJikoku: String
    public var diagramDgrYZahyouKyoriDefault: Int
    public var comment: String

    public init(
        rosenmei: String,
        eki: [Eki],
        ressyasyubetsu: [Ressyasyubetsu],
        dia: [Dia],
        kitenJikoku: String,
        diagramDgrYZahyouKyoriDefault: Int,
        comment: String
    ) {
        self.rosenmei = rosenmei
        self.eki = eki
        self.ressyasyubetsu = ressyasyubetsu
        self.dia = dia
        self.kitenJikoku = kitenJikoku
        self.diagramDgrYZahyouKyoriDefault = diagramDgrYZahyouKyoriDefault
        self.comment = comment
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.rosenmei = try container.decode(String.self, forKey: .rosenmei)
        self.eki = try container.decodeIfPresent([Eki].self, forKey: .eki) ?? []
        self.ressyasyubetsu = try container.decode([Ressyasyubetsu].self, forKey: .ressyasyubetsu)
        self.dia = try container.decodeIfPresent([Dia].self, forKey: .dia) ?? []
        self.kitenJikoku = try container.decode(String.self, forKey: .kitenJikoku)
        self.diagramDgrYZahyouKyoriDefault = try container
            .decodeIntFromString(forKey: .diagramDgrYZahyouKyoriDefault)
        self.comment = try container.decode(String.self, forKey: .comment)
    }
}

public struct DispProp: Equatable, Codable, Sendable { // インデント数: 1
    public var jikokuhyouFont: [String]
    public var jikokuhyouVFont: String
    public var diaEkimeiFont: String
    public var diaJikokuFont: String
    public var diaRessyaFont: String
    public var commentFont: String
    public var diaMojiColor: Color
    public var diaHaikeiColor: Color
    public var diaRessyaColor: Color
    public var diaJikuColor: Color
    public var ekimeiLength: String
    public var jikokuhyouRessyaWidth: String

    public init(
        jikokuhyouFont: [String],
        jikokuhyouVFont: String,
        diaEkimeiFont: String,
        diaJikokuFont: String,
        diaRessyaFont: String,
        commentFont: String,
        diaMojiColor: Color,
        diaHaikeiColor: Color,
        diaRessyaColor: Color,
        diaJikuColor: Color,
        ekimeiLength: String,
        jikokuhyouRessyaWidth: String
    ) {
        self.jikokuhyouFont = jikokuhyouFont
        self.jikokuhyouVFont = jikokuhyouVFont
        self.diaEkimeiFont = diaEkimeiFont
        self.diaJikokuFont = diaJikokuFont
        self.diaRessyaFont = diaRessyaFont
        self.commentFont = commentFont
        self.diaMojiColor = diaMojiColor
        self.diaHaikeiColor = diaHaikeiColor
        self.diaRessyaColor = diaRessyaColor
        self.diaJikuColor = diaJikuColor
        self.ekimeiLength = ekimeiLength
        self.jikokuhyouRessyaWidth = jikokuhyouRessyaWidth
    }
}

public struct Eki: Identifiable, Equatable, Codable, Sendable { // インデント数: 2
    enum CodingKeys: CodingKey {
        case ekimei,
             ekijikokukeisiki,
             ekikibo,
             kyoukaisen,
             diagramRessyajouhouHyoujiKudari,
             diagramRessyajouhouHyoujiNobori
    }

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

public struct Ressyasyubetsu: Equatable, Codable, Sendable { // インデント数: 2
    public var syubetsumei: String
    public var ryakusyou: String?
    public var jikokuhyouMojiColor: Color
    public var jikokuhyouFontIndex: Int
    public var diagramSenColor: Color
    public var diagramSenStyle: DiagramSenStyle
    public var diagramSenIsBold: String?
    public var stopMarkDrawType: String?

    public init(
        syubetsumei: String,
        ryakusyou: String? = nil,
        jikokuhyouMojiColor: Color,
        jikokuhyouFontIndex: Int,
        diagramSenColor: Color,
        diagramSenStyle: DiagramSenStyle,
        diagramSenIsBold: String? = nil,
        stopMarkDrawType: String? = nil
    ) {
        self.syubetsumei = syubetsumei
        self.ryakusyou = ryakusyou
        self.jikokuhyouMojiColor = jikokuhyouMojiColor
        self.jikokuhyouFontIndex = jikokuhyouFontIndex
        self.diagramSenColor = diagramSenColor
        self.diagramSenStyle = diagramSenStyle
        self.diagramSenIsBold = diagramSenIsBold
        self.stopMarkDrawType = stopMarkDrawType
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.syubetsumei = try container.decode(String.self, forKey: .syubetsumei)
        self.ryakusyou = try container.decodeIfPresent(String.self, forKey: .ryakusyou)
        self.jikokuhyouMojiColor = try container.decode(Color.self, forKey: .jikokuhyouMojiColor)
        self.jikokuhyouFontIndex = try container.decodeIntFromString(forKey: .jikokuhyouFontIndex)
        self.diagramSenColor = try container.decode(Color.self, forKey: .diagramSenColor)
        self.diagramSenStyle = try container.decode(DiagramSenStyle.self, forKey: .diagramSenStyle)
        self.diagramSenIsBold = try container
            .decodeIfPresent(String.self, forKey: .diagramSenIsBold)
        self.stopMarkDrawType = try container
            .decodeIfPresent(String.self, forKey: .stopMarkDrawType)
    }
}

public struct Dia: Identifiable, Equatable, Codable, Sendable { // インデント数: 2
    enum CodingKeys: CodingKey {
        case diaName,
             kudari,
             nobori
    }

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

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.diaName = try container.decode(String.self, forKey: .diaName)
        self.kudari = try container.decode(Kudari.self, forKey: .kudari)
        self.nobori = try container.decode(Nobori.self, forKey: .nobori)
    }
}

public struct Kudari: Equatable, Codable, Sendable { // インデント数: 3
    public var ressya: [Ressya]

    public init(ressya: [Ressya]) {
        self.ressya = ressya
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.ressya = try container.decodeIfPresent([Ressya].self, forKey: .ressya) ?? []
    }
}

public struct Nobori: Equatable, Codable, Sendable { // インデント数: 3
    public var ressya: [Ressya]

    public init(ressya: [Ressya]) {
        self.ressya = ressya
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.ressya = try container.decodeIfPresent([Ressya].self, forKey: .ressya) ?? []
    }
}

public struct Ressya: Identifiable, Equatable, Codable, Sendable { // インデント数: 4
    enum CodingKeys: CodingKey {
        case houkou,
             syubetsu,
             ressyabangou,
             ressyamei,
             gousuu,
             ekiJikoku,
             bikou
    }

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

public struct Jikoku: Identifiable, Equatable, Codable, Sendable { // インデント数: 5
    enum CodingKeys: CodingKey {
        case arrivalStatus,
             chaku,
             hatsu
    }

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

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.arrivalStatus = try container.decode(ArrivalStatus.self, forKey: .arrivalStatus)
        self.chaku = try container.decode(String?.self, forKey: .chaku)
        self.hatsu = try container.decode(String?.self, forKey: .hatsu)
    }
}

@propertyWrapper
public struct Time: Sendable {
    public typealias TimeComponent = (hour: Int, minute: Int)

    private var splitTime: TimeComponent?
    private var rawTime: String?

    public var wrappedValue: String? {
        get { rawTime }
        set { setTime(newValue) }
    }

    public var projectedValue: TimeComponent? { splitTime }

    public init(wrappedValue time: String?) {
        setTime(time)
    }

    func splitToTimeComponent(_ time: String) -> TimeComponent? {
        guard time.count == 3 || time.count == 4 else { return nil }

        let hourPart = String(time.prefix(time.count - 2))
        let minutePart = String(time.suffix(2))

        guard
            let hour = Int(hourPart),
            let minute = Int(minutePart),
            hour < 24, minute < 60
        else { return nil }

        return (hour, minute)
    }

    private mutating func setTime(_ newTime: String?) {
        splitTime = newTime.flatMap { splitToTimeComponent($0) }
        rawTime = splitTime != nil ? newTime : nil
    }
}

extension Time: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let decodedRawTime = try container.decode(String?.self)
        setTime(decodedRawTime)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

extension Time: Equatable {
    public static func == (lhs: Time, rhs: Time) -> Bool {
        lhs.wrappedValue == rhs.wrappedValue
    }
}

// MARK: - enum

public enum Houkou: String, Codable, Sendable {
    case kudari = "Kudari"
    case nobori = "Nobori"
}

public enum Ekijikokukeisiki: String, Codable, Sendable{
    case hatsu = "Jikokukeisiki_Hatsu"
    case hatsuchaku = "Jikokukeisiki_Hatsuchaku"
    case kudariChaku = "Jikokukeisiki_KudariChaku"
    case noboriChaku = "Jikokukeisiki_NoboriChaku"
}

public enum ArrivalStatus: String, Codable, Sendable {
    case notOperate = ""
    case stop = "1"
    case pass = "2"
    case notGoThrough = "3"

    public init(rawValueOrNotOperate rawValue: String) {
        self = .init(rawValue: rawValue) ?? .notOperate
    }
}

public enum Ekikibo: String, Codable, Sendable {
    case ippan = "Ekikibo_Ippan"
    case syuyou = "Ekikibo_Syuyou"
}

public enum DiagramSenStyle: String, Codable, Sendable {
    case jissen = "SenStyle_Jissen"
    case hasen = "SenStyle_Hasen"
    case tensen = "SenStyle_Tensen"
    case ittensasen = "SenStyle_Ittensasen"
}
