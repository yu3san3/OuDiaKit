import Testing
@testable import OuDiaKit

struct OuDiaDiagramStringifierTests {
    @Test("OuDiaDiagram の文字列化を検証")
    func testOuDiaDiagramStringify() throws {
        let string = OuDiaDiagramStringifyer().stringify(TestData.mockOuDiaDiagram)

        let splitedString = string.split(separator: "\n")
        let splitedExpectedString = TestData.mockOuDiaText.split(separator: "\n")

        zip(splitedString, splitedExpectedString).forEach {
            #expect($0 == $1)
        }
    }
}
