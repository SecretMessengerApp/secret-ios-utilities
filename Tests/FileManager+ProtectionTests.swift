//
//

import Foundation
import XCTest

class FileManagerProtectionTests: XCTestCase {
    
    var fileManager: FileManagerThatRecordsFileProtectionAttributes!
    
    override func setUp() {
        self.fileManager = FileManagerThatRecordsFileProtectionAttributes()
        self.wipeTestFolder()
    }
    
    override func tearDown() {
        self.fileManager = nil
        self.wipeTestFolder()
    }
}

// MARK: - Create and protect
extension FileManagerProtectionTests {
    
    func testThatItCreatesAndProtectedFolder() throws {
        
        // GIVEN
        XCTAssertFalse(FileManager.default.fileExists(atPath: self.testFolder.path))
        
        // WHEN
        self.fileManager.createAndProtectDirectory(at: self.testFolder)
        
        // THEN
        XCTAssertTrue(FileManager.default.fileExists(atPath: self.testFolder.path))
        XCTAssertTrue(try self.existingLocalURLIsExcludedFromBackup(self.testFolder))
        XCTAssertTrue(self.fileManager.isFileProtectedUntilFirstUnlock(self.testFolder))
    }
    
    func testThatItCreatesAndProtectsAnAlreadyExistingFolder() throws {
        
        // GIVEN
        try self.createTestFolder()
        
        // WHEN
        self.fileManager.createAndProtectDirectory(at: self.testFolder)
        
        // THEN
        XCTAssertTrue(try self.existingLocalURLIsExcludedFromBackup(self.testFolder))
        XCTAssertTrue(self.fileManager.isFileProtectedUntilFirstUnlock(self.testFolder))
    }
}

// MARK: - Backup exclusion
extension FileManagerProtectionTests {
    
    func testThatItCreatesAndExcludesAFolderFromBackup() throws {
        
        // GIVEN
        try self.createTestFolder()
        
        // WHEN
        try! self.testFolder.excludeFromBackup()
        
        // THEN
        XCTAssertTrue(try self.existingLocalURLIsExcludedFromBackup(self.testFolder))
    }
    
    func testThatItDetectsExcludedFromBackup() {
        
        // GIVEN
        self.fileManager.createAndProtectDirectory(at: self.testFolder)
        
        // THEN
        XCTAssertTrue(self.testFolder.isExcludedFromBackup)
    }
    
    func testThatEmptyFolderIsNotExcludedFromBackup() {
        XCTAssertFalse(self.testFolder.isExcludedFromBackup)
    }
    
    func testThatNonExcludedFolderIsNotExcludedFromBackup() throws {
        
        // GIVEN
        try self.createTestFolder()
        
        // THEN
        XCTAssertFalse(self.testFolder.isExcludedFromBackup)
    }
}

// MARK: - Protection until unlocked
extension FileManagerProtectionTests {
    
    func testThatItProtectsAFolder() throws {
        
        // GIVEN
        try self.createTestFolder()
        
        // WHEN
        self.fileManager.setProtectionUntilFirstUserAuthentication(self.testFolder)
        
        // THEN
        XCTAssertTrue(self.fileManager.isFileProtectedUntilFirstUnlock(self.testFolder))
    }
}

// MARK: - Helpers
extension FileManagerProtectionTests {
    
    func createTestFolder() throws {
        try self.fileManager.createDirectory(at: self.testFolder, withIntermediateDirectories: true)
    }
    
    var testFolder: URL {
        return URL(fileURLWithPath: NSTemporaryDirectory() + name)
    }
    
    func wipeTestFolder() {
        try? FileManager.default.removeItem(at: self.testFolder)
    }
    
    func existingLocalURLIsExcludedFromBackup(_ folder: URL) throws -> Bool {
        let values = try folder.resourceValues(forKeys: Set(arrayLiteral: .isExcludedFromBackupKey))
        return values.isExcludedFromBackup == true
    }
}

/// This helper class is needed as the default file system will not report the value
/// of the `FileAttributeKey.protectionKey` when reading file attributes
class FileManagerThatRecordsFileProtectionAttributes: FileManager {
    
    var recordedAttributes: [String: FileProtectionType] = [:]
    
    override func setAttributes(_ attributes: [FileAttributeKey : Any], ofItemAtPath path: String) throws {
        if let protectionType = attributes[FileAttributeKey.protectionKey] as? FileProtectionType {
            self.recordedAttributes[path] = protectionType
        }
        try super.setAttributes(attributes, ofItemAtPath: path)
    }
    
    func isFileProtectedUntilFirstUnlock(_ url: URL) -> Bool {
        return self.recordedAttributes[url.path] == FileProtectionType.completeUntilFirstUserAuthentication
    }
    
}
