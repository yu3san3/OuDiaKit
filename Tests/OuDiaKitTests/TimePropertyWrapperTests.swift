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

        var invalidWrappedTimes: [String?] {
            [
                time10,
                time1060,
                time2500,
                timeAbc,
                timeEmpty,
                timeNil,
            ]
        }

        var invalidProjectedTimes: [Time.TimeComponent?] {
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

        let time = try #require(testData.$time930)
        #expect(time.hour == 9)
        #expect(time.minute == 30)
    }

    @Test("正しい時刻 1030")
    func testValidTime1030() throws {
        #expect(testData.time1030 == "1030")

        let time = try #require(testData.$time1030)
        #expect(time.hour == 10)
        #expect(time.minute == 30)
    }

    @Test("誤った時刻")
    func testInvalidTimes() {
        zip(testData.invalidWrappedTimes, testData.invalidProjectedTimes).forEach {
            #expect($0 == nil)
            #expect($1 == nil)
        }
    }
}
