import SwiftUICore
@testable import OuDiaKit

enum TestData {
    typealias SchedulePair = (string: String, object: Schedule)
    typealias ScheduleEntryPair = (string: String, object: ScheduleEntry)

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
        route: .init(
            name: "名鉄名古屋本線",
            stations: [
                .init(
                    name: "金山",
                    timeType: .upArrival,
                    scale: .major
                ),
                .init(
                    name: "山王",
                    timeType: .arrivalDeparture,
                    scale: .normal
                ),
                .init(
                    name: "名鉄名古屋",
                    timeType: .downArrival,
                    scale: .major
                )
            ],
            trainTypes: [
                .init(
                    name: "普通",
                    timetableTextColor: Color(oudColorCode: "00000000"),
                    timetableFontIndex: 0,
                    diagramLineColor: Color(oudColorCode: "00000000"),
                    diagramLineStyle: .solid,
                    stopMarkDrawType: "EStopMarkDrawType_DrawOnStop"
                ),
                .init(
                    name: "特別急行",
                    shortName: "特急",
                    timetableTextColor: Color(oudColorCode: "000000FF"),
                    timetableFontIndex: 0,
                    diagramLineColor: Color(oudColorCode: "000000FF"),
                    diagramLineStyle: .solid,
                    stopMarkDrawType: "EStopMarkDrawType_DrawOnStop"
                )
            ],
            timetables: [
                .init(
                    title: "平日",
                    down: .init(
                        trains: [
                            .init(
                                direction: .down,
                                typeIndex: 1,
                                number: "307",
                                schedule: [
                                    .init(arrivalStatus: .stop, arrival: "", departure: "1009"),
                                    .init(arrivalStatus: .pass),
                                    .init(arrivalStatus: .stop, arrival: "1014", departure: "")
                                ]
                            ),
                            .init(
                                direction: .down,
                                typeIndex: 0,
                                number: "1093",
                                schedule: [
                                    .init(arrivalStatus: .stop, arrival: "", departure: "1011"),
                                    .init(arrivalStatus: .stop, arrival: "1013", departure: "1013"),
                                    .init(arrivalStatus: .stop, arrival: "1016", departure: "")
                                ]
                            )
                        ]
                    ),
                    up: .init(trains: [])
                ),
                .init(
                    title: "休日",
                    down: .init(
                        trains: [
                            .init(
                                direction: .down,
                                typeIndex: 1,
                                number: "101",
                                schedule: [
                                    .init(arrivalStatus: .stop, arrival: "", departure: "1004"),
                                    .init(arrivalStatus: .pass),
                                    .init(arrivalStatus: .stop, arrival: "1008", departure: "")
                                ]
                            )
                        ]
                    ),
                    up: .init(
                        trains: [
                            .init(
                                direction: .up,
                                typeIndex: 0,
                                number: "100",
                                schedule: [
                                    .init(arrivalStatus: .stop, arrival: "", departure: "1003"),
                                    .init(arrivalStatus: .pass),
                                    .init(arrivalStatus: .stop, arrival: "1006", departure: "")
                                ]
                            )
                        ]
                    )
                )
            ],
            diagramBaseTime: "400",
            diagramDefaultDistance: 60,
            comment: ""
        ),
        displayProperty: .init(
            timetableFonts: [
                "PointTextHeight=9;Facename=ＭＳ ゴシック",
                "PointTextHeight=9;Facename=ＭＳ ゴシック;Bold=1",
                "PointTextHeight=9;Facename=ＭＳ ゴシック;Itaric=1",
                "PointTextHeight=9;Facename=ＭＳ ゴシック;Bold=1;Itaric=1",
                "PointTextHeight=9;Facename=ＭＳ ゴシック",
                "PointTextHeight=9;Facename=ＭＳ ゴシック",
                "PointTextHeight=9;Facename=ＭＳ ゴシック",
                "PointTextHeight=9;Facename=ＭＳ ゴシック",
            ],
            timetableVerticalFont: "PointTextHeight=9;Facename=@ＭＳ ゴシック",
            diagramStationNameFont: "PointTextHeight=9;Facename=ＭＳ ゴシック",
            diagramTimeFont: "PointTextHeight=9;Facename=ＭＳ ゴシック",
            diagramTrainFont: "PointTextHeight=9;Facename=ＭＳ ゴシック",
            commentFont: "PointTextHeight=9;Facename=ＭＳ ゴシック",
            diagramTextColor: Color(oudColorCode: "00000000"),
            diagramBackgroundColor: Color(oudColorCode: "00FFFFFF"),
            diagramTrainColor: Color(oudColorCode: "00000000"),
            diagramGridLineColor: Color(oudColorCode: "00C0C0C0"),
            stationNameLength: "6",
            timetableTrainWidth: "5"
        ),
        fileTypeAppComment: "OuDia Ver. 1.02.05"
    )

    static let schedulePairs: [SchedulePair] = [
        (
            "",
            []
        ),
        (
            ",,1;900,1;910/",
            [
                ScheduleEntry(arrivalStatus: .notOperate),
                ScheduleEntry(arrivalStatus: .notOperate),
                ScheduleEntry(arrivalStatus: .stop, arrival: "", departure: "900"),
                ScheduleEntry(arrivalStatus: .stop, arrival: "910", departure: "")
            ]
        ),
        (
            "1;900,3,3,1;910/",
            [
                ScheduleEntry(arrivalStatus: .stop, arrival: "", departure: "900"),
                ScheduleEntry(arrivalStatus: .notGoThrough),
                ScheduleEntry(arrivalStatus: .notGoThrough),
                ScheduleEntry(arrivalStatus: .stop, arrival: "910", departure: "")
            ]
        )
    ]

    static let scheduleEntryPairs: [ScheduleEntryPair] = [
        ("",  ScheduleEntry(arrivalStatus: .notOperate)),
        ("1", ScheduleEntry(arrivalStatus: .stop)),
        ("2", ScheduleEntry(arrivalStatus: .pass)),
        ("3", ScheduleEntry(arrivalStatus: .notGoThrough)),
        ("1;900",      ScheduleEntry(arrivalStatus: .stop, arrival: "",    departure: "900")),
        ("1;900/",     ScheduleEntry(arrivalStatus: .stop, arrival: "900", departure: "")),
        ("1;900/1000", ScheduleEntry(arrivalStatus: .stop, arrival: "900", departure: "1000")),
        ("2;1000",     ScheduleEntry(arrivalStatus: .pass, arrival: "",    departure: "1000"))
    ]
}
