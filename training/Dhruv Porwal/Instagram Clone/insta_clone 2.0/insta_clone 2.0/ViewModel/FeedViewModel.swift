import UIKit

protocol FeedViewModelDelegateProtocol: AnyObject {
    func dataUpdated()
    func showCommentViewController(chatViewModel: CommentsViewModel)
}

class FeedViewModel { // Developer Class
    
    weak var feedViewModelDelegate: FeedViewModelDelegateProtocol?
    
    var posts: [Post] = []
    
    var numberOfPosts: Int {
        return posts.count
    }
    
    var numberOfStories: Int {
        return stories.count
    }
    
    func post(at index: Int) -> Post {
        return posts[index]
    }
    
    var stories: [Story] = [] // Array to hold Story objects
    
    // Method to fetch stories from a server or local storage
    func fetchStories() {
        let storyOwner = Story(imageName: "profilePic", caption: "", duration: 8.0, timestamp: Date())
        
        let story1 = Story(imageName: "profile_1", caption: "Fun day at the beach!", duration: 10.0, timestamp: Date())
        let story2 = Story(imageName: "profile_2", caption: nil, duration: 8.0, timestamp: Date())
        let story3 = Story(imageName: "img2skyscraper", caption: nil, duration: 8.0, timestamp: Date())
        let story4 = Story(imageName: "pup", caption: nil, duration: 8.0, timestamp: Date())
        stories = [storyOwner, story1, story2, story3, story4]
    }
    // Example method to retrieve a specific story at an index
    func story(at index: Int) -> Story {
        return stories[index]
    }
    
    func createDummyData() {
        // Create dummy users
        let user1 = User(username: "user1", profilePhoto: UIImage(named: "skyscraper")!, updatedStatus: true)
        let user2 = User(username: "user2", profilePhoto: UIImage(named: "skyscraper")!, updatedStatus: false)
        let user3 = User(username: "user3", profilePhoto: UIImage(named: "img2skyscraper")!, updatedStatus: false)
        let user4 = User(username: "user4", profilePhoto: UIImage(named: "img2skyscraper")!, updatedStatus: false)
        
        // Create dummy comments
        let comment1 = Comment(user: user1, text: "Great post!")
        let comment2 = Comment(user: user2, text: "Awesome!")
        
        let comment3 = Comment(user: user1, text: "Great View!")
        let comment4 = Comment(user: user2, text: "Wish I was there!")
        
        let comment5 = Comment(user: user3, text: "Amazing")
        let comment6 = Comment(user: user4, text: "Amazing Vibes")
        
        let comment7 = Comment(user: user3, text: "Yeh! new Movie")
        let comment8 = Comment(user: user1, text: "Aww, so cute")
        
        let comment9 = Comment(user: user3, text: "Amazing")
        let comment10 = Comment(user: user4, text: "Amazing Vibes")
        
        // Create dummy posts
        let post1 = Post(user: user1, postImage: UIImage(named: "profile_3")!, likes: 20, comments: [comment1, comment2], caption: "Beautiful scenery", tag: "Promoted")
        let post2 = Post(user: user2, postImage: UIImage(named: "img2skyscraper")!, likes: 15, comments: [comment3, comment4], caption: "Fun day at the beach", tag: "Suggested for you")
        let post3 = Post(user: user3, postImage: UIImage(named: "profile_1")!, likes: 55, comments: [comment5, comment6], caption: "Beautiful scenery", tag: "Dubai")
        let post4 = Post(user: user4, postImage: UIImage(named: "skyscraper")!, likes: 34, comments: [comment5, comment6, comment4, comment2], caption: "Fun day at the beach", tag: "Song name")
        let post5 = Post(user: user1, postImage: UIImage(named: "pup")!, likes: 32, comments: [comment8, comment6], caption: "Cute 'n' little pup", tag: "Sponsored")
        let post6 = Post(user: user2, postImage: UIImage(named: "venom")!, likes: 73, comments: [comment7, comment6], caption: "Marvel is back with a new movie", tag: "Suggested for you")
        
        // Add posts to the array
        posts = [post1, post2, post3, post4, post5, post6]
        
        // Notify delegate after data is created
        feedViewModelDelegate?.dataUpdated()
    }
    func toggleLike(at index: Int) {
        guard index < posts.count else { return }
        posts[index].isLiked.toggle()
        if posts[index].isLiked {
            posts[index].likes += 1
        } else {
            posts[index].likes -= 1
        }
        // Optionally, you can notify the view controller or any observers here
    }
    
    func shareButton(at index: Int) {
        print("Share Button Pressed")
      
    }
    
//    func tapComment(at index: Int) {
//        guard index < posts.count else { return }
//        let post = posts[index]
//        let chatViewModel = CommentsViewModel(comments: post.comments)
//        
//        
//        feedViewModelDelegate?.showCommentViewController(chatViewModel: chatViewModel)
//        
//    }
    
    func updatePostComments(at index: Int, with comment: Comment) {
          guard index < posts.count else { return }
          posts[index].comments.append(comment)
          feedViewModelDelegate?.dataUpdated()
      }

      func tapComment(at index: Int) {
          guard index < posts.count else { return }
          let post = posts[index]
          let chatViewModel = CommentsViewModel(comments: post.comments)
          
          chatViewModel.onCommentAdded = { [weak self]
              comment in
              self?.updatePostComments(at: index, with: comment)
          }
          
          feedViewModelDelegate?.showCommentViewController(chatViewModel: chatViewModel)
      }
}

extension UIViewController {
    func findParentViewController() -> UIViewController? {
        var parentResponder: UIResponder? = self
        while let responder = parentResponder {
            if let viewController = responder as? UIViewController {
                return viewController
            }
            parentResponder = responder.next
        }
        return nil
    }
}

