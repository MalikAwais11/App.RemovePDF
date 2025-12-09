// import UIKit
// import Flutter
//
// @main
// @objc class AppDelegate: FlutterAppDelegate {
//   override func application(
//     _ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//   ) -> Bool {
//     GeneratedPluginRegistrant.register(with: self)
//     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//   }
// }

import UIKit
import Flutter
import PDFKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    if let controller = window?.rootViewController as? FlutterViewController {
        let channel = FlutterMethodChannel(name: "pdf_utils", binaryMessenger: controller.binaryMessenger)

        channel.setMethodCallHandler { (call, result) in
            switch call.method {
            case "removePages":
                guard let args = call.arguments as? [String: Any],
                      let filePath = args["filePath"] as? String,
                      let pages = args["pages"] as? [Int] else {
                    result(FlutterError(code: "INVALID_ARGS", message: "Invalid arguments", details: nil))
                    return
                }

                let modifiedPath = self.removePagesFromPDF(filePath: filePath, pages: pages)
                if let modifiedPath = modifiedPath {
                    result(modifiedPath)
                } else {
                    result(FlutterError(code: "ERROR", message: "Failed to remove pages", details: nil))
                }

            case "getTotalPages":
                guard let args = call.arguments as? [String: Any],
                      let filePath = args["filePath"] as? String else {
                    result(FlutterError(code: "INVALID_ARGS", message: "Invalid file path", details: nil))
                    return
                }

                if let totalPages = self.getTotalPages(filePath: filePath) {
                    result(totalPages)
                } else {
                    result(FlutterError(code: "READ_ERROR", message: "Failed to read PDF", details: nil))
                }

            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func removePagesFromPDF(filePath: String, pages: [Int]) -> String? {
      let url = URL(fileURLWithPath: filePath)
      guard let document = PDFDocument(url: url) else { return nil }

      let newDocument = PDFDocument()
      for i in 0..<document.pageCount {
          if !pages.contains(i + 1), let page = document.page(at: i) {
              newDocument.insert(page, at: newDocument.pageCount)
          }
      }

      let outputDirectory = url.deletingLastPathComponent()
      let outputPath = outputDirectory.appendingPathComponent("modified.pdf").path
      newDocument.write(to: URL(fileURLWithPath: outputPath))
      return outputPath
  }

  private func getTotalPages(filePath: String) -> Int? {
      let url = URL(fileURLWithPath: filePath)
      guard let document = PDFDocument(url: url) else { return nil }
      return document.pageCount
  }
}
