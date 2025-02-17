import Testing
@testable import OuDiaKit

struct OuDiaDiagramParserTests {
    let diagram: OuDiaDiagram

    init() throws {
        let result = try OuDiaDiagramParser().parse(from: TestData.mockOuDiaText)

        diagram = try #require(result)
    }

    @Test("FileType の検証")
    func testFileTypeParsing() {
        #expect(diagram.fileType == "OuDia.1.02")
        #expect(diagram.fileTypeAppComment == "OuDia Ver. 1.02.05")
    }

    @Test("Route の検証")
    func testRouteParsing() {
        let route = diagram.route

        #expect(route.name == "名鉄名古屋本線")
        #expect(route.diagramBaseTime == "400")
        #expect(route.diagramDefaultDistance == 60)
    }

    @Test("Station の検証")
    func testStationParsing() {
        let stations = diagram.route.stations

        #expect(stations.count == 3)

        #expect(stations[0].name == "金山")
        #expect(stations[0].timeType == .upArrival)
        #expect(stations[0].scale == .major)

        #expect(stations[1].name == "山王")
        #expect(stations[1].timeType == .arrivalDeparture)
        #expect(stations[1].scale == .normal)

        #expect(stations[2].name == "名鉄名古屋")
        #expect(stations[2].timeType == .downArrival)
        #expect(stations[2].scale == .major)
    }

    @Test("TrainType の検証")
    func testTrainTypeParsing() {
        let trainTypes = diagram.route.trainTypes

        #expect(trainTypes.count == 2)

        #expect(trainTypes[0].name == "普通")

        #expect(trainTypes[1].name == "特別急行")
        #expect(trainTypes[1].shortName == "特急")
    }

    @Test("Timetable の検証")
    func testTimetableParsing() {
        let timetables = diagram.route.timetables

        #expect(timetables.count == 2)

        #expect(timetables[0].title == "平日")
        #expect(timetables[1].title == "休日")
    }

    @Test("Train の検証")
    func testTrainParsing() {
        let downTrains = diagram.route.timetables[0].down.trains

        #expect(downTrains.count == 2)

        #expect(downTrains[0].direction == .down)
        #expect(downTrains[0].type == 1)
        #expect(downTrains[0].number == "307")

        #expect(downTrains[1].direction == .down)
        #expect(downTrains[1].type == 0)
        #expect(downTrains[1].number == "1093")
    }

    @Test("DisplayProperty の検証")
    func testDisplayPropertyParsing() {
        let displayProperty = diagram.displayProperty

        #expect(displayProperty.timetableFonts.count == 8)

        #expect(displayProperty.timetableFonts[0] == "PointTextHeight=9;Facename=ＭＳ ゴシック")
        #expect(displayProperty.timetableFonts[1] == "PointTextHeight=9;Facename=ＭＳ ゴシック;Bold=1")
        #expect(displayProperty.timetableFonts[2] == "PointTextHeight=9;Facename=ＭＳ ゴシック;Itaric=1")
        #expect(displayProperty.timetableFonts[3] == "PointTextHeight=9;Facename=ＭＳ ゴシック;Bold=1;Itaric=1")

        #expect(displayProperty.diagramStationNameFont == "PointTextHeight=9;Facename=ＭＳ ゴシック")
        #expect(displayProperty.diagramTimeFont == "PointTextHeight=9;Facename=ＭＳ ゴシック")
        #expect(displayProperty.diagramTrainFont == "PointTextHeight=9;Facename=ＭＳ ゴシック")
        #expect(displayProperty.commentFont == "PointTextHeight=9;Facename=ＭＳ ゴシック")
    }
}
