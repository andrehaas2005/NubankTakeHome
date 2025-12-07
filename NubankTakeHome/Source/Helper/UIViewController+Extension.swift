import UIKit

extension UIViewController {
    func showToast(_ message: String) {
        let toast = ToastView(message: message)
        toast.show(in: view)
    }
}
