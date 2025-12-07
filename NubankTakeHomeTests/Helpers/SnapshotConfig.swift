import UIKit
import SnapshotTesting

enum SnapshotConfig {
  
  /// Device padrão
  static let device = ViewImageConfig.iPhone13ProMax
  
  /// Caminho onde salvar os snapshots
  static var snapshotPath: String {
    return FileManager.default.currentDirectoryPath + "/Tests/__Snapshots__/"
  }
  
  // MARK: - Snapshot for UIViewController
  static func assertSnapshot(
    vc: UIViewController,
    file: StaticString = #file,
    testName: String = #function,
    line: UInt = #line,
    record: Bool = false
  ) {
    SnapshotTesting.assertSnapshot(
      of: vc,
      as: .image(on: device),
      named: testName,
      record: record,
      file: file,
      testName: testName,
      line: line
    )
  }
  
  // MARK: - Snapshot for UIView
  static func assertSnapshot(
    view: UIView,
    file: StaticString = #file,
    testName: String = #function,
    line: UInt = #line,
    record: Bool = false
  ) {
    
    // É necessário forçar o layout antes do snapshot
    let targetSize = device.size
    view.frame = CGRect(origin: .zero, size: targetSize ?? .zero)
    view.layoutIfNeeded()
    
    SnapshotTesting.assertSnapshot(
      of: view,
      as: .image(size: targetSize),
      named: testName,
      record: record,
      file: file,
      testName: testName,
      line: line
    )
  }
}
