import UIKit

final class SecondaryButton: UIButton {
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
    setup()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  private func setup() {
    setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
    tintColor = Theme.Colors.primary
    translatesAutoresizingMaskIntoConstraints = false
    
  }
}
