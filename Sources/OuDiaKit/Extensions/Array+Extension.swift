extension Array {
    func reversed(shouldReverse: Bool) -> [Element] {
        shouldReverse ? reversed() : self
    }
}
