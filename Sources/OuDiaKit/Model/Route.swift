public struct Route: Equatable, Sendable { // インデント数: 1
    /// 路線名 Rosenmei
    public var name: String
    /// 駅 Eki
    public var stations: [Station]
    /// 列車種別 Ressyasyubetsu
    public var trainTypes: [TrainType]
    /// ダイヤ Dia
    public var timetables: [Timetable]
    /// 起点時刻 KitenJikoku
    @Time public var diagramBaseTime: String?
    /// ダイヤグラムY座標距離デフォルト DiagramDgrYZahyouKyoriDefault
    public var diagramDefaultDistance: Int
    /// コメント Comment
    public var comment: String

    public init(
        name: String,
        stations: [Station],
        trainTypes: [TrainType],
        timetables: [Timetable],
        diagramBaseTime: String,
        diagramDefaultDistance: Int,
        comment: String
    ) {
        self.name = name
        self.stations = stations
        self.trainTypes = trainTypes
        self.timetables = timetables
        self.diagramBaseTime = diagramBaseTime
        self.diagramDefaultDistance = diagramDefaultDistance
        self.comment = comment
    }
}

extension Route: Codable {
    enum CodingKeys: String, CodingKey {
        case name = "Rosenmei"
        case stations = "Eki"
        case trainTypes = "Ressyasyubetsu"
        case timetables = "Dia"
        case diagramBaseTime = "KitenJikoku"
        case diagramDefaultDistance = "DiagramDgrYZahyouKyoriDefault"
        case comment = "Comment"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.stations = try container.decodeIfPresent([Station].self, forKey: .stations) ?? []
        self.trainTypes = try container.decode([TrainType].self, forKey: .trainTypes)
        self.timetables = try container.decodeIfPresent([Timetable].self, forKey: .timetables) ?? []
        self.diagramBaseTime = try container.decode(String.self, forKey: .diagramBaseTime)
        self.diagramDefaultDistance = try container
            .decodeIntFromString(forKey: .diagramDefaultDistance)
        self.comment = try container.decode(String.self, forKey: .comment)
    }
}
