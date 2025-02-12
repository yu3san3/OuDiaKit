import Foundation

public struct Station: Identifiable, Equatable, Sendable { // インデント数: 2
    public var id: UUID
    /// 駅名 Ekimei
    public var name: String
    /// 駅時刻形式 Ekijikokukeisiki
    public var timeType: StationTimeType
    /// 駅規模 Ekikibo
    public var scale: StationScale
    /// 境界線 Kyoukaisen
    public var borderLine: String?
    /// ダイヤグラム列車情報表示下り DiagramRessyajouhouHyoujiKudari
    public var downTrainInfoDisplayStyle: DiagramTrainInfoDisplayStyle?
    /// ダイヤグラム列車情報表示上り DiagramRessyajouhouHyoujiNobori
    public var upTrainInfoDisplayStyle: DiagramTrainInfoDisplayStyle?

    public init(
        id: UUID = UUID(),
        name: String,
        timeType: StationTimeType,
        scale: StationScale,
        borderLine: String? = nil,
        downTrainInfoDisplayStyle: DiagramTrainInfoDisplayStyle? = nil,
        upTrainInfoDisplayStyle: DiagramTrainInfoDisplayStyle? = nil
    ) {
        self.id = id
        self.name = name
        self.timeType = timeType
        self.scale = scale
        self.borderLine = borderLine
        self.downTrainInfoDisplayStyle = downTrainInfoDisplayStyle
        self.upTrainInfoDisplayStyle = upTrainInfoDisplayStyle
    }
}

extension Station: Codable {
    enum CodingKeys: String, CodingKey {
        case name = "Ekimei"
        case timeType = "Ekijikokukeisiki"
        case scale = "Ekikibo"
        case borderLine = "Kyoukaisen"
        case downTrainInfoDisplayStyle = "DiagramRessyajouhouHyoujiKudari"
        case upTrainInfoDisplayStyle = "DiagramRessyajouhouHyoujiNobori"
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.name = try container.decode(String.self, forKey: .name)
        self.timeType = try container.decode(StationTimeType.self, forKey: .timeType)
        self.scale = try container.decode(StationScale.self, forKey: .scale)
        self.borderLine = try container.decodeIfPresent(String.self, forKey: .borderLine)
        self.downTrainInfoDisplayStyle = try container
            .decodeIfPresent(DiagramTrainInfoDisplayStyle.self, forKey: .downTrainInfoDisplayStyle)
        self.upTrainInfoDisplayStyle = try container
            .decodeIfPresent(DiagramTrainInfoDisplayStyle.self, forKey: .upTrainInfoDisplayStyle)
    }
}

// MARK: - Enum

public enum StationTimeType: String, Codable, Sendable{
    /// 時刻形式 発 Hatsu
    case departure = "Jikokukeisiki_Hatsu"
    /// 時刻形式 発着 Hatsuchaku
    case arrivalDeparture = "Jikokukeisiki_Hatsuchaku"
    /// 時刻形式 下り着 KudariChaku
    case downArrival = "Jikokukeisiki_KudariChaku"
    /// 時刻形式 上り着 NoboriChaku
    case upArrival = "Jikokukeisiki_NoboriChaku"
}

public enum StationScale: String, Codable, Sendable {
    /// 駅規模 一般 Ippan
    case normal = "Ekikibo_Ippan"
    /// 駅規模 主要 Syuyou
    case major = "Ekikibo_Syuyou"
}

public enum DiagramTrainInfoDisplayStyle: String, Codable, Sendable {
    /// ダイヤグラム列車情報表示 表示 Anytime
    case anytime = "DiagramRessyajouhouHyouji_Anytime"
    /// ダイヤグラム列車情報表示 非表示 Not
    case none = "DiagramRessyajouhouHyouji_Not"
}
