import UIKit

final class BodyLabel: UILabel {
  
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
    textColor = Theme.Colors.text
    font = Theme.Typography.bodyBold
    translatesAutoresizingMaskIntoConstraints = false
    numberOfLines = 0
  }
}
