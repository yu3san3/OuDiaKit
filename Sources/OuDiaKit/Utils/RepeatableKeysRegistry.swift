class RepeatableKeysRegistry {
    private var keys: Set<String> = [
        "Eki",
        "Ressyasyubetsu",
        "Dia",
        "Ressya",
        "JikokuhyouFont"
    ]

    func addKeys(_ keys: Set<String>) {
        self.keys.formUnion(keys)
    }

    /// 反復可能なキー要素を取得する。
    func getKeys() -> Set<String> {
        return keys
    }
}
