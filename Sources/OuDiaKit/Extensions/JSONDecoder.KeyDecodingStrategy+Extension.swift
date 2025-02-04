import Foundation

extension JSONDecoder.KeyDecodingStrategy {
    static let convertFromUpperCamelCase: JSONDecoder.KeyDecodingStrategy = .custom { codingKeys in
        let lastKey = codingKeys.last!
        let keyString = lastKey.stringValue
        let transformedKey = keyString.prefix(1).lowercased() + keyString.dropFirst()
        return AnyCodingKey(stringValue: transformedKey)!
    }
}

private struct AnyCodingKey: CodingKey {
    var stringValue: String
    init?(stringValue: String) { self.stringValue = stringValue }

    var intValue: Int? { nil }
    init?(intValue: Int) { nil }
}
