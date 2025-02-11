# `OuDiaDiagramParser`

OuDia形式の文字列を`OuDiaDiagram`構造体へパースする。

## 宣言

```swift
import OuDiaKit

final public class OuDiaDiagramParser
```

## 概要

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

`OuDiaDiagramParser`は、内部でOuDia形式のテキストデータをJSONに変換し、そのJSONを`Decodable`に準拠した型にデコードすることで、OuDiaのデータを構造化されたオブジェクトとして扱えるようにします。
