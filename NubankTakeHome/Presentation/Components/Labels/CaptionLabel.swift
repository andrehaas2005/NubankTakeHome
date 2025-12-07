import UIKit

final class CaptionLabel: UILabel {
  
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
    textColor = Theme.Colors.primary
    font = Theme.Typography.caption
    lineBreakMode = .byCharWrapping
    translatesAutoresizingMaskIntoConstraints = false
    numberOfLines = 0
  }
}
