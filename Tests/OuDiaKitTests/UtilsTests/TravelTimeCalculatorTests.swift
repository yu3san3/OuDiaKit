import Testing
@testable import OuDiaKit

struct TravelTimeCalculatorTests {
    typealias TimetablesAndTravelTimesPair = (timetables: [Timetable], travelTimes: [Int])
    typealias ScheduleAndTravelTimesPair = (schedule: Schedule, travelTimes: [Int])
    typealias TravelTimesListAndTravelTimesPair = (travelTimesList: [[Int]], travelTimes: [Int])

    enum TravelTimeCalculatorTestData {
        static let scheduleAndTravelTimesPairs: [ScheduleAndTravelTimesPair] = [
            (
                [],
                []
            ),
            (
                [
                    .init(arrivalStatus: .stop, arrival: nil, departure: "900"),
                    .init(arrivalStatus: .stop, arrival: "908", departure: "910"),
                    .init(arrivalStatus: .stop, arrival: "918", departure: "920"),
                    .init(arrivalStatus: .stop, arrival: "928", departure: nil),
                ],
                [8, 8, 8]
            ),
            (
                [
                    .init(arrivalStatus: .stop, arrival: nil, departure: "900"),
                    .init(arrivalStatus: .stop, arrival: nil, departure: "910"),
                    .init(arrivalStatus: .stop, arrival: nil, departure: "920"),
                    .init(arrivalStatus: .stop, arrival: "930", departure: nil),
                ],
                [10, 10, 10]
            ),
            (
                [
                    .init(arrivalStatus: .stop, arrival: nil, departure: "900"),
                    .init(arrivalStatus: .pass),
                    .init(arrivalStatus: .pass),
                    .init(arrivalStatus: .stop, arrival: "930", departure: nil),
                ],
                [Int.max, Int.max, Int.max]
            ),
            (
                [
                    .init(arrivalStatus: .stop, arrival: nil, departure: "900"),
                    .init(arrivalStatus: .stop, arrival: nil, departure: "900"),
                    .init(arrivalStatus: .stop, arrival: "900", departure: nil),
                ],
                [1, 1]
            ),
            (
                [
                    .init(arrivalStatus: .stop, arrival: nil, departure: "2350"),
                    .init(arrivalStatus: .stop, arrival: nil, departure: "2355"),
                    .init(arrivalStatus: .stop, arrival: nil, departure: "000"),
                    .init(arrivalStatus: .stop, arrival: "005", departure: nil),
                ],
                [5, 5, 5]
            ),
            (
                Array(
                    repeating: .init(
                        arrivalStatus: .stop,
                        arrival: "900",
                        departure: "900"
                    ),
                    count: 300
                ),
                Array(repeating: 1, count: 300 - 1)
            )
        ]

        static let travelTimesListAndTravelTimesPairs: [TravelTimesListAndTravelTimesPair] = [
            (
                [
                    [1, 2, 3],
                    [2, 1, 4, 2],
                    [3, 2, 1, 5, 4]
                ],
                [1, 1, 1, 2, 4]
            ),
            (
                [[]],
                []
            ),
            (
                [
                    [],
                    [0],
                    [0, 0],
                    [0, 0, 0]
                ],
                [0, 0, 0]
            ),
            (
                [
                    [Int.max, Int.max]
                ],
                [1, 1]
            ),
            (
                Array(
                    repeating: Array(repeating: 1, count: 100),
                    count: 100
                ),
                Array(repeating: 1, count: 100)
            )
        ]

        static let timetablesAndTravelTimesPairs: [TimetablesAndTravelTimesPair] = [
            (
                TestData.mockOuDiaDiagram.route.timetables,
                [2, 3]
            )
        ]
    }

    @Test(
        "ダイヤから走行距離を正しく計算できる。",
        arguments: TravelTimeCalculatorTestData.timetablesAndTravelTimesPairs
    )
    func testCalculateTravelTimes(pair: TimetablesAndTravelTimesPair) async {
        let calculated = await TravelTimeCalculator.calculateTravelTimes(for: pair.timetables)

        #expect(calculated == pair.travelTimes)
    }

    @Test(
        "時刻データから走行距離を正しく計算できる。",
        arguments: TravelTimeCalculatorTestData.scheduleAndTravelTimesPairs
    )
    func testCalculateTravelTimes(pair: ScheduleAndTravelTimesPair) {
        let calculated = TravelTimeCalculator.calculateTravelTimes(for: pair.schedule)

        #expect(calculated == pair.travelTimes)
    }

    @Test(
        "複数の走行距離を正しく併合できる。",
        arguments: TravelTimeCalculatorTestData.travelTimesListAndTravelTimesPairs
    )
    func testMergeTravelTimesList(pair: TravelTimesListAndTravelTimesPair) {
        let merged = TravelTimeCalculator
            .mergeTravelTimesList(pair.travelTimesList)

        #expect(merged == pair.travelTimes)
    }
}
