public struct OuDiaDiagram: Equatable, Sendable {
    /// ファイル種類 FileType
    public var fileType: String
    /// 路線 Rosen
    public var route: Route
    /// 表示属性 DispProp
    public var displayProperty: DisplayProperty
    /// アプリによるファイル種類のコメント FileTypeAppComment
    public var fileTypeAppComment: String

    public init(
        fileType: String,
        route: Route,
        displayProperty: DisplayProperty,
        fileTypeAppComment: String
    ) {
        self.fileType = fileType
        self.route = route
        self.displayProperty = displayProperty
        self.fileTypeAppComment = fileTypeAppComment
    }
}

extension OuDiaDiagram: Codable {
    enum CodingKeys: String, CodingKey {
        case fileType = "FileType"
        case route = "Rosen"
        case displayProperty = "DispProp"
        case fileTypeAppComment = "FileTypeAppComment"
    }
}
