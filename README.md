# `OuDiaKit`

OuDia形式の文字列を、Swiftで扱えるようにする機能を提供します。

## `OuDiaDiagram`構造体へのパース

OuDia形式の文字列を`OuDiaDiagram`構造体へパースします。

```swift
import OuDiaKit

let mockOuDiaText = """
FileType=OuDia.1.02
Rosen.
(中略)
.
FileTypeAppComment=OuDia Ver. 1.02.05
"""

let diagram = OuDiaDiagramParser().parse(mockOuDiaText)
```

## OuDia形式への文字列化

`OuDiaDiagram`構造体を、OuDia形式の文字列へ変換します。

```swift
import OuDiaKit

let diagram = OuDiaDiagram(
    fileType: "OuDia.1.02",
    rosen: <#Rosen#>,
    dispProp: <#DispProp#>,
    fileTypeAppComment: "OuDia Ver. 1.02.05"
)

let stringifyer = OuDiaDiagramStringifyer(fileTypeAppComment: "YourAppName Ver. 1.0.0")
let outputText = stringifyer.stringify(diagram)
```
