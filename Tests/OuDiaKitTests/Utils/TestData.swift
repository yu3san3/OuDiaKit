import SwiftUICore
@testable import OuDiaKit

enum TestData {
    typealias EkiJikokuPair = (string: String, object: [Jikoku])
    typealias EkiJikokuRecordPair = (string: String, object: Jikoku)

    static let mockOuDiaText = """
    FileType=OuDia.1.02
    Rosen.
    Rosenmei=名鉄名古屋本線
    Eki.
    Ekimei=金山
    Ekijikokukeisiki=Jikokukeisiki_NoboriChaku
    Ekikibo=Ekikibo_Syuyou
    .
    Eki.
    Ekimei=山王
    Ekijikokukeisiki=Jikokukeisiki_Hatsuchaku
    Ekikibo=Ekikibo_Ippan
    .
    Eki.
    Ekimei=名鉄名古屋
    Ekijikokukeisiki=Jikokukeisiki_KudariChaku
    Ekikibo=Ekikibo_Syuyou
    .
    Ressyasyubetsu.
    Syubetsumei=普通
    JikokuhyouMojiColor=00000000
    JikokuhyouFontIndex=0
    DiagramSenColor=00000000
    DiagramSenStyle=SenStyle_Jissen
    StopMarkDrawType=EStopMarkDrawType_DrawOnStop
    .
    Ressyasyubetsu.
    Syubetsumei=特別急行
    Ryakusyou=特急
    JikokuhyouMojiColor=000000FF
    JikokuhyouFontIndex=0
    DiagramSenColor=000000FF
    DiagramSenStyle=SenStyle_Jissen
    StopMarkDrawType=EStopMarkDrawType_DrawOnStop
    .
    Dia.
    DiaName=平日
    Kudari.
    Ressya.
    Houkou=Kudari
    Syubetsu=1
    Ressyabangou=307
    EkiJikoku=1;1009,2,1;1014/
    .
    Ressya.
    Houkou=Kudari
    Syubetsu=0
    Ressyabangou=1093
    EkiJikoku=1;1011,1;1013/1013,1;1016/
    .
    .
    Nobori.
    .
    .
    Dia.
    DiaName=休日
    Kudari.
    Ressya.
    Houkou=Kudari
    Syubetsu=1
    Ressyabangou=101
    EkiJikoku=1;1004,2,1;1008/
    .
    .
    Nobori.
    Ressya.
    Houkou=Nobori
    Syubetsu=0
    Ressyabangou=100
    EkiJikoku=1;1003,2,1;1006/
    .
    .
    .
    KitenJikoku=400
    DiagramDgrYZahyouKyoriDefault=60
    Comment=
    .
    DispProp.
    JikokuhyouFont=PointTextHeight=9;Facename=ＭＳ ゴシック
    JikokuhyouFont=PointTextHeight=9;Facename=ＭＳ ゴシック;Bold=1
    JikokuhyouFont=PointTextHeight=9;Facename=ＭＳ ゴシック;Itaric=1
    JikokuhyouFont=PointTextHeight=9;Facename=ＭＳ ゴシック;Bold=1;Itaric=1
    JikokuhyouFont=PointTextHeight=9;Facename=ＭＳ ゴシック
    JikokuhyouFont=PointTextHeight=9;Facename=ＭＳ ゴシック
    JikokuhyouFont=PointTextHeight=9;Facename=ＭＳ ゴシック
    JikokuhyouFont=PointTextHeight=9;Facename=ＭＳ ゴシック
    JikokuhyouVFont=PointTextHeight=9;Facename=@ＭＳ ゴシック
    DiaEkimeiFont=PointTextHeight=9;Facename=ＭＳ ゴシック
    DiaJikokuFont=PointTextHeight=9;Facename=ＭＳ ゴシック
    DiaRessyaFont=PointTextHeight=9;Facename=ＭＳ ゴシック
    CommentFont=PointTextHeight=9;Facename=ＭＳ ゴシック
    DiaMojiColor=00000000
    DiaHaikeiColor=00FFFFFF
    DiaRessyaColor=00000000
    DiaJikuColor=00C0C0C0
    EkimeiLength=6
    JikokuhyouRessyaWidth=5
    .
    FileTypeAppComment=OuDia Ver. 1.02.05
    """

