import UIKit

extension Theme.Utils {
  
  static func applyShadow(_ view: UIView, type: (opacity: Float, radius: CGFloat, offset: CGSize)) {
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOpacity = type.opacity
    view.layer.shadowRadius = type.radius
    view.layer.shadowOffset = type.offset
    view.layer.masksToBounds = false
  }
  
  static func rounded(_ view: UIView, radius: CGFloat = Theme.Radii.medium) {
    view.layer.cornerRadius = radius
    view.layer.masksToBounds = true
  }
}
