import Foundation

protocol ImageDownloaderDelegateProtocol: AnyObject {
    func didFinishedDownloadingImage(imagedata: Data)
}


