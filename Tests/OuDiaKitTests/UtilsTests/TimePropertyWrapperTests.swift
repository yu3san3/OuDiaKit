import Testing
@testable import OuDiaKit

struct TimePropertyWrapperTests {
    struct TimePropertyWrapperTestData {
        // MARK: Valid
        @Time var time930 = "930"
        @Time var time1030 = "1030"

        // MARK: Invalid
        @Time var time10 = "10"
        @Time var time1060 = "1060"
        @Time var time2500 = "2500"
        @Time var timeAbc = "abc"
        @Time var timeEmpty = ""
        @Time var timeNil = nil

        var invalidTimes: [Time] {
            [
                $time10,
                $time1060,
                $time2500,
                $timeAbc,
                $timeEmpty,
                $timeNil
            ]
        }
    }

    let testData: TimePropertyWrapperTestData

    init() {
        testData = .init()
    }

    @Test("正しい時刻 930")
    func testValidTime930() throws {
        #expect(testData.time930 == "930")

        let time = testData.$time930
        #expect(time.splitTime?.hour == 9)
        #expect(time.splitTime?.minute == 30)

        #expect(time.minutesFromMidnight == 570)
    }

    @Test("正しい時刻 1030")
    func testValidTime1030() throws {
        #expect(testData.time1030 == "1030")

        let time = testData.$time1030
        #expect(time.splitTime?.hour == 10)
        #expect(time.splitTime?.minute == 30)

        #expect(time.minutesFromMidnight == 630)
    }

    @Test("誤った時刻")
    func testInvalidTimes() {
        testData.invalidTimes.forEach { time in
            #expect(time.wrappedValue == nil)
            #expect(time.projectedValue.splitTime == nil)
            #expect(time.projectedValue.minutesFromMidnight == nil)
        }
    }
}
