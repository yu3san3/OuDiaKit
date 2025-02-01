import Foundation

/// OuDia形式のテキストをJSONに変換するクラス
final public class OudJSONConverter {
    /// JSONのインデント数（デフォルトは4）
    public var indentCount = 4

    /// 変換結果のJSON文字列
    private var result = ""

    /// JSONのネスト状態を管理するプロパティ
    private var bracketState = [Bracket]()

    /// 現在のインデント幅を返す計算プロパティ
    private var currentIndent: String {
        let indent = String(repeating: " ", count: indentCount)
        return String(repeating: indent, count: bracketState.count)
    }

    /// OuDia形式のテキストをJSON文字列に変換する。
    ///
    /// - Parameter text: OuDia形式のテキスト
    /// - Returns: 変換されたJSON文字列
    public func toJSONString(_ text: String) -> String? {
        convertAndStoreToResult(text)

        return result
    }

    /// OuDia形式のテキストを解析し、JSONに変換して`result`に格納する。
    ///
    /// - Parameter text: OuDia形式のテキスト
    private func convertAndStoreToResult(_ text: String) {
        openObject(key: nil, bracket: .object(nil))

        let lines = text.components(separatedBy: .newlines)
        for line in lines {
            processLine(line)
        }

        closeBracket()
        removeLastComma()
    }

    /// 1行のテキストを解析し、適切な処理を行う。
    ///
    /// - Parameter line: 解析する行
    private func processLine(_ line: String) {
        let trimmedLine = line.trimmingCharacters(in: .whitespaces)
        guard !trimmedLine.isEmpty else { return }

        // 行がピリオドの場合
        if trimmedLine == "." {
            processOnlyPeriodLine()
        }
        // 行がピリオドで終わる場合
        else if trimmedLine.hasSuffix(".") {
            processLineEndingWithPeriod(trimmedLine)
        }
        // 行がイコールを含む場合
        else if trimmedLine.contains("=") {
            processKeyValueLine(trimmedLine)
        }
        // それ以外
        else {
            result.append(currentIndent + trimmedLine + "\n")
        }
    }

    /// 行が単体のピリオド（"."）の場合に、現在のブロックを閉じる。
    private func processOnlyPeriodLine() {
        if bracketState.last?.isArray == true {
            closeBracket()
        }

        closeBracket()
    }

    /// 行がピリオド（"."）で終わる場合に、新しいオブジェクトまたは配列を開く。
    ///
    /// - Parameter line: 解析する行（ピリオドを含む）
    private func processLineEndingWithPeriod(_ line: String) {
        let key = String(line.dropLast())

        let currentState = RepeatableKey(rawValue: key)
        let isCurrentKeyRepeatable = currentState != nil

        if isCurrentKeyRepeatable {
            if bracketState.last?.isSameKey(key) == false {
                if bracketState.last?.isArray == true {
                    closeBracket()
                }

                openObject(key: key, bracket: .array(key))
            }

            openObject(key: nil, bracket: .object(nil))
        } else {
            openObject(key: key, bracket: .object(key))
        }
    }

    /// キーと値が含まれる行を解析し、JSONのプロパティとして追加する。
    ///
    /// - Parameter line: `key=value` の形式の行
    private func processKeyValueLine(_ line: String) {
        let components = line.components(separatedBy: "=")
        let key = components[0]
            .trimmingCharacters(in: .whitespaces)
        let value = components.dropFirst()
            .joined(separator: "=")
            .trimmingCharacters(in: .whitespaces)

        let currentState = RepeatableKey(rawValue: key)
        let isCurrentKeyEnumerable = currentState != nil

        if isCurrentKeyEnumerable {
            if bracketState.last?.isSameKey(key) == false {
                openObject(key: key, bracket: .array(key))
            }

            result.append(currentIndent + "\"\(value)\",\n")
        } else {
            if bracketState.last?.isArray == true {
                closeBracket()
            }

            result.append(currentIndent + "\"\(key)\": \"\(value)\",\n")
        }
    }

    /// 指定されたキーを持つオブジェクトまたは配列を開始する。
    ///
    /// - Parameters:
    ///   - key: JSON のキー（nil の場合は無名オブジェクトを開始）
    ///   - bracket: 開始するオブジェクトの種類（オブジェクトまたは配列）
    private func openObject(key: String?, bracket: Bracket) {
        let line = if let key {
            "\"\(key)\": " + bracket.openedBracket + "\n"
        } else {
            bracket.openedBracket + "\n"
        }

        result.append(currentIndent + line)
        bracketState.append(bracket)
    }

    /// JSON 構造内のオブジェクトまたは配列を閉じる。
    ///
    /// `bracketState` の最後の要素に基づいて閉じ括弧 (`}` または `]`) を追加する。
    private func closeBracket() {
        guard let targetBracket = bracketState.last else {
            // TODO: エラーハンドリングをする。
            fatalError("bracketStateが空っぽ")
        }

        bracketState.removeLast()
        removeLastComma()
        result.append(currentIndent + targetBracket.closedBracket + ",\n")
    }

    /// JSONの最後のカンマを削除し、適切にフォーマットを調整する。
    private func removeLastComma() {
        result.removeLast(2)
        result.append("\n")
    }
}
