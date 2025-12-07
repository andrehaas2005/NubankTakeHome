import UIKit

final class TitleLabel: UILabel {
  private var textLabel: String
  
  init(textLabel: String) {
    self.textLabel = textLabel
    super.init(frame: .zero)
    setup()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    text = textLabel
    textColor = Theme.Colors.text
    font = Theme.Typography.title
    translatesAutoresizingMaskIntoConstraints = false
    numberOfLines = 0
  }
}
