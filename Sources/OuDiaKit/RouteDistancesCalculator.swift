import Foundation

public enum RouteDistancesCalculator {
    static let oneDayInMinute = 1440

    /// すべての列車データをもとに、各駅間の走行距離を計算する。
    ///
    /// - 実際には各駅間の走行時間を表しているが、便宜的に走行距離として扱っている。
    /// - 走行時間は、当該区間のすべての走行距離の中で最小のものを求める。
    /// - 各駅間の走行距離を得る都合上、通常は駅数より1少ない数の配列を得られる。
    /// - 時刻データが足りず走行距離を計算できない場合、距離は1として扱われる。
    /// - 通過も含め、一部区間を走行する列車がひとつもない場合、その区間の走行距離は結果に含まれない。
    public static func calculateDistancesBetweenStations(for timetables: [Timetable]) async -> [Int] {
        let schedules = extractSchedules(from: timetables)

        async let downDistancesList = schedules.down.map { schedule in
            calculateDistances(for: schedule)
        }
        async let upDistancesList = schedules.up.reversed()
            .map { schedule in
                Array(
                    calculateDistances(for: schedule)
                        .reversed()
                )
            }

        let distancesList = await downDistancesList + upDistancesList

        return mergeDistancesList(distancesList)
    }

    /// 各駅間の距離を基点駅からの距離へ変換する。
    ///
    /// - Parameter distances: 各駅間の走行距離を表す配列
    /// - Returns: 基点駅からの距離を表す配列
    ///
    /// 走行時間が駅間のものである都合上、基点駅自体の距離`0`が配列の始めに挿入される。
    /// そのため、通常は`distances`より要素数が1多い配列が返却される。
    ///
    /// - 例:
    /// [1, 2, 3, 4, 5] → [0, 1, 3, 6, 10, 15]
    public static func convertToDistancesFromBaseStation(
        from distances: [Int]
    ) -> [Int] {
        let sumResult = distances
            .reduce(into: []) { result, num in
                result.append((result.last ?? 0) + num)
            }

        return [0] + sumResult // はじめの駅は基点駅からの距離が0
    }

    /// 単一の列車スケジュールから、各駅間の走行距離を計算する。
    ///
    /// 当該区間を走る列車がないなどの事情で最短走行距離を求められない場合、距離は`1`として扱う。
    static func calculateDistances(for schedule: Schedule) -> [Int] {
        let count = schedule.count
        guard count > 1 else { return [] }

        return (0..<count - 1).map { i in
            calculateDistance(from: schedule[i], to: schedule[i+1])
        }
    }

    /// 複数列車の各駅間走行距離の配列から、各駅間ごとに最短の距離を求める。
    ///
    /// 当該区間を走る列車がないなどの事情で最短走行距離を求められない場合、距離は`1`として扱う。
    static func mergeDistancesList(_ distancesList: [[Int]]) -> [Int] {
        // 各列車で区間数が異なるため、最大区間数を基準とする
        let maxCount = distancesList.map(\.count).max() ?? 0
        guard maxCount > 0 else { return [] }

        return (0..<maxCount).map { index in
            // 各走行距離の index 番目（存在しない場合は Int.max）から最小値を取得
            distancesList
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

    /// 2つの駅間の走行距離を計算する。
    ///
    /// 現在の駅の出発時刻と次駅の到着時刻（なければ出発時刻）との差を算出し、距離とする。
    /// 差が0分となった場合、距離は1として扱う。
    private static func calculateDistance(
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
        let distance = diff < 0 ? diff + oneDayInMinute : diff

        return max(1, distance)
    }
}
