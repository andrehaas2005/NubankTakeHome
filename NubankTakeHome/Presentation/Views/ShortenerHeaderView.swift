import UIKit

final class ShortenerHeaderView: UIView {
  
  // MARK: - UI
  private let titleLabel = TitleLabel(textLabel: "Encurtar links")
  private let subtitleLabel: UILabel = {
    let label = UILabel()
    label.text = "Coloque o link que você quer encurtar"
    label.font = Theme.Typography.caption
    label.textColor = Theme.Colors.muted
    label.numberOfLines = 2
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    translatesAutoresizingMaskIntoConstraints = false
    setup()
  }
  
  // MARK: - Setup
  private func setup() {
    addSubview(titleLabel)
    addSubview(subtitleLabel)
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: topAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
      subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  // MARK: - Public API
  func configure(title: String? = nil, subtitle: String? = nil) {
    if let title = title { titleLabel.text = title }
    if let subtitle = subtitle { subtitleLabel.text = subtitle }
  }
}
