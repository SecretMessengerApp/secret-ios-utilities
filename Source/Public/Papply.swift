//
//

public func papply<A, B>(
    _ a2b: @escaping (A) -> B, _ a: A
    ) -> () -> B {
    return {
        a2b(a)
    }
}

public func papply<A, B, C>(
    _ ab2c: @escaping (A, B) -> C, _ a: A
    ) -> (B) -> C {
    return { b in
        ab2c(a, b)
    }
}

public func papply<A, B, C, D>(
    _ abc2d: @escaping (A, B, C) -> D, _ a: A
    ) -> (B, C) -> D {
    return { b, c in
        abc2d(a, b, c)
    }
}

public func papply<A, B, C, D, E>(
    _ abcd2e: @escaping (A, B, C, D) -> E, _ a: A
    ) -> (B, C, D) -> E {
    return { b, c, d in
        abcd2e(a, b, c, d)
    }
}

public func papply<A, B, C, D, E, F>(
    _ abcde2f: @escaping (A, B, C, D, E) -> F, _ a: A
    ) -> (B, C, D, E) -> F {
    return { b, c, d, e in
        abcde2f(a, b, c, d, e)
    }
}
