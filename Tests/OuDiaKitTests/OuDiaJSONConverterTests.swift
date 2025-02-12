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

    @Test("Route の検証")
    func testRouteParsing() throws {
        let routeName: String = try getNestedValue(for: "Rosen.Rosenmei")

        #expect(routeName == "名鉄名古屋本線")
    }

    @Test("Station の検証")
    func testStationParsing() throws {
        let stations: [[String: Any]] = try getNestedValue(for: "Rosen.Eki")

        #expect(stations.count == 3)

        #expect(stations[0]["Ekimei"] as? String == "金山")
        #expect(stations[0]["Ekijikokukeisiki"] as? String == "Jikokukeisiki_NoboriChaku")
        #expect(stations[0]["Ekikibo"] as? String == "Ekikibo_Syuyou")

        #expect(stations[1]["Ekimei"] as? String == "山王")
        #expect(stations[1]["Ekijikokukeisiki"] as? String == "Jikokukeisiki_Hatsuchaku")
        #expect(stations[1]["Ekikibo"] as? String == "Ekikibo_Ippan")

        #expect(stations[2]["Ekimei"] as? String == "名鉄名古屋")
        #expect(stations[2]["Ekijikokukeisiki"] as? String == "Jikokukeisiki_KudariChaku")
        #expect(stations[2]["Ekikibo"] as? String == "Ekikibo_Syuyou")
    }

    @Test("TrainType の検証")
    func testTrainTypeParsing() throws {
        let trainTypes: [[String: Any]] = try getNestedValue(for: "Rosen.Ressyasyubetsu")

        #expect(trainTypes.count == 2)

        #expect(trainTypes[0]["Syubetsumei"] as? String == "普通")
        #expect(trainTypes[0]["JikokuhyouMojiColor"] as? String == "00000000")

        #expect(trainTypes[1]["Syubetsumei"] as? String == "特別急行")
        #expect(trainTypes[1]["JikokuhyouMojiColor"] as? String == "000000FF")
    }

    @Test("Timetable の検証")
    func testTimetableParsing() throws {
        let timetables: [[String: Any]] = try getNestedValue(for: "Rosen.Dia")

        #expect(timetables.count == 2)
        #expect(timetables[0]["DiaName"] as? String == "平日")
        #expect(timetables[1]["DiaName"] as? String == "休日")
    }

    @Test("Train の検証")
    func testTrainParsing() throws {
        let timetables: [[String: Any]] = try getNestedValue(for: "Rosen.Dia")
        let downTrains: [[String: Any]] = try getNestedValue(timetables[0], for: "Kudari.Ressya")

        #expect(downTrains.count == 2)

        #expect(downTrains[0]["Ressyabangou"] as? String == "307")
        #expect(downTrains[0]["Syubetsu"] as? String == "1")

        #expect(downTrains[1]["Ressyabangou"] as? String == "1093")
        #expect(downTrains[1]["Syubetsu"] as? String == "0")
    }

    @Test("DisplayProperty の検証")
    func testDisplayPropertyParsing() throws {
        let displayProperty: [String: Any] = try getValue(for: "DispProp")

        #expect(displayProperty["DiaMojiColor"] as? String == "00000000")
        #expect(displayProperty["DiaHaikeiColor"] as? String == "00FFFFFF")
        #expect(displayProperty["DiaJikuColor"] as? String == "00C0C0C0")

        let timetableFonts: [String] = try #require(displayProperty["JikokuhyouFont"] as? [String])

        #expect(timetableFonts.count == 8)

        #expect(timetableFonts[0] == "PointTextHeight=9;Facename=ＭＳ ゴシック")
        #expect(timetableFonts[1] == "PointTextHeight=9;Facename=ＭＳ ゴシック;Bold=1")
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
