
import FirebaseStorage

struct ImageUploader {
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        // this escaping closure would return us the image data after we get it
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {return}
        
        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_Image/\(fileName)")
        ref.putData(imageData, metadata: nil) { metadata, errorF in
            if errorF != nil {
                print("Debug")
                return
            }
            ref.downloadURL { url, error in
                guard let imageUrl = url?.absoluteString else {
                    return
                }
                completion(imageUrl)
            }
        }
    }
}
