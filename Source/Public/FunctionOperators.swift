//
//

public prefix func !<T>(f: @escaping (T) -> Bool) -> (T) -> Bool {
    return { !f($0) }
}
