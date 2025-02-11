@propertyWrapper
public struct Time: Sendable {
    public typealias TimeComponent = (hour: Int, minute: Int)

    private var splitTime: TimeComponent?
    private var rawTime: String?

    public var wrappedValue: String? {
        get { rawTime }
        set { setTime(newValue) }
    }

    public var projectedValue: TimeComponent? { splitTime }

    public init(wrappedValue time: String?) {
        setTime(time)
    }

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

    private mutating func setTime(_ newTime: String?) {
        splitTime = newTime.flatMap { splitToTimeComponent($0) }
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
