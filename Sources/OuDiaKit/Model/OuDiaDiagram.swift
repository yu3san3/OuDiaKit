public struct OuDiaDiagram: Equatable, Codable, Sendable {
    public var fileType: String
    public var rosen: Rosen
    public var dispProp: DispProp
    public var fileTypeAppComment: String

    public init(
        fileType: String,
        rosen: Rosen,
        dispProp: DispProp,
        fileTypeAppComment: String
    ) {
        self.fileType = fileType
        self.rosen = rosen
        self.dispProp = dispProp
        self.fileTypeAppComment = fileTypeAppComment
    }
}
