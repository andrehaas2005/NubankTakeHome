import UIKit

final class PrimaryButton: UIButton {
  
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
    backgroundColor = Theme.Colors.primary
    setTitleColor(.white, for: .normal)
    titleLabel?.font = Theme.Typography.bodyBold
    layer.cornerRadius = Theme.Radii.medium
    clipsToBounds = true
    
    heightAnchor.constraint(equalToConstant: 48).isActive = true
  }
  
  func setEnabled(_ enabled: Bool) {
    isEnabled = enabled
    alpha = enabled ? 1 : 0.5
  }
}
