import SwiftUICore

public struct Ressyasyubetsu: Equatable, Sendable { // インデント数: 2
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
}

extension Ressyasyubetsu: Codable {
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

// MARK: - Enum

public enum DiagramSenStyle: String, Codable, Sendable {
    case jissen = "SenStyle_Jissen"
    case hasen = "SenStyle_Hasen"
    case tensen = "SenStyle_Tensen"
    case ittensasen = "SenStyle_Ittensasen"
}
