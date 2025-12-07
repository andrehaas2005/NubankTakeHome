import UIKit
import Combine
import Core

final class ShortenerViewController: UIViewController {
  
  // MARK: - Dependencies
  private let viewModel: ShortenerViewModel
  private var cancellables = Set<AnyCancellable>()
  
  // MARK: - UI
  private let headerView = ShortenerHeaderView()
  private let inputViewDS = ShortenerInputView()
  private let listView = ShortenerListView()
  
  // MARK: - Init
  init(viewModel: ShortenerViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    title = "Encurtador"
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = Theme.Colors.background
    setupLayout()
    setupBindings()
    setupInteractions()
  }
  
  // MARK: - Layout
  private func setupLayout() {
    view.addSubview(headerView)
    view.addSubview(inputViewDS)
    view.addSubview(listView)
    
    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Theme.Spacing.md),
      headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Theme.Spacing.md),
      headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Theme.Spacing.md),
      
      inputViewDS.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Theme.Spacing.md),
      inputViewDS.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Theme.Spacing.md),
      inputViewDS.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Theme.Spacing.md),
      
      listView.topAnchor.constraint(equalTo: inputViewDS.bottomAnchor, constant: Theme.Spacing.lg),
      listView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      listView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      listView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    
    // Table setup
    listView.tableView.register(ShortenerListCell.self, forCellReuseIdentifier: "ShortenerListCell")
    listView.tableView.dataSource = self
    listView.tableView.delegate = self
  }
  
  // MARK: - Bindings
  private func setupBindings() {
    
    // Links
    viewModel.$links
      .receive(on: RunLoop.main)
      .sink { [weak self] links in
        guard let self else { return }
        self.listView.setEmptyState(links.isEmpty)
        self.listView.tableView.reloadData()
      }
      .store(in: &cancellables)
    
    // Loading state
    viewModel.$isLoading
      .receive(on: RunLoop.main)
      .sink { [weak self] loading in
        self?.inputViewDS.setLoading(loading)
      }
      .store(in: &cancellables)
    
    // Error
    viewModel.$errorMessage
      .receive(on: RunLoop.main)
      .sink { [weak self] message in
        guard let message else { return }
        self?.presentError(message)
      }
      .store(in: &cancellables)
  }
  
  // MARK: - Interactions
  private func setupInteractions() {
    inputViewDS.onShorten = { [weak self] text in
      guard let self else { return }
      Task { await self.viewModel.shorten(text) }
    }
  }
  
  // MARK: - Error presentation
  private func presentError(_ message: String) {
    let alert = UIAlertController(title: "Ops", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    present(alert, animated: true)
  }
}

// MARK: - UITableView DataSource/Delegate
extension ShortenerViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.links.count
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let item = viewModel.links[indexPath.row]
    
    let cell = tableView.dequeueReusableCell(
      withIdentifier: "ShortenerListCell",
      for: indexPath
    ) as! ShortenerListCell
    
    cell.configure(with: item)
    cell.onCopy = { copiedURL in
      // futuramente: Toast
      print("Copied: \(copiedURL)")
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    84
  }
}
