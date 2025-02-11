public struct Rosen: Equatable, Sendable { // インデント数: 1
    public var rosenmei: String
    public var eki: [Eki]
    public var ressyasyubetsu: [Ressyasyubetsu]
    public var dia: [Dia]
    public var kitenJikoku: String
    public var diagramDgrYZahyouKyoriDefault: Int
    public var comment: String

    public init(
        rosenmei: String,
        eki: [Eki],
        ressyasyubetsu: [Ressyasyubetsu],
        dia: [Dia],
        kitenJikoku: String,
        diagramDgrYZahyouKyoriDefault: Int,
        comment: String
    ) {
        self.rosenmei = rosenmei
        self.eki = eki
        self.ressyasyubetsu = ressyasyubetsu
        self.dia = dia
        self.kitenJikoku = kitenJikoku
        self.diagramDgrYZahyouKyoriDefault = diagramDgrYZahyouKyoriDefault
        self.comment = comment
    }
}

extension Rosen: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.rosenmei = try container.decode(String.self, forKey: .rosenmei)
        self.eki = try container.decodeIfPresent([Eki].self, forKey: .eki) ?? []
        self.ressyasyubetsu = try container.decode([Ressyasyubetsu].self, forKey: .ressyasyubetsu)
        self.dia = try container.decodeIfPresent([Dia].self, forKey: .dia) ?? []
        self.kitenJikoku = try container.decode(String.self, forKey: .kitenJikoku)
        self.diagramDgrYZahyouKyoriDefault = try container
            .decodeIntFromString(forKey: .diagramDgrYZahyouKyoriDefault)
        self.comment = try container.decode(String.self, forKey: .comment)
    }
}
