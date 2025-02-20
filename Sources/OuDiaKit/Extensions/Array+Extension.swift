extension Array {
    /// 条件に基づいて、逆順の配列を得る。
    public func reversed(shouldReverse: Bool) -> [Element] {
        shouldReverse ? reversed() : self
    }
}
