import Foundation

/// OuDia形式のテキストをJSONに変換するクラス
final public class OuDiaJSONConverter {
    private let repeatableKeysRegistry = RepeatableKeysRegistry()

    /// 現在登録されている繰り返し可能なキーのセットを取得する。
    ///
    /// - Returns: 繰り返しが可能なキーの集合
    public var repeatableKeys: Set<String> {
        repeatableKeysRegistry.getKeys()
    }

    public init() {}

    /// OuDia形式のテキストをJSON dataに変換する。
    ///
    /// - Parameter text: OuDia形式のテキスト
    /// - Returns: 変換されたJSON data（変換に失敗した場合はnil）
    public func convertToJSON(_ text: String) throws -> Data {
        let lines = text.components(separatedBy: .newlines)
        var index = 0
        let root = parseBlock(lines: lines, index: &index)
        return try JSONSerialization.data(withJSONObject: root, options: .prettyPrinted)
    }

    /// 繰り返し可能なキーを追加する。
    ///
    /// - Parameter keys: 追加するキーの集合
    ///
    /// - Note: 既存のキーに新しいキーが追加されるが、すでに存在するキーは無視される。
    public func addRepeatableKeys(_ keys: Set<String>) {
        repeatableKeysRegistry.addKeys(keys)
    }

    /// 行配列から現在のブロックを再帰的にパースする。
    private func parseBlock(lines: [String], index: inout Int) -> [String: Any] {
        var dict = [String: Any]()

        while index < lines.count {
            let line = lines[index].trimmingCharacters(in: .whitespacesAndNewlines)
            index += 1

            // 空行はスキップ、"." はブロック終了
            if line.isEmpty { continue }
            if line == "." { break }

            if line.hasSuffix(".") {
                // ブロック開始（例："Rosen." や "Eki."）
                let key = String(line.dropLast())
                let subBlock = parseBlock(lines: lines, index: &index)
                add(key: key, value: subBlock, to: &dict)
            } else if let equalRange = line.range(of: "=") {
                // key=value 行。rangeを利用することでsplit処理を簡潔に
                let key = String(line[..<equalRange.lowerBound])
                let value = String(line[equalRange.upperBound...])
                add(key: key, value: value, to: &dict)
            }
        }

        return dict
    }

    /// 指定のキーに値を追加する。既に値がある場合は、配列としてまとめる。
    private func add(key: String, value: Any, to dict: inout [String: Any]) {
        if let existing = dict[key] {
            if var array = existing as? [Any] {
                array.append(value)
                dict[key] = array
            } else {
                dict[key] = [existing, value]
            }
        } else {
            let mustBeArray = repeatableKeys.contains(key)
            dict[key] = mustBeArray ? [value] : value
        }
    }
}
