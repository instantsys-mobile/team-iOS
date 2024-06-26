import Foundation

class CommentsViewModel {
    var comments: [Comment]
    var onCommentAdded: ((Comment) -> Void)? 

    init(comments: [Comment]) {
        self.comments = comments
    }

    func addComment(_ comment: Comment) {
        comments.append(comment)
        onCommentAdded?(comment)
    }
}
