import Foundation

final class EkiJikokuParser {
    func parse(_ text: String) -> [Jikoku] {
        if text.isEmpty {
            return []
        }

        return text
            .components(separatedBy: ",")
            .map { parseRecord(String($0)) }
    }

    func parseRecord(_ record: String) -> Jikoku {
        // 運行なし
        if record.isEmpty {
            return Jikoku(arrivalStatus: .notOperate)
        }

        // 運行状態と時刻情報を分割
        let components = record.split(separator: ";", maxSplits: 1).map(String.init)

        // 運行状態のみ記述されている場合 (ex: "1", "2")
        if components.count == 1 {
            return Jikoku(
                arrivalStatus: ArrivalStatus(rawValueOrNotOperate: record)
            )
        }

        let status = ArrivalStatus(rawValueOrNotOperate: components[0])
        let timePart = components[1]

        // "/" がない場合 → 発時刻のみ
        if !timePart.contains("/") {
            return Jikoku(arrivalStatus: status, chaku: "", hatsu: timePart)
        }

        // "HHMM/" → ["HHMM"] 着時刻のみ
        // "HHMM/HHMM" → ["HHMM", "HHMM"] 着発
        let times = timePart.split(separator: "/", maxSplits: 1).map(String.init)
        let chaku = times.first ?? ""
        let hatsu = times.count > 1 ? times[1] : ""

        return Jikoku(arrivalStatus: status, chaku: chaku, hatsu: hatsu)
    }
}
