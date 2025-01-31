struct OudDataJSON: Equatable, Codable {
    var fileType: String
    var rosen: RosenJSON
    var dispProp: DispPropJSON
    var fileTypeAppComment: String
}

struct RosenJSON: Equatable, Codable { //インデント数: 1
    var rosenmei: String
    var eki: [EkiJSON]
    var ressyasyubetsu: [RessyasyubetsuJSON]
    var dia: [DiaJSON]
    var kitenJikoku: String
    var diagramDgrYZahyouKyoriDefault: String
    var comment: String
}

struct DispPropJSON: Equatable, Codable { //インデント数: 1
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
}

struct EkiJSON: Equatable, Codable { //インデント数: 2
    var ekimei: String
    var ekijikokukeisiki: String
    var ekikibo: String
    var kyoukaisen: String?
    var diagramRessyajouhouHyoujiKudari: String?
    var diagramRessyajouhouHyoujiNobori: String?
}

struct RessyasyubetsuJSON: Equatable, Codable { //インデント数: 2
    var syubetsumei: String
    var ryakusyou: String
    var jikokuhyouMojiColor: String
    var jikokuhyouFontIndex: String
    var diagramSenColor: String
    var diagramSenStyle: String
    var diagramSenIsBold: String?
    var stopMarkDrawType: String?
}

struct DiaJSON: Equatable, Codable { //インデント数: 2
    var diaName: String
    var kudari: KudariJSON
    var nobori: NoboriJSON
}

struct KudariJSON: Equatable, Codable { //インデント数: 3
    var ressya: [RessyaJSON]
}

struct NoboriJSON: Equatable, Codable { //インデント数: 3
    var ressya: [RessyaJSON]
}

struct RessyaJSON: Equatable, Codable { //インデント数: 4
    var houkou: String
    var syubetsu: String
    var ressyabangou: String?
    var ressyamei: String?
    var gousuu: String?
    var ekiJikoku: String
    var bikou: String?
}
