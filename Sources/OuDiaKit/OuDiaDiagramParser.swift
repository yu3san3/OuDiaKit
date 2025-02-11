import Foundation

final public class OuDiaDiagramParser {
    /// OuDia 形式のテキストデータを JSON に変換するためのコンバータ
    public var converter = OuDiaJSONConverter()

    /// 型のコーディングキーを JSON のキーからどのようにデコードするかを決定する値
    public var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromUpperCamelCase

    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecodingStrategy
        return decoder
    }

    public init() {}

    /// 指定された型にOuDia形式のテキストデータをパース (オブジェクト化) する。
    ///
    /// このメソッドは、内部でOuDia 形式のテキストデータをまずは JSON へ変換し、
    /// その JSON を指定された `Decodable` 型にデコードしています。
    ///
    /// - Parameters:
    ///   - type: デコードする型。デフォルトは `OuDiaDiagram`。
    ///   - text: 変換対象の OuDia 形式のテキストデータ
    /// - Returns: 指定された `Decodable` 型のインスタンス
    public func parse<T>(
        _ type: T.Type = OuDiaDiagram.self,
        from text: String
    ) throws -> T where T: Decodable {
        let data = try converter.convertToJSON(text)
        return try decoder.decode(type, from: data)
    }
}
