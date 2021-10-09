//
//

import XCTest
import WireUtilities

// MARK: Type Erased Scenario

protocol Message: class {
    associatedtype Content
    var content: Content { get set }
    var sender: String { get }
    var numberOfLikes: Int { get set }
}

class TextMessage: Message {
    var content: String
    let sender: String
    var numberOfLikes: Int = 0

    init(content: String, sender: String) {
        self.content = content
        self.sender = sender
    }
}

class ImageMessage: Message {
    var content: UIImage
    let sender: String
    var numberOfLikes: Int = 0

    init(content: UIImage, sender: String) {
        self.content = content
        self.sender = sender
    }
}

class AnyMessage {
    private let _sender: AnyConstantProperty<String>
    private let _numberOfLikes: AnyMutableProperty<Int>

    init<T: Message>(_ message: T) {
        _sender = AnyConstantProperty(message, keyPath: \.sender)
        _numberOfLikes = AnyMutableProperty(message, keyPath: \.numberOfLikes)
    }

    var sender: String {
        return _sender.getter()
    }

    var numberOfLikes: Int {
        get { return _numberOfLikes.getter() }
        set { _numberOfLikes.setter(newValue) }
    }
}

// MARK: - Tests

class AnyPropertyTests: XCTestCase {

    var textMessage: TextMessage!
    var imageMessage: ImageMessage!

    override func setUp() {
        super.setUp()
        textMessage = TextMessage(content: "Hello", sender: "User A")
        imageMessage = ImageMessage(content: UIImage(), sender: "User B")
    }

    override func tearDown() {
        textMessage = nil
        imageMessage = nil
        super.tearDown()
    }

    func testThatItCanReadConstantProperty() {
        // GIVEN
        let firstMessage = AnyMessage(textMessage)
        let lastMessage = AnyMessage(imageMessage)

        // THEN
        XCTAssertEqual(firstMessage.sender, textMessage.sender)
        XCTAssertEqual(lastMessage.sender, imageMessage.sender)
    }

    func testThatItCanReadMutableProperty() {
        // GIVEN
        let firstMessage = AnyMessage(textMessage)
        let lastMessage = AnyMessage(imageMessage)

        // THEN
        XCTAssertEqual(firstMessage.numberOfLikes, 0)
        XCTAssertEqual(lastMessage.numberOfLikes, 0)
    }

    func testThatItCanChangeMutableProperty() {
        // GIVEN
        let firstMessage = AnyMessage(textMessage)
        let lastMessage = AnyMessage(imageMessage)

        // WHEN
        firstMessage.numberOfLikes = 10
        lastMessage.numberOfLikes += 5

        // THEN
        XCTAssertEqual(firstMessage.numberOfLikes, 10)
        XCTAssertEqual(lastMessage.numberOfLikes, 5)
    }

}
