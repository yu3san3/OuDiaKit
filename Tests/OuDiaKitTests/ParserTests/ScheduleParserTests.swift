import Testing
@testable import OuDiaKit

struct ScheduleParserTests {
    @Test(
        "Schedule のパースを検証",
        arguments: TestData.schedulePairs
    )
    func testParseSchedule(with schedulePair: TestData.SchedulePair) {
        let schedule = ScheduleParser().parse(schedulePair.string)
        let expectedSchedule = schedulePair.object

        #expect(schedule.count == expectedSchedule.count)

        zip(schedule, expectedSchedule).forEach(assertScheduleEntryEquality)
    }

    @Test(
        "ScheduleEntry のパースを検証",
        arguments: TestData.scheduleEntryPairs
    )
    func testParseScheduleEntry(with scheduleEntryPair: TestData.ScheduleEntryPair) {
        let entry = ScheduleParser().parseEntry(scheduleEntryPair.string)
        let expectedEntry = scheduleEntryPair.object

        assertScheduleEntryEquality(entry, expectedEntry)
    }

    private func assertScheduleEntryEquality(_ entry: ScheduleEntry, _ expected: ScheduleEntry) {
        #expect(entry.arrivalStatus == expected.arrivalStatus)
        #expect(entry.arrival == expected.arrival)
        #expect(entry.departure == expected.departure)
    }
}
