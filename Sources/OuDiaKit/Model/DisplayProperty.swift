import SwiftUICore

public struct DisplayProperty: Equatable, Codable, Sendable { // インデント数: 1
    /// 時刻表フォント JikokuhyouFont
    public var timetableFonts: [String]
    /// 時刻表縦書きフォントJikokuhyouVFont
    public var timetableVerticalFont: String
    /// ダイヤグラム駅名フォント DiaEkimeiFont
    public var diagramStationNameFont: String
    /// ダイヤグラム時刻フォント DiaJikokuFont
    public var diagramTimeFont: String
    /// ダイヤグラム列車フォント DiaRessyaFont
    public var diagramTrainFont: String
    /// コメントフォント CommentFont
    public var commentFont: String
    /// ダイヤグラム文字色 DiaMojiColor
    public var diagramTextColor: Color
    /// ダイヤグラム背景色 DiaHaikeiColor
    public var diagramBackgroundColor: Color
    /// ダイヤグラム列車色 DiaRessyaColor
    public var diagramTrainColor: Color
    /// ダイヤグラム軸色 DiaJikuColor
    public var diagramGridLineColor: Color
    /// 駅名の長さ EkimeiLength
    public var stationNameLength: String
    /// 時刻表の列車幅 JikokuhyouRessyaWidth
    public var timetableTrainWidth: String

    public init(
        timetableFonts: [String],
        timetableVerticalFont: String,
        diagramStationNameFont: String,
        diagramTimeFont: String,
        diagramTrainFont: String,
        commentFont: String,
        diagramTextColor: Color,
        diagramBackgroundColor: Color,
        diagramTrainColor: Color,
        diagramGridLineColor: Color,
        stationNameLength: String,
        timetableTrainWidth: String
    ) {
        self.timetableFonts = timetableFonts
        self.timetableVerticalFont = timetableVerticalFont
        self.diagramStationNameFont = diagramStationNameFont
        self.diagramTimeFont = diagramTimeFont
        self.diagramTrainFont = diagramTrainFont
        self.commentFont = commentFont
        self.diagramTextColor = diagramTextColor
        self.diagramBackgroundColor = diagramBackgroundColor
        self.diagramTrainColor = diagramTrainColor
        self.diagramGridLineColor = diagramGridLineColor
        self.stationNameLength = stationNameLength
        self.timetableTrainWidth = timetableTrainWidth
    }

    enum CodingKeys: String, CodingKey {
        case timetableFonts = "JikokuhyouFont"
        case timetableVerticalFont = "JikokuhyouVFont"
        case diagramStationNameFont = "DiaEkimeiFont"
        case diagramTimeFont = "DiaJikokuFont"
        case diagramTrainFont = "DiaRessyaFont"
        case commentFont = "CommentFont"
        case diagramTextColor = "DiaMojiColor"
        case diagramBackgroundColor = "DiaHaikeiColor"
        case diagramTrainColor = "DiaRessyaColor"
        case diagramGridLineColor = "DiaJikuColor"
        case stationNameLength = "EkimeiLength"
        case timetableTrainWidth = "JikokuhyouRessyaWidth"
    }
}
