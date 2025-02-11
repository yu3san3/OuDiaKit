import SwiftUICore

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
