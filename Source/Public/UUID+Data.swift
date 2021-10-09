//
//

import Foundation

public extension UUID {
    
    /// return a Data representation of this UUID
    var uuidData: Data {
        return withUnsafeBytes(of: uuid, Data.init(_:))
    }
    
    
    /// Create an UUID from Data. Fails when Data is not in valid format
    ///
    /// - Parameter data: a data with count = 16.
    init?(data: Data) {
        guard data.count == 16 else { return nil }
        
        self.init(uuid: (data[0],
                         data[1],
                         data[2],
                         data[3],
                         data[4],
                         data[5],
                         data[6],
                         data[7],
                         data[8],
                         data[9],
                         data[10],
                         data[11],
                         data[12],
                         data[13],
                         data[14],
                         data[15]))
    }
}
