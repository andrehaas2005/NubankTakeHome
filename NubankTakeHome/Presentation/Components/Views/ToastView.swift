import UIKit

final class ToastView: UIView {
  
  private let label = UILabel()
  private var hideTimer: Timer?
  
  init(message: String) {
    super.init(frame: .zero)
    setupUI(message: message)
  }
  
  required init?(coder: NSCoder) { fatalError() }
  
  private func setupUI(message: String) {
    backgroundColor = Theme.Colors.primary
    layer.cornerRadius = Theme.Radii.medium
    layer.masksToBounds = true
    
    label.text = message
    label.textColor = .white
    label.font = Theme.Typography.captionBold
    label.numberOfLines = 0
    
    addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: topAnchor, constant: Theme.Spacing.md),
      label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Theme.Spacing.md),
      label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.Spacing.md),
      label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Theme.Spacing.md),
    ])
    
    alpha = 0
    transform = CGAffineTransform(translationX: 0, y: Theme.Spacing.lg)
  }
  
  func show(in container: UIView) {
    container.addSubview(self)
    translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: Theme.Spacing.lg),
      trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -Theme.Spacing.lg),
      bottomAnchor.constraint(equalTo: container.safeAreaLayoutGuide.bottomAnchor, constant: -Theme.Spacing.lg)
    ])
    
    UIView.animate(withDuration: 0.25) {
      self.alpha = 1
      self.transform = .identity
    }
    
    hideTimer = Timer.scheduledTimer(withTimeInterval: 2.8, repeats: false) { [weak self] _ in
      self?.hide()
    }
  }
  
  func hide() {
    UIView.animate(withDuration: 0.25, animations: {
      self.alpha = 0
      self.transform = CGAffineTransform(translationX: 0, y: 20)
    }) { _ in
      self.removeFromSuperview()
    }
  }
}