    static let mockOuDiaDiagram = OuDiaDiagram(
        fileType: "OuDia.1.02",
        rosen: .init(
            rosenmei: "名鉄名古屋本線",
            eki: [
                .init(
                    ekimei: "金山",
                    ekijikokukeisiki: .noboriChaku,
                    ekikibo: .syuyou
                ),
                .init(
                    ekimei: "山王",
                    ekijikokukeisiki: .hatsuchaku,
                    ekikibo: .ippan
                ),
                .init(
                    ekimei: "名鉄名古屋",
                    ekijikokukeisiki: .kudariChaku,
                    ekikibo: .syuyou
                )
            ],
            ressyasyubetsu: [
                .init(
                    syubetsumei: "普通",
                    jikokuhyouMojiColor: Color(oudColorCode: "00000000"),
                    jikokuhyouFontIndex: 0,
                    diagramSenColor: Color(oudColorCode: "00000000"),
                    diagramSenStyle: .jissen,
                    stopMarkDrawType: "EStopMarkDrawType_DrawOnStop"
                ),
                .init(
                    syubetsumei: "特別急行",
                    ryakusyou: "特急",
                    jikokuhyouMojiColor: Color(oudColorCode: "000000FF"),
                    jikokuhyouFontIndex: 0,
                    diagramSenColor: Color(oudColorCode: "000000FF"),
                    diagramSenStyle: .jissen,
                    stopMarkDrawType: "EStopMarkDrawType_DrawOnStop"
                )
            ],
            dia: [
                .init(
                    diaName: "平日",
                    kudari: .init(
                        ressya: [
                            .init(
                                houkou: .kudari,
                                syubetsu: 1,
                                ressyabangou: "307",
                                ekiJikoku: [
                                    .init(arrivalStatus: .stop, chaku: "", hatsu: "1009"),
                                    .init(arrivalStatus: .pass),
                                    .init(arrivalStatus: .stop, chaku: "1014", hatsu: "")
                                ]
                            ),
                            .init(
                                houkou: .kudari,
                                syubetsu: 0,
                                ressyabangou: "1093",
                                ekiJikoku: [
                                    .init(arrivalStatus: .stop, chaku: "", hatsu: "1011"),
                                    .init(arrivalStatus: .stop, chaku: "1013", hatsu: "1013"),
                                    .init(arrivalStatus: .stop, chaku: "1016", hatsu: "")
                                ]
                            )
                        ]
                    ),
                    nobori: .init(ressya: [])
                ),
                .init(
                    diaName: "休日",
                    kudari: .init(
                        ressya: [
                            .init(
                                houkou: .kudari,
                                syubetsu: 1,
                                ressyabangou: "101",
                                ekiJikoku: [
                                    .init(arrivalStatus: .stop, chaku: "", hatsu: "1004"),
                                    .init(arrivalStatus: .pass),
                                    .init(arrivalStatus: .stop, chaku: "1008", hatsu: "")
                                ]
                            )
                        ]
                    ),
                    nobori: .init(
                        ressya: [
                            .init(
                                houkou: .nobori,
                                syubetsu: 0,
                                ressyabangou: "100",
                                ekiJikoku: [
                                    .init(arrivalStatus: .stop, chaku: "", hatsu: "1003"),
                                    .init(arrivalStatus: .pass),
                                    .init(arrivalStatus: .stop, chaku: "1006", hatsu: "")
                                ]
                            )
                        ]
                    )
                )
            ],
            kitenJikoku: "400",
            diagramDgrYZahyouKyoriDefault: 60,
            comment: ""
        ),
        dispProp: .init(
            jikokuhyouFont: [
                "PointTextHeight=9;Facename=ＭＳ ゴシック",
                "PointTextHeight=9;Facename=ＭＳ ゴシック;Bold=1",
                "PointTextHeight=9;Facename=ＭＳ ゴシック;Itaric=1",
                "PointTextHeight=9;Facename=ＭＳ ゴシック;Bold=1;Itaric=1",
                "PointTextHeight=9;Facename=ＭＳ ゴシック",
                "PointTextHeight=9;Facename=ＭＳ ゴシック",
                "PointTextHeight=9;Facename=ＭＳ ゴシック",
                "PointTextHeight=9;Facename=ＭＳ ゴシック",
            ],
            jikokuhyouVFont: "PointTextHeight=9;Facename=@ＭＳ ゴシック",
            diaEkimeiFont: "PointTextHeight=9;Facename=ＭＳ ゴシック",
            diaJikokuFont: "PointTextHeight=9;Facename=ＭＳ ゴシック",
            diaRessyaFont: "PointTextHeight=9;Facename=ＭＳ ゴシック",
            commentFont: "PointTextHeight=9;Facename=ＭＳ ゴシック",
            diaMojiColor: Color(oudColorCode: "00000000"),
            diaHaikeiColor: Color(oudColorCode: "00FFFFFF"),
            diaRessyaColor: Color(oudColorCode: "00000000"),
            diaJikuColor: Color(oudColorCode: "00C0C0C0"),
            ekimeiLength: "6",
            jikokuhyouRessyaWidth: "5"
        ),
        fileTypeAppComment: "OuDia Ver. 1.02.05"
    )

    static let ekiJikokuPairs: [EkiJikokuPair] = [
        (
            "",
            []
        ),
        (
            ",,1;900,1;910/",
            [
                Jikoku(arrivalStatus: .notOperate),
                Jikoku(arrivalStatus: .notOperate),
                Jikoku(arrivalStatus: .stop, chaku: "", hatsu: "900"),
                Jikoku(arrivalStatus: .stop, chaku: "910", hatsu: "")
            ]
        ),
        (
            "1;900,3,3,1;910/",
            [
                Jikoku(arrivalStatus: .stop, chaku: "", hatsu: "900"),
                Jikoku(arrivalStatus: .notGoThrough),
                Jikoku(arrivalStatus: .notGoThrough),
                Jikoku(arrivalStatus: .stop, chaku: "910", hatsu: "")
            ]
        )
    ]

    static let ekiJikokuRecordPairs: [EkiJikokuRecordPair] = [
        ("",  Jikoku(arrivalStatus: .notOperate)),
        ("1", Jikoku(arrivalStatus: .stop)),
        ("2", Jikoku(arrivalStatus: .pass)),
        ("3", Jikoku(arrivalStatus: .notGoThrough)),
        ("1;900",      Jikoku(arrivalStatus: .stop, chaku: "",    hatsu: "900")),
        ("1;900/",     Jikoku(arrivalStatus: .stop, chaku: "900", hatsu: "")),
        ("1;900/1000", Jikoku(arrivalStatus: .stop, chaku: "900", hatsu: "1000")),
        ("2;1000",     Jikoku(arrivalStatus: .pass, chaku: "",    hatsu: "1000"))
    ]
}
