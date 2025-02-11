import SwiftUI

#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

extension Color {
    /// 16進数の色コード (AABBGGRR形式) から `Color` を生成するイニシャライザ。
    ///
    /// - Parameters:
    ///   - oudColorCode: 8桁の16進色コード (AABBGGRR形式)。先頭2桁が透明度、続く6桁がRGB値を表す。
    ///   - ignoresAlpha: `true` の場合、透明度を無視し、不透明 (`opacity = 1`) として初期化する (デフォルト: `true`)。
    ///
    /// 文字列の長さが **8桁** でない場合、デフォルトで `Color.primary` を返す。
    /// `ignoresAlpha` を `true` にすると、透明度を無視してRGB値のみを参照する。
    /// OuDiaでは、色の記述順が`RGBA`ではなく`ABGR`のように逆順であるため注意すること。
    public init(oudColorCode: String, ignoresAlpha: Bool = true) {
        guard oudColorCode.count == 8 else {
            self = .primary
            return
        }

        let redStr = oudColorCode.suffix(2)
        let greenStr = oudColorCode.prefix(6).suffix(2)
        let blueStr = oudColorCode.prefix(4).suffix(2)
        let alphaStr = oudColorCode.prefix(2)

        let red = Double(Int(redStr, radix: 16) ?? 0) / 255
        let green = Double(Int(greenStr, radix: 16) ?? 0) / 255
        let blue = Double(Int(blueStr, radix: 16) ?? 0) / 255
        let alpha = Double(Int(alphaStr, radix: 16) ?? 0) / 255

        self.init(red: red, green: green, blue: blue, opacity: ignoresAlpha ? 1 : alpha)
    }

    /// `Color` の RGBA 成分を取得するプロパティ。
    ///
    /// - Returns: `(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)` のタプル。
    ///
    /// `Color` から `NativeColor` (`UIColor` / `NSColor`) に変換し、
    /// `sRGB` カラースペースで正確な RGBA 成分を取得する。
    /// `Color.gray` のようなシステム定義色でも、`sRGB` に統一される。
    /// 取得できない場合、デフォルトの `(0, 0, 0, 1)` (黒) を返す。
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        #if canImport(UIKit)
        typealias NativeColor = UIColor
        #elseif canImport(AppKit)
        typealias NativeColor = NSColor
        #endif

        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        guard
            let _ = NativeColor(self)
                .usingColorSpace(.sRGB)?
                .getRed(&r, green: &g, blue: &b, alpha: &a)
        else {
            return (0, 0, 0, 1)
        }

        return (r, g, b, a)
    }

    /// `Color` を ABGR (AABBGGRR) 形式の16進数文字列に変換する。
    ///
    /// - Parameters:
    ///   - ignoresAlpha: `true` の場合、透明度 (`AA`) を `00` に固定する (デフォルト: `true`)。
    ///
    /// - Returns: `Color` の RGBA 値を **ABGR (AABBGGRR)** の順番で表した16進数文字列。
    ///
    /// - 使用例:
    ///   ```swift
    ///   let color = Color.red.opacity(0.5)
    ///   print(color.oudColorCode()) // "80FF0000" (A:80, B:FF, G:00, R:00)
    ///   print(color.oudColorCode(ignoresAlpha: false)) // 透明度を保持
    ///   ```
    public func oudColorCode(ignoresAlpha: Bool = true) -> String {
        let (r, g, b, a) = components

        let red = Int(r * 255)
        let green = Int(g * 255)
        let blue = Int(b * 255)
        let alpha = Int(a * 255)

        // AABBGGRR の順番で16進数に変換
        return String(
            format: "%02X%02X%02X%02X",
            ignoresAlpha ? 0 : alpha,
            blue,
            green,
            red
        )
    }
}

// MARK: - Codable

extension Color: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let colorCode = try container.decode(String.self)
        self.init(oudColorCode: colorCode)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(oudColorCode())
    }
}
