//
//

import Foundation

public enum Result<T> {
    case success(T)
    case failure(Error)
}

public enum VoidResult {
    case success
    case failure(Error)
}

public extension Result {
    func map<U>(_ transform: (T) throws -> U) -> Result<U> {
        switch self {
        case .success(let value):
            do {
                return .success(try transform(value))
            } catch {
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}

public extension Result {
    var value: T? {
        guard case let .success(value) = self else { return nil }
        return value
    }
    
    var error: Error? {
        guard case let .failure(error) = self else { return nil }
        return error
    }
}

public extension VoidResult {
    init<T>(result: Result<T>) {
        switch result {
        case .success: self = .success
        case .failure(let error): self = .failure(error)
        }
    }
    
    init(error: Error?) {
        if let error = error {
            self = .failure(error)
        } else {
            self = .success
        }
    }
    
    var error: Error? {
        guard case let .failure(error) = self else { return nil }
        return error
    }
}
