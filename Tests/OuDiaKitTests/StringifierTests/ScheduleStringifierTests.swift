import Testing
@testable import OuDiaKit

struct ScheduleStringifierTests {
    @Test(
        "Schedule の文字列化を検証",
        arguments: TestData.schedulePairs
    )
    func testStringifySchedule(with schedulePair: TestData.SchedulePair) {
        let schedule = ScheduleStringifier().stringify(schedulePair.object)
        let expectedSchedule = schedulePair.string

        #expect(schedule == expectedSchedule)
    }

    @Test(
        "EkiJikoku の各駅データの文字列化を検証",
        arguments: TestData.scheduleEntryPairs
    )
    func testStringifyScheduleEntry(with ScheduleEntryPair: TestData.ScheduleEntryPair) {
        let entry = ScheduleStringifier().stringifyEntry(ScheduleEntryPair.object)
        let expectedScheduleEntry = ScheduleEntryPair.string

        #expect(entry == expectedScheduleEntry)
    }
}
