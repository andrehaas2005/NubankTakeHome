import UIKit
import Core

final class ShortenerListView: UIView {
  
  // MARK: - UI
  let tableView: UITableView = {
    let tv = UITableView(frame: .zero, style: .insetGrouped)
    tv.translatesAutoresizingMaskIntoConstraints = false
    tv.backgroundColor = .clear
    tv.separatorStyle = .none
    return tv
  }()
  
  private let emptyLabel: UILabel = {
    let l = UILabel()
    l.text = "Nenhum link encurtado ainda"
    l.font = Theme.Typography.body
    l.textColor = Theme.Colors.muted
    l.textAlignment = .center
    l.translatesAutoresizingMaskIntoConstraints = false
    return l
  }()
  
  // MARK: - Lifecycle
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
    addSubview(tableView)
    addSubview(emptyLabel)
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: topAnchor),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      emptyLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      emptyLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }
  
  // MARK: - Public API
  func setEmptyState(_ isEmpty: Bool) {
    emptyLabel.isHidden = !isEmpty
    tableView.isHidden = isEmpty
  }
}
