//
//


import XCTest
import WireTesting
@testable import WireUtilities

final class NSManagedObjectContext_SwiftTests: XCTestCase {
    
    struct TestError: Error {}
    
    var sut: NSManagedObjectContext!
    
    override func setUp() {
      super.setUp()
        sut = ZMMockManagedObjectContextFactory.testManagedObjectContext(withConcurencyType: .privateQueueConcurrencyType)
        sut.createDispatchGroups()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testThatItWorksWithoutGroups() {
        // given
        let moc = ZMMockManagedObjectContextFactory.testManagedObjectContext(withConcurencyType: .privateQueueConcurrencyType)!
        // when & then
        moc.performGroupedAndWait { _ in }
    }
    
    func testThatItPassesSelfInTheClosure() {
        // when & then
        sut.performGroupedAndWait { [sut] moc in
            XCTAssertEqual(moc, sut)
        }
    }
    
    func testThatItReturnsNonOptionalValue() {
        // given
        let closure: () -> Int = {
            return 42
        }
        
        // when
        let result = sut.performGroupedAndWait { _ in
            closure()
        }
        
        // then
        XCTAssertEqual(result, 42)
    }
    
    func testThatItReturnsOptionalValue() {
        // given
        let closure: () -> Int? = {
            return nil
        }
        
        // when
        let result = sut.performGroupedAndWait { _ in
            closure()
        }
        
        // then
        XCTAssertNil(result)
    }
    
    func testThatItReturnsNonOptionalValue_Throwing() {
        // given
        let closure: () throws -> Int = {
            throw TestError()
        }
        
        do {
            // when
            try sut.performGroupedAndWait { _ in
                try closure()
            }
            XCTFail()
        } catch {
            // then
            XCTAssert(error is TestError)
        }
    }
    
    func testThatItReturnsOptionalValue_Throwing() {
        // given
        let closure: () throws -> Int? = {
            throw TestError()
        }
        
        do {
            // when
            try sut.performGroupedAndWait { _ in
                try closure()
            }
            XCTFail()
        } catch {
            // then
            XCTAssert(error is TestError)
        }
    }
}
