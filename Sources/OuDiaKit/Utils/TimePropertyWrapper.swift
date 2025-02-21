import Foundation

@propertyWrapper
public struct Time: Identifiable, Sendable {

    /// 時刻の構造 `(hour: Int, minute: Int)`
    public typealias TimeComponent = (hour: Int, minute: Int)

    /// `(hour: Int, minute: Int)` 形式での時刻
    public var splitTime: TimeComponent?

    /// 0時00分からの経過時間(分)
    public var minutesFromMidnight: Int?

    /// 一意なID
    public let id = UUID()

    /// 元の文字列形式の時刻
    private var rawTime: String?

    /// `wrappedValue` は、元の時刻の文字列を保持します。
    /// 値をセットする際には、時刻の形式が正しいか検証されます。
    public var wrappedValue: String? {
        get { rawTime }
        set { setTime(newValue) }
    }

    /// `Time` 構造体のインスタンスを提供します。
    ///
    /// Timeのインスタンスを通じて、以下の値を取得できます。
    /// - 時刻文字列の解析結果 `(hour: Int, minute: Int)`
    /// - 0時00分からの経過時間(分)
    ///
    /// - 例:
    ///   ```swift
    ///   @Time var time = "930"
    ///
    ///   print($time.splitTime) // (hour: 9, minute: 30))
    ///   print($time.minutesFromMidnight) // 570
    ///   ```
    public var projectedValue: Self { self }

    /// 時刻を表すプロパティラッパー
    ///
    /// - Parameter wrappedValue: `"HHMM"` または `"HMM"` の形式の時刻文字列
    ///
    /// `Time` プロパティラッパーは、文字列形式の時刻 (`"HHMM"` または `"HMM"`) を
    /// `wrappedValue` に保持し、対応する `(hour: Int, minute: Int)` のタプルを `projectedValue` として提供します。
    ///
    /// - 例:
    ///   ```swift
    ///   @Time var time = "930"
    ///   print(time)  // "930"
    ///   print($time) // (hour: 9, minute: 30)
    ///   ```
    public init(wrappedValue time: String?) {
        setTime(time)
    }

    /// 文字列の時刻を `(hour: Int, minute: Int)` に変換するヘルパーメソッド。
    ///
    /// - Parameter time: `"HHMM"` または `"HMM"` の形式の時刻文字列
    /// - Returns: `(hour: Int, minute: Int)` のタプル。変換に失敗した場合は `nil` を返す。
    func splitToTimeComponent(_ time: String) -> TimeComponent? {
        guard time.count == 3 || time.count == 4 else { return nil }

        let hourPart = String(time.prefix(time.count - 2))
        let minutePart = String(time.suffix(2))

        guard
            let hour = Int(hourPart),
            let minute = Int(minutePart),
            hour < 24, minute < 60
        else { return nil }

        return (hour, minute)
    }

    /// `wrappedValue` の更新時に、正しい時刻形式であるかを検証し、内部状態を更新する。
    ///
    /// - Parameter newTime: `"HHMM"` または `"HMM"` の形式の時刻文字列
    private mutating func setTime(_ newTime: String?) {
        splitTime = newTime.flatMap { splitToTimeComponent($0) }
        minutesFromMidnight = splitTime.flatMap { $0.hour * 60 + $0.minute }
        rawTime = splitTime != nil ? newTime : nil
    }
}

extension Time: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let decodedRawTime = try container.decode(String?.self)
        setTime(decodedRawTime)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

extension Time: Equatable {
    public static func == (lhs: Time, rhs: Time) -> Bool {
        lhs.wrappedValue == rhs.wrappedValue
    }
}
