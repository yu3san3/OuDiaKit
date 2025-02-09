import Testing
@testable import OuDiaKit

struct EkiJikokuParserTests {
    @Test(
        "EkiJikoku のパースを検証",
        arguments: TestData.ekiJikokuPairs
    )
    func testParseEkiJikoku(with ekiJikokuPair: TestData.EkiJikokuPair) {
        let jikokuArray = EkiJikokuParser().parse(ekiJikokuPair.string)
        let expectedJikokuArray = ekiJikokuPair.object

        #expect(jikokuArray.count == expectedJikokuArray.count)

        zip(jikokuArray, expectedJikokuArray).forEach(assertJikokuEquality)
    }

    @Test(
        "EkiJikoku の各駅データのパースを検証",
        arguments: TestData.ekiJikokuRecordPairs
    )
    func testParseEkiJikokuRecord(with ekiJikokuRecordPair: TestData.EkiJikokuRecordPair) {
        let jikoku = EkiJikokuParser().parseRecord(ekiJikokuRecordPair.string)
        let expectedJikoku = ekiJikokuRecordPair.object

        assertJikokuEquality(jikoku, expectedJikoku)
    }

    private func assertJikokuEquality(_ jikoku: Jikoku, _ expected: Jikoku) {
        #expect(jikoku.arrivalStatus == expected.arrivalStatus)
        #expect(jikoku.chaku == expected.chaku)
        #expect(jikoku.hatsu == expected.hatsu)
    }
}
