import Foundation

public enum TravelTimeCalculator {
    static let oneDayInMinute = 1440

    /// すべての列車データをもとに、各駅間の走行時間(最小のもの)を計算する。
    ///
    /// - 各駅間の走行時間を得る都合上、通常は駅数より1少ない数の配列を得られる。
    /// - 時刻データが足りず走行時間を計算できない場合、走行時間は1として扱われる。
    /// - 通過も含め、一部区間を走行する列車がひとつもない場合、その区間の走行時間は結果に含まれない。
    public static func calculateTravelTimes(for timetables: [Timetable]) async -> [Int] {
        let schedules = extractSchedules(from: timetables)

        async let downTravelTimesList = schedules.down.map { schedule in
            calculateTravelTimes(for: schedule)
        }
        async let upTravelTimesList = schedules.up.reversed()
            .map { schedule in
                Array(
                    calculateTravelTimes(for: schedule)
                        .reversed()
                )
            }

        let travelTimesList = await downTravelTimesList + upTravelTimesList

        return mergeTravelTimesList(travelTimesList)
    }

    /// 各駅間の走行時間をもとに、基点駅からの距離を求める。
    ///
    /// - Parameter travelTimes: 各駅間の走行時間
    /// - Returns: 基点駅からの距離を表す配列
    ///
    /// 走行時間が駅間のものである都合上、基点駅の距離`0`が始点に挿入される。
    /// そのため、通常は`travelTimes`より要素数が1多い配列が返却される。
    ///
    /// - 例:
    /// [1, 2, 3, 4, 5] → [0, 1, 3, 6, 10, 15]
    public static func convertTravelTimesToDistanceFromBaseStation(
        travelTimes: [Int],
        direction: TrainDirection
    ) -> [Int] {
        let sumResult = travelTimes
            .reversed(shouldReverse: direction == .up)
            .reduce(into: []) { result, num in
                result.append((result.last ?? 0) + num)
            }

        return [0] + sumResult // はじめの駅は基点駅からの距離が0
    }

    /// 単一の列車スケジュールから、各駅間の走行時間(分)を計算する。
    ///
    /// nil の場合は Int.max として扱う。
    static func calculateTravelTimes(for schedule: Schedule) -> [Int] {
        let count = schedule.count
        guard count > 1 else { return [] }

        return (0..<count - 1).map { i in
            calculateTravelTime(from: schedule[i], to: schedule[i+1])
        }
    }

    /// 複数列車の各駅間走行時間の配列から、同一区間ごとに最短の走行時間を求める。
    ///
    /// 当該区間を走る列車がないなどの事情で最短走行時間を求められなかった場合、走行時間は`1`として扱われる。
    static func mergeTravelTimesList(_ travelTimesList: [[Int]]) -> [Int] {
        // 各列車で区間数が異なるため、最大区間数を基準とする
        let maxCount = travelTimesList.map(\.count).max() ?? 0
        guard maxCount > 0 else { return [] }

        return (0..<maxCount).map { index in
            // 各走行距離の index 番目（存在しない場合は Int.max）から最小値を取得
            travelTimesList
                .map {
                    $0.indices.contains(index) ? $0[index] : Int.max
                }
                .min() ?? Int.max
        }
        .map { $0 == Int.max ? 1 : $0 }
    }

    /// `Timetable`の配列から時刻データ`Schedule`の配列を抜き出す。
    private static func extractSchedules(
        from timetables: [Timetable]
    ) -> (down: [Schedule], up: [Schedule]) {
        let downTrainSchedules = timetables
            .flatMap(\.down.trains)
            .map(\.schedule)
        let upTrainSchedules = timetables
            .flatMap(\.up.trains)
            .map { Array($0.schedule.reversed()) }

        return (downTrainSchedules, upTrainSchedules)
    }

    /// 2つの駅間の走行時間を計算する。
    ///
    /// 現在の駅の出発時刻と次駅の到着時刻（なければ出発時刻）との差を算出する。差が0分となった場合、1分として扱う。
    private static func calculateTravelTime(
        from current: ScheduleEntry,
        to next: ScheduleEntry
    ) -> Int {
        guard let currentMinutesFromMidnight = current.$departure.minutesFromMidnight else {
            return Int.max
        }

        guard
            let nextMinutesFromMidnight = next.$arrival.minutesFromMidnight
                ?? next.$departure.minutesFromMidnight
        else {
            return Int.max
        }

        let diff = nextMinutesFromMidnight - currentMinutesFromMidnight
        // `diff`が0未満 → 日付を跨いだ場合
        let travelTime = diff < 0 ? diff + oneDayInMinute : diff

        return max(1, travelTime)
    }
}
