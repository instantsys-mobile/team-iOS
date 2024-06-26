/* Task: Implement a simple messaging system.
 1. Define an enum MessageType to represent different types of messages (e.g., text, image, video).
 2. Create a protocol MessageContent with a property content of type String to represent the actual content of the message.
 3. Define a class Message with properties for sender, receiver, timestamp, type (using MessageType), and content (conforming to MessageContent protocol) and instance methods like printMessageDetails, etc.
 4. Use property wrappers to validate message content and make sure it's not empty, if empty provide default value.
 5. Use lazy properties for computing timestamps only when needed.
 6. Implement inheritance by creating subclasses of Message for different message types (e.g., TextMessage, ImageMessage, VideoMessage).
 7. Override methods and properties as needed in subclasses.
 8. Use property observers to update timestamps when messages are sent.
 9. Implement designated, convenience, and default initializers for Message and its subclasses.
 10. Implement the deinitializer for Message and all it's subclasses and print a message when it is deallocated.
 11. Create a structure Chat to represent a conversation between two users. It should have properties for user1, user2, an array of messages and a id which is unique for every chat and a sendMessage function to append the messages. // we could have used UUID
 12. Define an extension for Chat to add a method for sending a specific type of message.
 13. Use high-order functions and closures to filter and manipulate messages and provide methods like update message, delete message and search message by providing the keyword.
 14. Implement read-only and computed properties to calculate statistics on messages (e.g., message count, average message length).
 15. Implement a class ChatManager with properties for storing multiple chats, archived chats and a delegate for all chats operations.
 16. Add methods to ChatManager for showing all chats, showing archived chats, adding chats, removing chats, and updating chats. Use the delegation pattern to delegate all the operations to ChatOperation Class expect for displaying chats.
 17. Implement type methods to perform actions on chat (e.g., archiving, unarchiving).
 18. Define subscripting to access messages in a chat by index.
 19. Implement optional chaining and optional handling where appropriate. */

import Foundation

// 1. Define an enum MessageType to represent different types of messages.
enum MessageType {
    case text
    case image
    case video
}

// 2. Create a protocol MessageContent with a property content of type String.
protocol MessageContent {
    var content: String { get } // Read only property as we have a getter only
}

// 4. Property wrapper to validate message content.

@propertyWrapper
struct ValidateContent {
    var wrappedValue: String { // Observer property
        didSet {
            if wrappedValue.isEmpty {
                wrappedValue = "No content"
            }
        }
    }

    init() {
        self.wrappedValue = "No content"
    }
}
// 3. Define a class Message with properties and methods.
class Message {
    var sender: String
    var receiver: String
    // Lazy properties get initialized only when are accessed first
    lazy var timestamp: Date = { // Date has been accessed from File pkg
        return Date()
    }() // This timestamp has been created with closure type
    var type: MessageType //From Enum we will do this
    var content: MessageContent // Message content is our Protocol acting as a type



    @ValidateContent var validContent: String
    // Designated Initialzier of this class

    init(sender: String, receiver: String, type: MessageType, content: MessageContent) {
        self.sender = sender
        self.receiver = receiver
        self.type = type
        self.content = content
        self.validContent = content.content
    }

    //Instance Method is printMessageDetails
    func printMessageDetails() {
        print("From: \(sender), To: \(receiver), Content: \(validContent), Sent at: \(timestamp)")
    }

    // 10. Deinitializer
    deinit {
        print("Message from \(sender) to \(receiver) is being deallocated.")
    }
}

// 6. Implement inheritance by creating subclasses of Message for different message types.
class TextMessage: Message {
    // Properties

    //    TextMessage(sender: sender, receiver: receiver, type: .text, content: TextContent(content: content))


    // Initializers
    init(receiver: String, sender: String,type: MessageType ,content: TextContent) {

        super.init(sender: sender, receiver: receiver, type: .text, content: content)
    }


    // Deinitializer
    deinit {
        print("TextMessage deallocated")
    }

    // Overridden method
    override func printMessageDetails() {
        print("Video Message - \(validContent)")
    }
}
class ImageMessage: Message {
    // Properties
    var imageURL: URL

