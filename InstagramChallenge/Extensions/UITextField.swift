
import UIKit

extension UITextField {
    func addLeftPaading(padding: Int) {
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: 0))
        self.leftViewMode = .always
    }
}
