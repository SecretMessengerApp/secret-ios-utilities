//
//


import Foundation
import WireSystem

extension FileManager {
    
    /// Creates a new directory if needed, sets the file protection 
    /// to `completeUntilFirstUserAuthentication` and excludes the URL from backups
    public func createAndProtectDirectory(at url: URL) {
        
        if !fileExists(atPath: url.path) {
            do {
                try createDirectory(at: url, withIntermediateDirectories: true, attributes: [.posixPermissions: 0o700])
            }
            catch let error as NSError {
                // Only when building on simulator
                #if arch(i386) || arch(x86_64)
                if error.code == CocoaError.fileWriteUnknown.rawValue {
                    // This error happens when installing app build with iOS10 on iOS11 simulator
                    // Seems to be working fine on device or older iOS.
                    return
                }
                #endif

                fatal("Failed to create directory: \(url), error: \(error)")
            }
        }
        
        // Make sure it's not accessible until first unlock
        self.setProtectionUntilFirstUserAuthentication(url)
        
        // Make sure this is not backed up:
        try? url.excludeFromBackup()
    }

    /// Sets the protection to FileProtectionType.completeUntilFirstUserAuthentication
    public func setProtectionUntilFirstUserAuthentication(_ url: URL) {
        do {
            let attributes = [FileAttributeKey.protectionKey: FileProtectionType.completeUntilFirstUserAuthentication]
            try self.setAttributes(attributes, ofItemAtPath: url.path)
        }
        catch let error {
            fatal("Failed to set protection until first user authentication: \(url), error: \(error)")
        }
    }

}

public extension URL {
    
    /// Sets the resource value to exclude this entry from backups
    func excludeFromBackup() throws {
        var mutableCopy = self
        do {
            var resourceValues = URLResourceValues()
            resourceValues.isExcludedFromBackup = true
            try mutableCopy.setResourceValues(resourceValues)
        } catch let error {
            throw error
        }
    }
    
    func excludeFromBackupIfExists() throws {
        if FileManager.default.fileExists(atPath: path) {
            try excludeFromBackup()
        }
    }

    /// Returns whether the item is excluded from backups
    var isExcludedFromBackup : Bool {
        guard let values = try? resourceValues(forKeys: Set(arrayLiteral: .isExcludedFromBackupKey)) else { return false }
        return values.isExcludedFromBackup ?? false
    }

    static func directory(for searchPathDirectory: FileManager.SearchPathDirectory) -> URL {
        return URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(searchPathDirectory, .userDomainMask, true).first!)
    }
}
