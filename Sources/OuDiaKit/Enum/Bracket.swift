enum Bracket: Equatable {
    case object(_ key: String?)
    case array(_ key: String?)

    var isArray: Bool {
        if case .array = self {
            true
        } else {
            false
        }
    }

    var openedBracket: String {
        switch self {
        case .object: "{"
        case .array: "["
        }
    }

    var closedBracket: String {
        switch self {
        case .object: "}"
        case .array: "]"
        }
    }

    func isSameKey(_ otherKey: String) -> Bool {
        switch self {
        case let .object(key), let .array(key):
            return key == otherKey
        }
    }
}
