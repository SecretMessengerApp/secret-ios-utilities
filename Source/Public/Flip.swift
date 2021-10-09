//
//

public func flip<A, B>(
    _ f: @escaping (A) -> B
    ) -> (A) -> B {
    return f
}

public func flip<A, B, C>(
    _ f: @escaping ((A, B)) -> C
    ) -> (B, A) -> C {
    return { b, a in
        f((a, b))
    }
}

public func flip<A, B, C, D>(
    _ f: @escaping ((A, B, C)) -> D
    ) -> (C, B, A) -> D {
    return { c, b, a in
        f((a, b, c))
    }
}

public func flip<A, B, C, D, E>(
    _ f: @escaping ((A, B, C, D)) -> E
    ) -> (D, C, B, A) -> E {
    return { d, c, b, a in
        f((a, b, c, d))
    }
}
