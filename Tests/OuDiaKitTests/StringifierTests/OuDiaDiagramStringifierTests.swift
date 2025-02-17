import Testing
@testable import OuDiaKit

struct OuDiaDiagramStringifierTests {
    @Test("OuDiaDiagram の文字列化を検証")
    func testOuDiaDiagramStringify() throws {
        let stringifier = OuDiaDiagramStringifier(fileTypeAppComment: nil)
        let string = stringifier.stringify(
            TestData.mockOuDiaDiagram
        )

        let splitedString = string.split(separator: "\n")
        let splitedExpectedString = TestData.mockOuDiaText.split(separator: "\n")

        zip(splitedString, splitedExpectedString).forEach {
            #expect($0 == $1)
        }
    }

    @Test("FileTypeAppComment が正しく書き換えられるか検証")
    func testOuDiaDiagramStringifyWithFileTypeAppComment() throws {
        let fileTypeAppComment = "MyWonderfulApp Ver.1.0.0"

        let stringifier = OuDiaDiagramStringifier(fileTypeAppComment: fileTypeAppComment)
        let string = stringifier.stringify(
            TestData.mockOuDiaDiagram
        )

        #expect(string.contains("FileTypeAppComment=\(fileTypeAppComment)"))
    }
}
