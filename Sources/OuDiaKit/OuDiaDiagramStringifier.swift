import Foundation

public final class OuDiaDiagramStringifier {
    /// `FileTypeAppComment` を上書きするための文字列
    public let fileTypeAppComment: String?

    /// `OuDiaDiagramStringifier` のインスタンスを生成する。
    ///
    /// - Parameter fileTypeAppComment: 出力の `FileTypeAppComment` を、ここで指定した文字列で上書きする。
    ///
    /// - NOTE: 明示的に `nil` を渡して初期化すれば、もとの `FileTypeAppComment` の値を維持することも可能である。
    /// しかし、ファイルの生成元を保証するために、`nil` ではなく適切な値を指定するべき。
    ///
    /// ```swift
    /// let stringifier = OuDiaDiagramStringifier(fileTypeAppComment: "YourAppName Ver. 1.0.0") // ⭕️
    ///
    /// let stringifier = OuDiaDiagramStringifier(fileTypeAppComment: nil) // ❌ (非推奨)
    /// ```
    public init(fileTypeAppComment: String?) {
        self.fileTypeAppComment = fileTypeAppComment
    }

    /// `OuDiaDiagram` を文字列に変換する。
    ///
    /// - Parameter diagram: 文字列化する `OuDiaDiagram` オブジェクト
    /// - Returns: `OuDia` ファイルの文字列
    public func stringify(_ diagram: OuDiaDiagram) -> String {
        var lines = [String]()

        lines.append("FileType=\(diagram.fileType)")
        lines.append(contentsOf: stringifyRoute(diagram.route))
        lines.append(contentsOf: stringifyDisplayProperty(diagram.displayProperty))
        lines.append("FileTypeAppComment=\(fileTypeAppComment ?? diagram.fileTypeAppComment)")
        return lines.joined(separator: "\n")
    }

    private func stringifyRoute(_ route: Route) -> [String] {
        var lines = [String]()

        lines.append(contentsOf: [
            "Rosen.",
            "Rosenmei=\(route.name)"
        ])
        lines.append(
            contentsOf: route.stations // [Station]
                .map(stringifyStation) // [[String]]
                .flatMap { $0 } // [String]
        )
        lines.append(
            contentsOf: route.trainTypes
                .map(stringifyTrainType)
                .flatMap { $0 }
        )
        lines.append(
            contentsOf: route.timetables
                .map(stringifyTimetable)
                .flatMap { $0 }
        )
        lines.append(contentsOf: [
            "KitenJikoku=\(route.diagramBaseTime ?? "000")",
            "DiagramDgrYZahyouKyoriDefault=\(route.diagramDefaultDistance)",
            "Comment=\(route.comment)",
            "."
        ])

        return lines
    }

    private func stringifyStation(_ station: Station) -> [String] {
        [
            "Eki.",
            "Ekimei=\(station.name)",
            "Ekijikokukeisiki=\(station.timeType.rawValue)",
            "Ekikibo=\(station.scale.rawValue)",
            station.borderLine.map { "Kyoukaisen=\($0)" },
            station.downTrainInfoDisplayStyle.map { "DiagramRessyajouhouHyoujiKudari=\($0.rawValue)" },
            station.upTrainInfoDisplayStyle.map { "DiagramRessyajouhouHyoujiNobori=\($0.rawValue)" },
            ".",
        ].compactMap { $0 }
    }

    private func stringifyTrainType(_ trainType: TrainType) -> [String] {
        [
            "Ressyasyubetsu.",
            "Syubetsumei=\(trainType.name)",
            trainType.shortName.map { "Ryakusyou=\($0)" },
            "JikokuhyouMojiColor=\(trainType.timetableTextColor.oudColorCode())",
            "JikokuhyouFontIndex=\(trainType.timetableFontIndex)",
            "DiagramSenColor=\(trainType.diagramLineColor.oudColorCode())",
            "DiagramSenStyle=\(trainType.diagramLineStyle.rawValue)",
            trainType.isDiagramLineBold.map { "DiagramSenIsBold=\($0)" },
            trainType.stopMarkDrawType.map { "StopMarkDrawType=\($0)" },
            "."
        ].compactMap { $0 }
    }

    private func stringifyTimetable(_ timetable: Timetable) -> [String] {
        var lines = [String]()

        lines.append(contentsOf: [
            "Dia.",
            "DiaName=\(timetable.title)"
        ])
        lines.append(contentsOf: stringifyTrainGroup("Kudari", timetable.down.trains))
        lines.append(contentsOf: stringifyTrainGroup("Nobori", timetable.up.trains))
        lines.append(".")

        return lines
    }

    private func stringifyTrainGroup(_ direction: String, _ trains: [Train]) -> [String] {
        var lines = [String]()

        lines.append("\(direction).")
        lines.append(
            contentsOf: trains
                .map(stringifyTrain)
                .flatMap { $0 }
        )
        lines.append(".")

        return lines
    }

    private func stringifyTrain(_ train: Train) -> [String] {
        [
            "Ressya.",
            "Houkou=\(train.direction.rawValue)",
            "Syubetsu=\(train.type)",
            train.number.map { "Ressyabangou=\($0)" },
            train.name.map { "Ressyamei=\($0)" },
            train.suffixNumber.map { "Gousuu=\($0)" },
            "EkiJikoku=\(ScheduleStringifier().stringify(train.schedule))",
            "."
        ].compactMap { $0 }
    }

    private func stringifyDisplayProperty(_ displayProperty: DisplayProperty) -> [String] {
        var lines = [String]()

        lines.append("DispProp.")
        lines.append(
            contentsOf: displayProperty.timetableFonts
                .map { "JikokuhyouFont=\($0)" }
        )
        lines.append(contentsOf: [
            "JikokuhyouVFont=\(displayProperty.timetableVerticalFont)",
            "DiaEkimeiFont=\(displayProperty.diagramStationNameFont)",
            "DiaJikokuFont=\(displayProperty.diagramTimeFont)",
            "DiaRessyaFont=\(displayProperty.diagramTrainFont)",
            "CommentFont=\(displayProperty.commentFont)",
            "DiaMojiColor=\(displayProperty.diagramTextColor.oudColorCode())",
            "DiaHaikeiColor=\(displayProperty.diagramBackgroundColor.oudColorCode())",
            "DiaRessyaColor=\(displayProperty.diagramTrainColor.oudColorCode())",
            "DiaJikuColor=\(displayProperty.diagramGridLineColor.oudColorCode())",
            "EkimeiLength=\(displayProperty.stationNameLength)",
            "JikokuhyouRessyaWidth=\(displayProperty.timetableTrainWidth)",
            "."
        ])

        return lines
    }
}
