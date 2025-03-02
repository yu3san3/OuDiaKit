import SwiftUICore

public struct TrainType: Equatable, Sendable { // インデント数: 2
    /// 種別名 Syubetsumei
    public var name: String
    /// 略称 Ryakusyou
    public var shortName: String?
    /// 時刻表文字色 JikokuhyouMojiColor
    public var timetableTextColor: Color
    /// 時刻表フォント索引 JikokuhyouFontIndex
    public var timetableFontIndex: Int
    /// ダイヤグラム線の色 DiagramSenColor
    public var diagramLineColor: Color
    /// ダイヤグラム線の種類 DiagramLineStyle
    public var diagramLineStyle: DiagramLineStyle
    /// ダイヤグラム線が太線 DiagramSenIsBold
    public var isDiagramLineBold: Bool?
    /// 停車マーク描画タイプ StopMarkDrawType
    public var stopMarkDrawType: String?

    public init(
        name: String,
        shortName: String? = nil,
        timetableTextColor: Color,
        timetableFontIndex: Int,
        diagramLineColor: Color,
        diagramLineStyle: DiagramLineStyle,
        isDiagramLineBold: Bool? = nil,
        stopMarkDrawType: String? = nil
    ) {
        self.name = name
        self.shortName = shortName
        self.timetableTextColor = timetableTextColor
        self.timetableFontIndex = timetableFontIndex
        self.diagramLineColor = diagramLineColor
        self.diagramLineStyle = diagramLineStyle
        self.isDiagramLineBold = isDiagramLineBold
        self.stopMarkDrawType = stopMarkDrawType
    }
}

extension TrainType: Codable {
    enum CodingKeys: String, CodingKey {
        case name = "Syubetsumei"
        case shortName = "Ryakusyou"
        case timetableTextColor = "JikokuhyouMojiColor"
        case timetableFontIndex = "JikokuhyouFontIndex"
        case diagramLineColor = "DiagramSenColor"
        case diagramLineStyle = "DiagramSenStyle"
        case isDiagramLineBold = "DiagramSenIsBold"
        case stopMarkDrawType = "StopMarkDrawType"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.shortName = try container.decodeIfPresent(String.self, forKey: .shortName)
        self.timetableTextColor = try container.decode(Color.self, forKey: .timetableTextColor)
        self.timetableFontIndex = try container.decodeIntFromString(forKey: .timetableFontIndex)
        self.diagramLineColor = try container.decode(Color.self, forKey: .diagramLineColor)
        self.diagramLineStyle = try container.decode(DiagramLineStyle.self, forKey: .diagramLineStyle)
        self.isDiagramLineBold = try container
            .decodeBoolFromStringIfPresent(forKey: .isDiagramLineBold)
        self.stopMarkDrawType = try container
            .decodeIfPresent(String.self, forKey: .stopMarkDrawType)
    }
}

// MARK: - Enum

public enum DiagramLineStyle: String, Codable, Sendable {
    /// ダイヤグラム線の種類 実線 Jissen
    case solid = "SenStyle_Jissen"
    /// ダイヤグラム線の種類 破線 Hasen
    case dashed = "SenStyle_Hasen"
    /// ダイヤグラム線の種類 点線 Tensen
    case dotted = "SenStyle_Tensen"
    /// ダイヤグラム線の種類 一点鎖線 Ittensasen
    case dashDot = "SenStyle_Ittensasen"

    /// 線の描画パターン
    ///
    /// 描画する長さ、描画しない長さを順に配列で表現する。
    public var dash: [CGFloat] {
        switch self {
        case .solid: [] // -----
        case .dashed: [5, 2] // - - - - -
        case .dotted: [2, 2] // ･ ･ ･ ･ ･
        case .dashDot: [5, 2, 2, 2] // - ･ - ･ -
        }
    }
}
