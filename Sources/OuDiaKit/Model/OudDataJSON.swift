struct OudDataJSON: Equatable, Codable {
    var fileType: String
    var rosen: RosenJSON
    var dispProp: DispPropJSON
    var fileTypeAppComment: String

    enum CodingKeys: String, CodingKey {
        case fileType = "FileType"
        case rosen = "Rosen"
        case dispProp = "DispProp"
        case fileTypeAppComment = "FileTypeAppComment"
    }
}

struct RosenJSON: Equatable, Codable {
    var rosenmei: String
    var eki: [EkiJSON]
    var ressyasyubetsu: [RessyasyubetsuJSON]
    var dia: [DiaJSON]
    var kitenJikoku: String
    var diagramDgrYZahyouKyoriDefault: String
    var comment: String

    enum CodingKeys: String, CodingKey {
        case rosenmei = "Rosenmei"
        case eki = "Eki"
        case ressyasyubetsu = "Ressyasyubetsu"
        case dia = "Dia"
        case kitenJikoku = "KitenJikoku"
        case diagramDgrYZahyouKyoriDefault = "DiagramDgrYZahyouKyoriDefault"
        case comment = "Comment"
    }
}

struct DispPropJSON: Equatable, Codable {
    var jikokuhyouFont: [String]
    var jikokuhyouVFont: String
    var diaEkimeiFont: String
    var diaJikokuFont: String
    var diaRessyaFont: String
    var commentFont: String
    var diaMojiColor: String
    var diaHaikeiColor: String
    var diaRessyaColor: String
    var diaJikuColor: String
    var ekimeiLength: String
    var jikokuhyouRessyaWidth: String

    enum CodingKeys: String, CodingKey {
        case jikokuhyouFont = "JikokuhyouFont"
        case jikokuhyouVFont = "JikokuhyouVFont"
        case diaEkimeiFont = "DiaEkimeiFont"
        case diaJikokuFont = "DiaJikokuFont"
        case diaRessyaFont = "DiaRessyaFont"
        case commentFont = "CommentFont"
        case diaMojiColor = "DiaMojiColor"
        case diaHaikeiColor = "DiaHaikeiColor"
        case diaRessyaColor = "DiaRessyaColor"
        case diaJikuColor = "DiaJikuColor"
        case ekimeiLength = "EkimeiLength"
        case jikokuhyouRessyaWidth = "JikokuhyouRessyaWidth"
    }
}

struct EkiJSON: Equatable, Codable {
    var ekimei: String
    var ekijikokukeisiki: String
    var ekikibo: String
    var kyoukaisen: String?
    var diagramRessyajouhouHyoujiKudari: String?
    var diagramRessyajouhouHyoujiNobori: String?

    enum CodingKeys: String, CodingKey {
        case ekimei = "Ekimei"
        case ekijikokukeisiki = "Ekijikokukeisiki"
        case ekikibo = "Ekikibo"
        case kyoukaisen = "Kyoukaisen"
        case diagramRessyajouhouHyoujiKudari = "DiagramRessyajouhouHyoujiKudari"
        case diagramRessyajouhouHyoujiNobori = "DiagramRessyajouhouHyoujiNobori"
    }
}

struct RessyasyubetsuJSON: Equatable, Codable {
    var syubetsumei: String
    var ryakusyou: String
    var jikokuhyouMojiColor: String
    var jikokuhyouFontIndex: String
    var diagramSenColor: String
    var diagramSenStyle: String
    var diagramSenIsBold: String?
    var stopMarkDrawType: String?

    enum CodingKeys: String, CodingKey {
        case syubetsumei = "Syubetsumei"
        case ryakusyou = "Ryakusyou"
        case jikokuhyouMojiColor = "JikokuhyouMojiColor"
        case jikokuhyouFontIndex = "JikokuhyouFontIndex"
        case diagramSenColor = "DiagramSenColor"
        case diagramSenStyle = "DiagramSenStyle"
        case diagramSenIsBold = "DiagramSenIsBold"
        case stopMarkDrawType = "StopMarkDrawType"
    }
}

struct DiaJSON: Equatable, Codable {
    var diaName: String
    var kudari: KudariJSON
    var nobori: NoboriJSON

    enum CodingKeys: String, CodingKey {
        case diaName = "DiaName"
        case kudari = "Kudari"
        case nobori = "Nobori"
    }
}

struct KudariJSON: Equatable, Codable {
    var ressya: [RessyaJSON]

    enum CodingKeys: String, CodingKey {
        case ressya = "Ressya"
    }
}

struct NoboriJSON: Equatable, Codable {
    var ressya: [RessyaJSON]

    enum CodingKeys: String, CodingKey {
        case ressya = "Ressya"
    }
}

struct RessyaJSON: Equatable, Codable {
    var houkou: String
    var syubetsu: String
    var ressyabangou: String?
    var ressyamei: String?
    var gousuu: String?
    var ekiJikoku: String
    var bikou: String?

    enum CodingKeys: String, CodingKey {
        case houkou = "Houkou"
        case syubetsu = "Syubetsu"
        case ressyabangou = "Ressyabangou"
        case ressyamei = "Ressyamei"
        case gousuu = "Gousuu"
        case ekiJikoku = "EkiJikoku"
        case bikou = "Bikou"
    }
}
