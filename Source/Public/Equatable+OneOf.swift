//
//

public extension Equatable {
    func isOne(of others: Self...) -> Bool {
        return isOne(of: others)
    }
    
    func isOne<T: Collection>(of others: T) -> Bool where T.Element == Self {
        return others.contains(self)
    }
}
