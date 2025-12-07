import UIKit

final class ShortenerInputView: UIView {
  
  // MARK: - Callback
  /// Chamado quando o usuário toca no botão "Encurtar"
  var onShorten: ((String) -> Void)?
  
  // MARK: - UI
  private let card = CardView()
  
  private let textField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "https://exemplo.com"
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.autocapitalizationType = .none
    tf.keyboardType = .URL
    tf.clearButtonMode = .whileEditing
    tf.accessibilityIdentifier = "url_textfield"
    tf.font = Theme.Typography.body
    return tf
  }()
  
  private let button: PrimaryButton = {
    let btn = PrimaryButton(type: .system)
    btn.setTitle("Encurtar", for: .normal)
    btn.translatesAutoresizingMaskIntoConstraints = false
    btn.accessibilityIdentifier = "shorten_button"
    return btn
  }()
  
  private let activity: UIActivityIndicatorView = {
    let a = UIActivityIndicatorView(style: .medium)
    a.translatesAutoresizingMaskIntoConstraints = false
    a.hidesWhenStopped = true
    return a
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
    addSubview(card)
    card.translatesAutoresizingMaskIntoConstraints = false
    
    card.addSubview(textField)
    card.addSubview(button)
    card.addSubview(activity)
    
    NSLayoutConstraint.activate([
      card.topAnchor.constraint(equalTo: topAnchor),
      card.leadingAnchor.constraint(equalTo: leadingAnchor),
      card.trailingAnchor.constraint(equalTo: trailingAnchor),
      card.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      textField.topAnchor.constraint(equalTo: card.topAnchor, constant: Theme.Spacing.sm),
      textField.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: Theme.Spacing.sm),
      textField.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -110),
      textField.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -Theme.Spacing.sm),
      
      button.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
      button.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -Theme.Spacing.sm),
      button.widthAnchor.constraint(equalToConstant: 96),
      button.heightAnchor.constraint(equalToConstant: 44),
      
      activity.centerXAnchor.constraint(equalTo: button.centerXAnchor),
      activity.centerYAnchor.constraint(equalTo: button.centerYAnchor)
    ])
    
    button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
  }
  
  // MARK: - Actions
  @objc private func didTapButton() {
    let text = textField.text ?? ""
    onShorten?(text)
  }
  
  // MARK: - Public API
  func setLoading(_ loading: Bool) {
    if loading {
      button.isHidden = true
      activity.startAnimating()
    } else {
      button.isHidden = false
      activity.stopAnimating()
    }
  }
  
  func clearInput() {
    textField.text = ""
  }
}
