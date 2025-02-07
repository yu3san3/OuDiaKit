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

    @Test("Rosen の検証")
    func testRosenParsing() {
        let rosen = diagram.rosen

        #expect(rosen.rosenmei == "名鉄名古屋本線")
        #expect(rosen.kitenJikoku == "400")
        #expect(rosen.diagramDgrYZahyouKyoriDefault == 60)
    }

    @Test("EKi の検証")
    func testEkiParsing() {
        let ekiArray = diagram.rosen.eki

        #expect(ekiArray.count == 3)

        #expect(ekiArray[0].ekimei == "金山")
        #expect(ekiArray[0].ekijikokukeisiki == .noboriChaku)
        #expect(ekiArray[0].ekikibo == .syuyou)

        #expect(ekiArray[1].ekimei == "山王")
        #expect(ekiArray[1].ekijikokukeisiki == .hatsuchaku)
        #expect(ekiArray[1].ekikibo == .ippan)

        #expect(ekiArray[2].ekimei == "名鉄名古屋")
        #expect(ekiArray[2].ekijikokukeisiki == .kudariChaku)
        #expect(ekiArray[2].ekikibo == .syuyou)
    }

    @Test("Ressyasyubetsu の検証")
    func testRessyasyubetsuParsing() {
        let ressyasyubetsuArray = diagram.rosen.ressyasyubetsu

        #expect(ressyasyubetsuArray.count == 2)

        #expect(ressyasyubetsuArray[0].syubetsumei == "普通")

        #expect(ressyasyubetsuArray[1].syubetsumei == "特別急行")
        #expect(ressyasyubetsuArray[1].ryakusyou == "特急")
    }

    @Test("Dia の検証")
    func testDiaParsing() {
        let diaArray = diagram.rosen.dia

        #expect(diaArray.count == 2)

        #expect(diaArray[0].diaName == "平日")
        #expect(diaArray[1].diaName == "休日")
    }

    @Test("Ressya の検証")
    func testRessyaParsing() {
        let kudariRessyaArray = diagram.rosen.dia[0].kudari.ressya

        #expect(kudariRessyaArray.count == 2)

        #expect(kudariRessyaArray[0].houkou == .kudari)
        #expect(kudariRessyaArray[0].syubetsu == 1)
        #expect(kudariRessyaArray[0].ressyabangou == "307")

        #expect(kudariRessyaArray[1].houkou == .kudari)
        #expect(kudariRessyaArray[1].syubetsu == 0)
        #expect(kudariRessyaArray[1].ressyabangou == "1093")
    }

    @Test("DispProp の検証")
    func testDispPropParsing() {
        let dispProp = diagram.dispProp

        #expect(dispProp.jikokuhyouFont.count == 8)

        #expect(dispProp.jikokuhyouFont[0] == "PointTextHeight=9;Facename=ＭＳ ゴシック")
        #expect(dispProp.jikokuhyouFont[1] == "PointTextHeight=9;Facename=ＭＳ ゴシック;Bold=1")
        #expect(dispProp.jikokuhyouFont[2] == "PointTextHeight=9;Facename=ＭＳ ゴシック;Itaric=1")
        #expect(dispProp.jikokuhyouFont[3] == "PointTextHeight=9;Facename=ＭＳ ゴシック;Bold=1;Itaric=1")

        #expect(dispProp.diaEkimeiFont == "PointTextHeight=9;Facename=ＭＳ ゴシック")
        #expect(dispProp.diaJikokuFont == "PointTextHeight=9;Facename=ＭＳ ゴシック")
        #expect(dispProp.diaRessyaFont == "PointTextHeight=9;Facename=ＭＳ ゴシック")
        #expect(dispProp.commentFont == "PointTextHeight=9;Facename=ＭＳ ゴシック")
    }
}
