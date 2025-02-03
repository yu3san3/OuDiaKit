import SwiftUICore

extension KeyedDecodingContainer {
    func decodeIntFromString(forKey key: KeyedDecodingContainer.Key) throws -> Int {
        let stringValue = try decode(String.self, forKey: key)

        guard let intValue = Int(stringValue) else {
            throw DecodingError.dataCorruptedError(
                forKey: key,
                in: self,
                debugDescription: "Expected a String convertible to Int"
            )
        }

        return intValue
    }

    func decodeJikokuFromString(forKey key: KeyedDecodingContainer.Key) throws -> [Jikoku] {
        let stringValue = try decode(String.self, forKey: key)

        return EkiJikokuParser().parse(stringValue)
    }
}
