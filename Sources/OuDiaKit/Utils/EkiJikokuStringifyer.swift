import Foundation

final class EkiJikokuStringifyer {
    func stringify(_ jikokuArray: [Jikoku]) -> String {
        jikokuArray
            .map { stringifyRecord($0) }
            .joined(separator: ",")
    }

    func stringifyRecord(_ jikoku: Jikoku) -> String {
        var result = jikoku.arrivalStatus.rawValue

        let chaku = jikoku.chaku
        let hatsu = jikoku.hatsu

        if let chaku, let hatsu {
            result += ";\(chaku)/\(hatsu)"
        } else if let chaku {
            result += ";\(chaku)/"
        } else if let hatsu {
            result += ";\(hatsu)"
        }

        return result
    }
}
