//
//


import Foundation

public extension FixedWidthInteger {
    
    private var abs: Self {
        if self < 0 {
            return 0 - self
        } else {
            return self
        }
    }
    
    /// Returns a random number within the range [0, upperBound) using the
    /// Data.secureRandomData(length:) method. This implementation is
    /// modulo bias free.
    ///
    static func secureRandomNumber(upperBound: Self) -> Self {
        
        assert(upperBound != 0 && upperBound != Self.min, "Upper bound should not be zero or equal to the minimum possible value")
        
        var random: Self
        
        // To eliminate modulo bias, we must ensure range of possible random
        // numbers is evenly divisible by the upper bound. We do this by
        // trimming the excess remainder off the lower bound (0)
        //
        let min = (Self.min &- upperBound) % upperBound
        
        repeat {
            // get enough random bytes to fill UInt
            let data = Data.secureRandomData(length: UInt(MemoryLayout<Self>.size))
            
            // extract the UInt
            random = data.withUnsafeBytes { (pointer: UnsafeRawBufferPointer) -> Self in
                return pointer.bindMemory(to: Self.self).baseAddress!.pointee
            }
            
        } while random.abs < min
        
        return random % upperBound
    }
}

/// Extension for NSNumber so we can support ObjC
public extension NSNumber {
    @objc static func secureRandomNumber(upperBound: UInt32) -> UInt32 {
        return UInt32.secureRandomNumber(upperBound: upperBound)
    }
}

