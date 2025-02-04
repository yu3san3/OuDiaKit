import Testing
import Foundation
@testable import OuDiaKit

@Test func parse() {
    do {
        let result = OuDiaJSONConverter().convertToJSON(mockOudText)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromUpperCamelCase
        let object = try decoder.decode(DiagramDataJSON.self, from: result!)
        #expect(object != nil)
    } catch {
        Issue.record(error)
    }
}

let mockOudText = """
FileType=OuDia.1.02
Rosen.
Rosenmei=
Eki.
Ekimei=豊橋
Ekijikokukeisiki=Jikokukeisiki_NoboriChaku
Ekikibo=Ekikibo_Syuyou
.
Eki.
Ekimei=船町
Ekijikokukeisiki=Jikokukeisiki_Hatsuchaku
Ekikibo=Ekikibo_Ippan
.
Eki.
Ekimei=下地
Ekijikokukeisiki=Jikokukeisiki_Hatsuchaku
Ekikibo=Ekikibo_Ippan
.
Eki.
Ekimei=小坂井
Ekijikokukeisiki=Jikokukeisiki_Hatsuchaku
Ekikibo=Ekikibo_Ippan
.
Eki.
Ekimei=牛久保
Ekijikokukeisiki=Jikokukeisiki_Hatsuchaku
Ekikibo=Ekikibo_Ippan
.
Eki.
Ekimei=豊川
Ekijikokukeisiki=Jikokukeisiki_KudariChaku
Ekikibo=Ekikibo_Syuyou
.
Ressyasyubetsu.
Syubetsumei=普通
Ryakusyou=普通
JikokuhyouMojiColor=00000000
JikokuhyouFontIndex=0
DiagramSenColor=00000000
DiagramSenStyle=SenStyle_Jissen
StopMarkDrawType=EStopMarkDrawType_DrawOnStop
.
Dia.
DiaName=平日
Kudari.
Ressya.
Houkou=Kudari
Syubetsu=0
Ressyabangou=437M
Ressyamei=
Gousuu=
EkiJikoku=1;1557,1;1559/1600,1;1601/1602,1;1605/1606,1;1608/1609,1;1613/
.
Ressya.
Houkou=Kudari
Syubetsu=0
Ressyabangou=537G
Ressyamei=
Gousuu=
EkiJikoku=1;1612,2;,2;,1;1617/1618,1;1621/1622,1;1624/
.
Ressya.
Houkou=Kudari
Syubetsu=0
Ressyabangou=439G
Ressyamei=
Gousuu=
EkiJikoku=1;1627,1;1629/1630,1;1631/1632,1;1635/1636,1;1638/1639,1;1642/
.
Ressya.
Houkou=Kudari
Syubetsu=0
Ressyabangou=539M
Ressyamei=
Gousuu=
EkiJikoku=1;1642,2;,2;,1;1647/1648,1;1651/1652,1;1654/
.
Ressya.
Houkou=Kudari
Syubetsu=0
Ressyabangou=441G
Ressyamei=
Gousuu=
EkiJikoku=1;1657,1;1659/1700,1;1701/1702,1;1705/1706,1;1708/1709,1;1713/
.
Ressya.
Houkou=Kudari
Syubetsu=0
Ressyabangou=
Ressyamei=
Gousuu=
EkiJikoku=3
.
Ressya.
Houkou=Kudari
Syubetsu=0
Ressyabangou=
Ressyamei=
Gousuu=
EkiJikoku=3
.
.
Nobori.
Ressya.
Houkou=Nobori
Syubetsu=0
Ressyabangou=438G
Ressyamei=
Gousuu=
EkiJikoku=1;1549,1;1551/1552,1;1554/1555,1;1557/1558,1;1559/1600,1;1603/
.
Ressya.
Houkou=Nobori
Syubetsu=0
Ressyabangou=544M
Ressyamei=
Gousuu=
EkiJikoku=1;1603,1;1606/1607,1;1609/1610,2;,2;,1;1616/
.
Ressya.
Houkou=Nobori
Syubetsu=0
Ressyabangou=440M
Ressyamei=
Gousuu=
EkiJikoku=1;1618,1;1621/1622,1;1624/1625,1;1628/1629,1;1630/1631,1;1634/
.
Ressya.
Houkou=Nobori
Syubetsu=0
Ressyabangou=546G
Ressyamei=
Gousuu=
EkiJikoku=1;1634,1;1636/1637,1;1639/1640,2;,2;,1;1646/
.
Ressya.
Houkou=Nobori
Syubetsu=0
Ressyabangou=442G
Ressyamei=
Gousuu=
EkiJikoku=1;1649,1;1651/1652,1;1655/1656,1;1659/1659,1;1701/1702,1;1705/
.
Ressya.
Houkou=Nobori
Syubetsu=0
Ressyabangou=
Ressyamei=
Gousuu=
EkiJikoku=3
.
Ressya.
Houkou=Nobori
Syubetsu=0
Ressyabangou=
Ressyamei=
Gousuu=
EkiJikoku=3
.
.
.
Dia.
DiaName=休日
Kudari.
Ressya.
Houkou=Kudari
Syubetsu=0
Ressyabangou=437M
Ressyamei=
Gousuu=
EkiJikoku=1;1557,1;1559/1600,1;1601/1602,1;1605/1606,1;1608/1609,1;1613/
.
.
Nobori.
Ressya.
Houkou=Nobori
Syubetsu=0
Ressyabangou=438G
Ressyamei=
Gousuu=
EkiJikoku=1;1549,1;1551/1552,1;1554/1555,1;1557/1558,1;1559/1600,1;1603/
.
.
.
KitenJikoku=000
DiagramDgrYZahyouKyoriDefault=60
Comment=
.
DispProp.
JikokuhyouFont=PointTextHeight=9;Facename=ＭＳ ゴシック
JikokuhyouFont=PointTextHeight=9;Facename=ＭＳ ゴシック;Bold=1
JikokuhyouFont=PointTextHeight=9;Facename=ＭＳ ゴシック
JikokuhyouFont=PointTextHeight=9;Facename=ＭＳ ゴシック;Bold=1
JikokuhyouFont=PointTextHeight=9;Facename=ＭＳ ゴシック
JikokuhyouFont=PointTextHeight=9;Facename=ＭＳ ゴシック
JikokuhyouFont=PointTextHeight=9;Facename=ＭＳ ゴシック
JikokuhyouFont=PointTextHeight=9;Facename=ＭＳ ゴシック
JikokuhyouVFont=PointTextHeight=9;Facename=@ＭＳ ゴシック
DiaEkimeiFont=PointTextHeight=9;Facename=ＭＳ ゴシック
DiaJikokuFont=PointTextHeight=9;Facename=ＭＳ ゴシック
CommentFont=PointTextHeight=9;Facename=ＭＳ ゴシック
DiaRessyaFont=PointTextHeight=9;Facename=ＭＳ ゴシック
DiaMojiColor=00000000
DiaHaikeiColor=00000000
DiaRessyaColor=00FFFFFF
DiaJikuColor=00000000
EkimeiLength=6
JikokuhyouRessyaWidth=5
.
FileTypeAppComment=CloudDia v0.4.3
"""
