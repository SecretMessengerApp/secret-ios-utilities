//
//


extension Optional {

    /// Like map, but intended to be used to perform side effects.
    /// Basically what `forEach` on `Collection` is compared to `map`, but for `Optional`.
    /// - parameter block: The closure to be executed in case self holds a value.
    public func apply(_ block: (Wrapped) -> Void) {
        if case .some(let unwrapped) = self {
            block(unwrapped)
        }
    }
    
}
