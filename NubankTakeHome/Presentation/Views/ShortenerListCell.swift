import UIKit
import Core

final class ShortenerListCell: UITableViewCell {
  
  // MARK: - UI
  private let cardView: UIView = {
    let v = UIView()
    v.backgroundColor = Theme.Colors.surface
    v.layer.cornerRadius = Theme.Radii.smallX
    v.layer.masksToBounds = true
    v.translatesAutoresizingMaskIntoConstraints = false
    return v
  }()
  
  private let aliasLabel = BodyLabel()
  private let shortUrlLabel = CaptionLabel()
  
  private let copyButton = SecondaryButton(type: .system)
  
  // MARK: - Callback
  var onCopy: ((String) -> Void)?
  
  private var shortUrl: String?
  
  // MARK: - Init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    aliasLabel.text = nil
    shortUrlLabel.text = nil
    shortUrl = nil
  }
  
  // MARK: - Setup
  private func setup() {
    backgroundColor = .clear
    selectionStyle = .none
    
    contentView.addSubview(cardView)
    cardView.addSubview(aliasLabel)
    cardView.addSubview(shortUrlLabel)
    cardView.addSubview(copyButton)
    
    NSLayoutConstraint.activate([
      cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Theme.Spacing.xs),
      cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Theme.Spacing.xs),
      cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Theme.Spacing.xs),
      cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Theme.Spacing.xs),
      
      aliasLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: Theme.Spacing.sm),
      aliasLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Theme.Spacing.sm),
      aliasLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -Theme.Spacing.sm),
      
      shortUrlLabel.topAnchor.constraint(equalTo: aliasLabel.bottomAnchor, constant: Theme.Spacing.xs),
      shortUrlLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Theme.Spacing.sm),
      shortUrlLabel.trailingAnchor.constraint(equalTo: copyButton.leadingAnchor, constant: -Theme.Spacing.sm),
      shortUrlLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -Theme.Spacing.xs),
      
      copyButton.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
      copyButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -Theme.Spacing.sm),
      copyButton.widthAnchor.constraint(equalToConstant: Theme.Spacing.xl),
      copyButton.heightAnchor.constraint(equalToConstant: Theme.Spacing.xl)
    ])
    
    copyButton.addTarget(self, action: #selector(didTapCopy), for: .touchUpInside)
  }
  
  // MARK: - Configure
  func configure(with model: AliasResponse) {
    aliasLabel.text = model.alias
    shortUrlLabel.text = model.links.short
    shortUrl = model.links.short
  }
  
  @objc private func didTapCopy() {
    guard let shortUrl else { return }
    UIPasteboard.general.string = shortUrl
    onCopy?(shortUrl)
  }
}
