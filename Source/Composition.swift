//
//

import Foundation

/// Function composition operator: (f1 ∘ f2)(x) = f1(f2(x))
infix operator >>> : AdditionPrecedence
public func >>> <A, B, C>(f: @escaping (B) -> C, g: @escaping (A) -> B) -> (A) -> C {
    return { x in f(g(x)) }
}
