import Foundation

public final class OuDiaDiagramStringifyer {
    public func stringify(_ diagram: OuDiaDiagram) -> String {
        var lines = [String]()

        lines.append("FileType=\(diagram.fileType)")
        lines.append(contentsOf: stringifyRosen(diagram.rosen))
        lines.append(contentsOf: stringifyDispProp(diagram.dispProp))
        lines.append("FileTypeAppComment=\(diagram.fileTypeAppComment)")

        return lines.joined(separator: "\n")
    }

    private func stringifyRosen(_ rosen: Rosen) -> [String] {
        var lines = [String]()

        lines.append(contentsOf: [
            "Rosen.",
            "Rosenmei=\(rosen.rosenmei)"
        ])
        lines.append(
            contentsOf: rosen.eki // [Eki]
                .map(stringifyEki) // [[String]]
                .flatMap { $0 } // [String]
        )
        lines.append(
            contentsOf: rosen.ressyasyubetsu
                .map(stringifyRessyasyubetsu)
                .flatMap { $0 }
        )
        lines.append(
            contentsOf: rosen.dia
                .map(stringifyDia)
                .flatMap { $0 }
        )
        lines.append(contentsOf: [
            "KitenJikoku=\(rosen.kitenJikoku)",
            "DiagramDgrYZahyouKyoriDefault=\(rosen.diagramDgrYZahyouKyoriDefault)",
            "Comment=\(rosen.comment)",
            "."
        ])

        return lines
    }

    private func stringifyEki(_ eki: Eki) -> [String] {
        [
            "Eki.",
            "Ekimei=\(eki.ekimei)",
            "Ekijikokukeisiki=\(eki.ekijikokukeisiki.rawValue)",
            "Ekikibo=\(eki.ekikibo.rawValue)",
            ".",
        ]
    }

    private func stringifyRessyasyubetsu(_ ressyasyubetsu: Ressyasyubetsu) -> [String] {
        [
            "Ressyasyubetsu.",
            "Syubetsumei=\(ressyasyubetsu.syubetsumei)",
            ressyasyubetsu.ryakusyou.map { "Ryakusyou=\($0)" },
            "JikokuhyouMojiColor=\(ressyasyubetsu.jikokuhyouMojiColor.oudColorCode())",
            "JikokuhyouFontIndex=\(ressyasyubetsu.jikokuhyouFontIndex)",
            "DiagramSenColor=\(ressyasyubetsu.diagramSenColor.oudColorCode())",
            "DiagramSenStyle=\(ressyasyubetsu.diagramSenStyle.rawValue)",
            ressyasyubetsu.stopMarkDrawType.map { "StopMarkDrawType=\($0)" },
            "."
        ].compactMap { $0 }
    }

    private func stringifyDia(_ dia: Dia) -> [String] {
        var lines = [String]()

        lines.append(contentsOf: [
            "Dia.",
            "DiaName=\(dia.diaName)"
        ])
        lines.append(contentsOf: stringifyRessyaGroup("Kudari", dia.kudari.ressya))
        lines.append(contentsOf: stringifyRessyaGroup("Nobori", dia.nobori.ressya))
        lines.append(".")

        return lines
    }

    private func stringifyRessyaGroup(_ houkou: String, _ ressyas: [Ressya]) -> [String] {
        var lines = [String]()

        lines.append("\(houkou).")
        lines.append(contentsOf: ressyas
            .map(stringifyRessya)
            .flatMap { $0 }
        )
        lines.append(".")

        return lines
    }

    private func stringifyRessya(_ ressya: Ressya) -> [String] {
        [
            "Ressya.",
            "Houkou=\(ressya.houkou.rawValue)",
            "Syubetsu=\(ressya.syubetsu)",
            ressya.ressyabangou.map { "Ressyabangou=\($0)" },
            ressya.ressyamei.map { "Ressyamei=\($0)" },
            ressya.gousuu.map { "Gousuu=\($0)" },
            "EkiJikoku=\(EkiJikokuStringifyer().stringify(ressya.ekiJikoku))",
            "."
        ].compactMap { $0 }
    }

    private func stringifyDispProp(_ dispProp: DispProp) -> [String] {
        var lines = [String]()

        lines.append("DispProp.")
        lines.append(
            contentsOf: dispProp.jikokuhyouFont
                .map { "JikokuhyouFont=\($0)" }
        )
        lines.append(contentsOf: [
            "JikokuhyouVFont=\(dispProp.jikokuhyouVFont)",
            "DiaEkimeiFont=\(dispProp.diaEkimeiFont)",
            "DiaJikokuFont=\(dispProp.diaJikokuFont)",
            "DiaRessyaFont=\(dispProp.diaRessyaFont)",
            "CommentFont=\(dispProp.commentFont)",
            "DiaMojiColor=\(dispProp.diaMojiColor.oudColorCode())",
            "DiaHaikeiColor=\(dispProp.diaHaikeiColor.oudColorCode())",
            "DiaRessyaColor=\(dispProp.diaRessyaColor.oudColorCode())",
            "DiaJikuColor=\(dispProp.diaJikuColor.oudColorCode())",
            "EkimeiLength=\(dispProp.ekimeiLength)",
            "JikokuhyouRessyaWidth=\(dispProp.jikokuhyouRessyaWidth)",
            "."
        ])

        return lines
    }
}
