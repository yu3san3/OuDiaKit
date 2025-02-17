import Foundation

final class ScheduleStringifier {
    /// 時刻データ`ScheduleEntry`の配列を文字列化する。
    ///
    /// - Parameter schedule: `ScheduleEntry`の配列
    /// - Returns: 文字列化された時刻データの文字列
    func stringify(_ schedule: Schedule) -> String {
        schedule
            .map { stringifyEntry($0) }
            .joined(separator: ",")
    }

    /// 個々の時刻データ`ScheduleEntry`を文字列化する。
    ///
    /// - Parameter entry: `ScheduleEntry`構造体
    /// - Returns: 文字列化された単一の時刻データの文字列
    func stringifyEntry(_ entry: ScheduleEntry) -> String {
        var result = entry.arrivalStatus.rawValue

        let arrival = entry.arrival
        let departure = entry.departure

        if let arrival, let departure {
            result += ";\(arrival)/\(departure)"
        } else if let arrival {
            result += ";\(arrival)/"
        } else if let departure {
            result += ";\(departure)"
        }

        return result
    }
}
