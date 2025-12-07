import UIKit

extension Theme.Colors {
  
  // MARK: - Base
  static let background = UIColor(named: "Background") ?? UIColor.systemBackground
  static let surface = UIColor(named: "Surface") ?? UIColor.secondarySystemBackground
  
  // MARK: - Text
  static let text = UIColor(named: "TextPrimary") ?? UIColor.label
  static let muted = UIColor(named: "TextSecondary") ?? UIColor.secondaryLabel
  
  // MARK: - Brand
  static let primary = UIColor(named: "Primary") ?? UIColor.systemPurple
  static let primaryLight = UIColor(named: "PrimaryLight") ?? UIColor.systemPurple.withAlphaComponent(0.15)
  
  // MARK: - Feedback
  static let success = UIColor.systemGreen
  static let danger = UIColor.systemRed
  static let warning = UIColor.systemOrange
}
