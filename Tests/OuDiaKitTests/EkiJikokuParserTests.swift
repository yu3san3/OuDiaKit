import Testing
@testable import OuDiaKit

struct EkiJikokuParserTests {
    typealias EkiJikokuSet = (string: String, object: Jikoku)

    enum EkiJikokuTestData {
        static let ekiJikokuSets: [EkiJikokuSet] = [
            ("",  Jikoku(arrivalStatus: .notOperate)),
            ("1", Jikoku(arrivalStatus: .stop)),
            ("2", Jikoku(arrivalStatus: .pass)),
            ("3", Jikoku(arrivalStatus: .notGoThrough)),
            ("1;900",      Jikoku(arrivalStatus: .stop, chaku: "",    hatsu: "900")),
            ("1;900/",     Jikoku(arrivalStatus: .stop, chaku: "900", hatsu: "")),
            ("1;900/1000", Jikoku(arrivalStatus: .stop, chaku: "900", hatsu: "1000")),
            ("2;1000",     Jikoku(arrivalStatus: .pass, chaku: "",    hatsu: "1000"))
        ]
    }

    @Test(
        "EkiJikoku の検証",
        arguments: EkiJikokuTestData.ekiJikokuSets
    )
    func testParseEkiJikoku(with ekiJikokuSet: EkiJikokuSet) {
        let jikoku = EkiJikokuParser().parseRecord(ekiJikokuSet.string)
        let expectedJikoku = ekiJikokuSet.object

        #expect(jikoku.arrivalStatus == expectedJikoku.arrivalStatus)
        #expect(jikoku.chaku == expectedJikoku.chaku)
        #expect(jikoku.hatsu == expectedJikoku.hatsu)
    }
}
