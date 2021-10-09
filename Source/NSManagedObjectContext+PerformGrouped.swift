//
//

import Foundation
import CoreData

public extension NSManagedObjectContext {
    static private let timeout: TimeInterval = 10

    @discardableResult func performGroupedAndWait<T>(_ execute: @escaping (NSManagedObjectContext) -> T) -> T {
        var result: T!
        let groups = dispatchGroupContext?.enterAll(except: nil)
        let tp = ZMSTimePoint(interval: NSManagedObjectContext.timeout)
        
        performAndWait {
            tp?.resetTime()
            result = execute(self)
            groups.apply {
                dispatchGroupContext?.leave($0)
            }
            tp?.warnIfLongerThanInterval()
        }
        
        return result
    }
    
    @discardableResult func performGroupedAndWait<T>(_ execute: @escaping (NSManagedObjectContext) throws -> T) throws -> T {
        var result: T!
        var thrownError: Error?
        let groups = dispatchGroupContext?.enterAll(except: nil)
        let tp = ZMSTimePoint(interval: NSManagedObjectContext.timeout)
        
        performAndWait {
            do {
                tp?.resetTime()
                result = try execute(self)
                groups.apply {
                    dispatchGroupContext?.leave($0)
                }
                tp?.warnIfLongerThanInterval()
            } catch {
                thrownError = error
            }
        }
        
        if let error = thrownError {
            throw error
        } else {
            return result
        }
    }
}
