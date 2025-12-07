import UIKit

final class CardView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  private func setup() {
    backgroundColor = Theme.Colors.surface
    layer.cornerRadius = Theme.Radii.medium
    Theme.Utils.applyShadow(self, type: Theme.Shadows.micro)
  }
}
