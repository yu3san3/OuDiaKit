import Foundation

final class ScheduleParser {
    /// 時刻データの文字列を`ScheduleEntry`の配列へパースする。
    ///
    /// - Parameter text: OuDiaファイルにおける、`EKiJikoku=`以降の文字列
    /// - Returns: パースされた`ScheduleEntry`構造体の配列
    func parse(_ text: String) -> Schedule {
        if text.isEmpty {
            return []
        }

        return text
            .components(separatedBy: ",")
            .map { parseEntry(String($0)) }
    }

    /// 個々の時刻データを`ScheduleEntry`へパースする。
    ///
    /// - Parameter entry: `EkiJikoku`をコンマ区切りで分けた各文字列
    /// - Returns: パースされた`ScheduleEntry`構造体
    func parseEntry(_ entry: String) -> ScheduleEntry {
        // 運行なし
        if entry.isEmpty {
            return ScheduleEntry(arrivalStatus: .notOperate)
        }

        // 運行状態と時刻情報を分割
        let components = entry.split(separator: ";", maxSplits: 1).map(String.init)

        // 運行状態のみ記述されている場合 (ex: "1", "2")
        if components.count == 1 {
            return ScheduleEntry(
                arrivalStatus: ArrivalStatus(rawValueOrNotOperate: entry)
            )
        }

        let status = ArrivalStatus(rawValueOrNotOperate: components[0])
        let timePart = components[1]

        // "/" がない場合 → 発時刻のみ
        if !timePart.contains("/") {
            return ScheduleEntry(arrivalStatus: status, arrival: nil, departure: timePart)
        }

        // "HHMM/" → ["HHMM"] 着時刻のみ
        // "HHMM/HHMM" → ["HHMM", "HHMM"] 着発
        let times = timePart.split(separator: "/", maxSplits: 1).map(String.init)
        let arrival = times.first
        let departure = times.count > 1 ? times[1] : nil

        return ScheduleEntry(arrivalStatus: status, arrival: arrival, departure: departure)
    }
}
