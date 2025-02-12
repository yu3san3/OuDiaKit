# `OuDiaDiagramStringifier`

`OuDiaDiagram` 構造体を OuDia 形式の文字列へ変換する。

## 宣言

```swift
import OuDiaKit

public final class OuDiaDiagramStringifier
```

## 概要

`OuDiaDiagram`構造体を、OuDia形式の文字列へ変換します。

```swift
import OuDiaKit

let diagram = OuDiaDiagram(
    fileType: "OuDia.1.02",
    route: <#Route#>,
    displayProperty: <#DisplayProperty#>,
    fileTypeAppComment: "OuDia Ver. 1.02.05"
)

let stringifier = OuDiaDiagramStringifier(fileTypeAppComment: "YourAppName Ver. 1.0.0")
let outputText = stringifier.stringify(diagram)
```
