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

    func decodeBoolFromStringIfPresent(forKey key: KeyedDecodingContainer.Key) throws -> Bool? {
        guard let stringValue = try decodeIfPresent(String.self, forKey: key) else {
            return nil
        }

        return stringValue == "1" ? true : false
    }

    func decodeScheduleFromString(forKey key: KeyedDecodingContainer.Key) throws -> Schedule {
        let stringValue = try decode(String.self, forKey: key)

        return ScheduleParser().parse(stringValue)
    }
}