    // Initializers
    init(receiver: String, sender: String, content: String, imageURL: URL) {
        self.imageURL = imageURL
        super.init(sender: sender, receiver: receiver, type: .image, content: content as! MessageContent)
    }

    // Convenience Initializer
    convenience init(receiver: String, sender: String, imageURL: URL) {
        self.init(receiver: receiver, sender: sender, content: "", imageURL: imageURL)
    }

    // Deinitializer
    deinit {
        print("ImageMessage deallocated")
    }

    // Overridden method
    override func printMessageDetails() {
        print("Video Message - \(validContent)")
    }
}

class VideoMessage: Message {
    // Properties
    var videoURL: URL

    // Initializers
    init(receiver: String, sender: String, content: String, videoURL: URL) {
        self.videoURL = videoURL
        super.init(sender: sender, receiver: receiver, type: .video, content: content as! MessageContent)
    }

    // Convenience Initializer
    convenience init(receiver: String, sender: String, videoURL: URL) {
        self.init(receiver: receiver, sender: sender, content: "", videoURL: videoURL)
    }


    // Deinitializer
    deinit {
        print("VideoMessage deallocated")
    }

    // Overridden method
    override func printMessageDetails() {
        print("Video Message - \(validContent)")
    }
}


// These are the inheritances

// 11. Create a structure Chat to represent a conversation between two users.
class Chat {
    var user1: String
    var user2: String
    var id: String

    init(user1: String, user2: String, id: String) {
        self.user1 = user1
        self.user2 = user2
        self.id = id
        self.messages = []
    }

    // Property observer on messages
    var messages: [Message] {
        didSet {
            messages.last?.timestamp = Date()
        }
    }

    func sendMessage(_ message: Message) {
        messages.append(message)
//        print(messages)
    }
}


// 12. Define an extension for Chat to add a method for sending a specific type of message.
extension Chat {
    func sendTextMessage(content: String, sender: String, receiver: String) {
        let textMessage = TextMessage(receiver: receiver,
                                      sender: sender,
                                      type: .text,
                                      content: TextContent(content: content))
        sendMessage(textMessage)
    }
}

// 13. Use high-order functions and closures to filter and manipulate messages.
extension Chat {

//    func deleteMessage(at index: Int) {
//        guard index < messages.count else { return }
//        messages.remove(at: index)
//    }
    func deleteMessage(byKeyword keyword: String){
        guard var index = messages.firstIndex(where: { $0.validContent.contains(keyword) }) else { return }
       
        messages.remove(at: index)
    }
    
 
    
    

    

    func searchMessage(byKeyword keyword: String) -> [Message] {
        return messages.filter { $0.validContent.contains(keyword) }
    }
}

extension Chat {
    func updateMessage(byKeyword keyword: String, newContent: String) {
        guard let index = messages.firstIndex(where: {
            $0.content.content.contains(keyword) }) else { return }
       
        messages[index].validContent = newContent
    }
}

// 14. Implement read-only and computed properties.
extension Chat {
    var messageCount: Int {
        return messages.count
    }
    
    var averageMessageLength: Double {
        for data in messages {
            print(data.content.content)
        }
        guard messages.count != 0 else { return 0 }
        
        let totalLength = messages.reduce(0) { $0 + $1.content.content.count }
        return Double(totalLength) / Double(messages.count)
    }
    
}




class ChatManager {
    var archivedChats: [Chat] = []
    var delegate: ChatOperation?

    func showAllChats() {
        delegate?.showAllChats()
    }

    func removeChat(withId id: String) {
        delegate?.removeChat(withId: id)
    }

    func addChat(_ chat: Chat) {
        delegate?.addChat(chat)
    }
    
    func countChats(){
        delegate?.countChats()
    }

    func archiveChat(chat: Chat) {
        archivedChats.append(chat)
        removeChat(withId: chat.id)
    }


    func unarchiveChat(withId id: String) { //Command + click
        guard let index = archivedChats.firstIndex(where: { $0.id == id }) else { return }
        let chat = archivedChats.remove(at: index)
        print("\(archivedChats) - data")
        addChat(chat)
    }
}


