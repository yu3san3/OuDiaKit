import Testing
import SwiftUICore
@testable import OuDiaKit

struct OudColorCodeTests {
    typealias RGBAValue = (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat)
    typealias RGBColorSet = (color: Color, rgba: RGBAValue)
    typealias OudColorSet = (color: Color, oudColorCode: String)

    enum ColorCodeTestData {
        static let red = Color(red: 1, green: 0, blue: 0)
        static let green = Color(red: 0, green: 1, blue: 0)
        static let blue = Color(red: 0, green: 0, blue: 1)
        static let yellow = Color(red: 1, green: 1, blue: 0)


        static let oudColorSets: [OudColorSet] = [
            (red,    "000000FF"),
            (green,  "0000FF00"),
            (blue,   "00FF0000"),
            (yellow, "0000FFFF"),
        ]

        static let rgbColorSets: [RGBColorSet] = [
            (red,    (1.0, 0.0, 0.0, 1.0)),
            (green,  (0.0, 1.0, 0.0, 1.0)),
            (blue,   (0.0, 0.0, 1.0, 1.0)),
            (yellow, (1.0, 1.0, 0.0, 1.0)),
        ]
    }

    @Test(
        "oudColorCodeによって正しく初期化される。",
        arguments: ColorCodeTestData.oudColorSets
    )
    func initializeColorWithOudColorCode(with colorSet: OudColorSet) {
        let oudColorCode = colorSet.oudColorCode
        let color = Color(oudColorCode: oudColorCode)

        #expect(color == colorSet.color)
    }

    @Test(
        "oudColorCodeメソッドによって正しく16進色コードに変換される。",
        arguments: ColorCodeTestData.oudColorSets
    )
    func oudColorCodeMethod(with colorSet: OudColorSet) {
        let color = colorSet.color
        let oudColorCode = colorSet.oudColorCode

        #expect(color.oudColorCode() == oudColorCode)
    }

    @Test(
        "ColorのRGB値を正しく取得できる。",
        arguments: ColorCodeTestData.rgbColorSets
    )
    func canGetRGBValues(with colorSet: RGBColorSet) {
        let color = colorSet.color
        let rgba = colorSet.rgba

        let components = color.components

        #expect(components.red == rgba.r)
        #expect(components.green == rgba.g)
        #expect(components.blue == rgba.b)
        #expect(components.alpha == rgba.a)
    }
}
