import Testing
@testable import OuDiaKit

struct EkiJikokuStringifierTests {
    @Test(
        "EkiJikoku の文字列化を検証",
        arguments: TestData.ekiJikokuPairs
    )
    func testStringifyEkiJikoku(with ekiJikokuSet: TestData.EkiJikokuPair) {
        let string = EkiJikokuStringifyer().stringify(ekiJikokuSet.object)
        let expectedJikokuString = ekiJikokuSet.string

        #expect(string == expectedJikokuString)
    }

    @Test(
        "EkiJikoku の各駅データの文字列化を検証",
        arguments: TestData.ekiJikokuRecordPairs
    )
    func testStringifyEkiJikokuRecord(with ekiJikokuRecordSet: TestData.EkiJikokuRecordPair) {
        let string = EkiJikokuStringifyer().stringifyRecord(ekiJikokuRecordSet.object)
        let expectedJikokuString = ekiJikokuRecordSet.string

        #expect(string == expectedJikokuString)
    }
}
