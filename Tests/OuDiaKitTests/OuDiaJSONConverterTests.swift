import Testing
import Foundation
@testable import OuDiaKit

struct OuDiaJSONConverterTests {
    let jsonObject: [String: Any]

    init() throws {
        let jsonData = try OuDiaJSONConverter().convertToJSON(TestData.mockOuDiaText)
        let jsonDictionary = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any]

        jsonObject = try #require(jsonDictionary)
    }

    @Test("FileType の検証")
    func testFileTypeParsing() throws {
        let fileType: String = try getValue(for: "FileType")
        let fileTypeAppComment: String = try getValue(for: "FileTypeAppComment")

        #expect(fileType == "OuDia.1.02")
        #expect(fileTypeAppComment == "OuDia Ver. 1.02.05")
    }

    @Test("Rosen の検証")
    func testRosenParsing() throws {
        let rosenmei: String = try getNestedValue(for: "Rosen.Rosenmei")

        #expect(rosenmei == "名鉄名古屋本線")
    }

    @Test("Eki の検証")
    func testEkiParsing() throws {
        let ekiArray: [[String: Any]] = try getNestedValue(for: "Rosen.Eki")

        #expect(ekiArray.count == 3)

        #expect(ekiArray[0]["Ekimei"] as? String == "金山")
        #expect(ekiArray[0]["Ekijikokukeisiki"] as? String == "Jikokukeisiki_NoboriChaku")
        #expect(ekiArray[0]["Ekikibo"] as? String == "Ekikibo_Syuyou")

        #expect(ekiArray[1]["Ekimei"] as? String == "山王")
        #expect(ekiArray[1]["Ekijikokukeisiki"] as? String == "Jikokukeisiki_Hatsuchaku")
        #expect(ekiArray[1]["Ekikibo"] as? String == "Ekikibo_Ippan")

        #expect(ekiArray[2]["Ekimei"] as? String == "名鉄名古屋")
        #expect(ekiArray[2]["Ekijikokukeisiki"] as? String == "Jikokukeisiki_KudariChaku")
        #expect(ekiArray[2]["Ekikibo"] as? String == "Ekikibo_Syuyou")
    }

    @Test("Ressyasyubetsu の検証")
    func testRessyasyubetsuParsing() throws {
        let ressyasyubetsuArray: [[String: Any]] = try getNestedValue(for: "Rosen.Ressyasyubetsu")

        #expect(ressyasyubetsuArray.count == 2)

        #expect(ressyasyubetsuArray[0]["Syubetsumei"] as? String == "普通")
        #expect(ressyasyubetsuArray[0]["JikokuhyouMojiColor"] as? String == "00000000")

        #expect(ressyasyubetsuArray[1]["Syubetsumei"] as? String == "特別急行")
        #expect(ressyasyubetsuArray[1]["JikokuhyouMojiColor"] as? String == "000000FF")
    }

    @Test("Dia の検証")
    func testDiaParsing() throws {
        let diaArray: [[String: Any]] = try getNestedValue(for: "Rosen.Dia")

        #expect(diaArray.count == 2)
        #expect(diaArray[0]["DiaName"] as? String == "平日")
        #expect(diaArray[1]["DiaName"] as? String == "休日")
    }

    @Test("Ressya の検証")
    func testRessyaParsing() throws {
        let diaArray: [[String: Any]] = try getNestedValue(for: "Rosen.Dia")
        let kudariRessyaArray: [[String: Any]] = try getNestedValue(diaArray[0], for: "Kudari.Ressya")

        #expect(kudariRessyaArray.count == 2)

        #expect(kudariRessyaArray[0]["Ressyabangou"] as? String == "307")
        #expect(kudariRessyaArray[0]["Syubetsu"] as? String == "1")

        #expect(kudariRessyaArray[1]["Ressyabangou"] as? String == "1093")
        #expect(kudariRessyaArray[1]["Syubetsu"] as? String == "0")
    }

    @Test("DispProp の検証")
    func testDispPropParsing() throws {
        let dispProp: [String: Any] = try getValue(for: "DispProp")

        #expect(dispProp["DiaMojiColor"] as? String == "00000000")
        #expect(dispProp["DiaHaikeiColor"] as? String == "00FFFFFF")
        #expect(dispProp["DiaJikuColor"] as? String == "00C0C0C0")

        let jikokuhyouFontArray: [String] = try #require(dispProp["JikokuhyouFont"] as? [String])

        #expect(jikokuhyouFontArray.count == 8)

        #expect(jikokuhyouFontArray[0] == "PointTextHeight=9;Facename=ＭＳ ゴシック")
        #expect(jikokuhyouFontArray[1] == "PointTextHeight=9;Facename=ＭＳ ゴシック;Bold=1")
    }

    // MARK: Helper Methods

    private func getValue<T>(for key: String) throws -> T {
        return try #require(jsonObject[key] as? T)
    }

    private func getNestedValue<T>(_ object: Any? = nil, for keyPath: String) throws -> T {
        let keys = keyPath.split(separator: ".").map(String.init)

        var current: Any? = object == nil ? jsonObject : object
        for key in keys {
            current = (current as? [String: Any])?[key]
        }

        return try #require(current as? T)
    }
}
