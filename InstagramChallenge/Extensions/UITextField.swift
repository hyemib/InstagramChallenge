
import UIKit

extension UITextField {
    func addLeftPaading() {
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        self.leftViewMode = .always
    }
}