// 18. Define subscripting to access messages in a chat by index.
extension Chat { // using subscripting
    subscript(index: Int) -> Message? {
        get {
            guard index < messages.count else { return nil } // We have made use of guard to check for any condition and if its not correct then return immediately else we would move forward in code
            return messages[index]
        }
        set {// Here we checked 2 things i.e. whether newValue is nil or not and if index< messages.count
            guard let newValue = newValue, index < messages.count else { return }
            messages[index] = newValue
        }
    }
}

// 19. Implement optional chaining and optional handling where appropriate.
protocol ChatOperation: AnyObject {
    var chats: [Chat] { get }
    func performOperation()
    func addChat(_ chat: Chat)
    func removeChat(withId id: String)
    func showAllChats() 
    func countChats()// In protocol we have just declared the operation
}

// Conforming to MessageContent protocol
struct TextContent: MessageContent {
    var content: String
}

// Implementing ChatManager and delegate
class ChatDelegate: ChatOperation {
   

    var chats: [Chat] = [] // Initialize the chats array
    func performOperation() {
        print("Performing a chat operation.")
    }
    
    func countChats() {
        print(chats.count)
    }

    func addChat(_ chat: Chat) {
        chats.append(chat)
    }

    func removeChat(withId id: String) {
        chats.removeAll { $0.id == id }
    }
    
   


    func showAllChats(){
        for chat in chats {
            print("User1:", chat.user1)
            print("User2:", chat.user2)
            print("Messages:")
            for message in chat.messages {
                print(message.content.content, message.timestamp)
            }
            print("\n")

            // Add a newline for readability
        }
        // Return the chats after printing them
    }
}

var manager = ChatManager()
manager.delegate = ChatDelegate() // Set the delegate
// First we would create chats
var chat = Chat(user1: "Alice", user2: "Bob", id: "chat1")

let textMessage = TextMessage(receiver: "r", sender: "s", type: .text, content: TextContent(content: "Hello Bob"))

let textMessage2 = TextMessage(receiver: "r", sender: "s", type: .text, content: TextContent(content: "Hello Alice reply"))

chat.sendTextMessage(content: textMessage.validContent, sender: "Alice", receiver: "Bob")

chat.sendTextMessage(content: textMessage2.validContent, sender: "Alice", receiver: "Bob")

var chat2 = Chat(user1: "A", user2: "B", id: "chat2")

let textMessage3 = TextMessage(receiver: "r", sender: "s", type: .text, content: TextContent(content: "Hello B"))

let textMessage4 = TextMessage(receiver: "r", sender: "s", type: .text, content: TextContent(content: "Hello A reply"))

chat2.sendTextMessage(content: textMessage3.validContent, sender: "s", receiver: "r")

chat2.sendTextMessage(content: textMessage4.validContent, sender: "s", receiver: "r")







var chat3 = Chat(user1: "E", user2: "F", id: "chat3")

    // F sending to E
let textMessage5 = TextMessage(receiver: "E", sender: "F", type: .text, content: TextContent(content: "Hello E"))

// E sending to F
let textMessage6 = TextMessage(receiver: "F", sender: "E", type: .text, content: TextContent(content: "Hey F"))

chat3.sendTextMessage(content: textMessage5.validContent, sender: "Alice", receiver: "Bob")

chat3.sendTextMessage(content: textMessage6.validContent, sender: "Alice", receiver: "Bob")





manager.addChat(chat)
manager.addChat(chat2)
manager.addChat(chat3)











// We have used the wrapper fn here to check the validity of text


// Add chats

print("Printing the Data")
print(manager.showAllChats())

print(manager.countChats())


print("\(chat.messages[0].content.content) has been accessed through subscripting")

print(chat.messages.count)
print(chat.averageMessageLength)

chat.deleteMessage(byKeyword: "Hello")


print("\(chat.messages[0].validContent) has been accessed through subscripting")

manager.archiveChat(chat: chat2)

print("Here is archived pattern: ")

var data = manager.archivedChats

print("Total Chats: ")
manager.countChats()

for element in data {
    print( element.user1, element.user2, element.id )
}



manager.unarchiveChat(withId: "chat2")


print("Total Chats: ")
manager.countChats()


print("Here is archived pattern now: ")



data = manager.archivedChats

for element in data {
    print( element.user1, element.user2, element.id )
}


