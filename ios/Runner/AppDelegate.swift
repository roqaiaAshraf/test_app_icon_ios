// import Flutter
// import UIKit

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

import Flutter
import UIKit
@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    let controller = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(
      name: "dynamic_icon",
      binaryMessenger: controller.binaryMessenger
    )
    channel.setMethodCallHandler { [weak self] (call, result) in
      switch call.method {
      case "getIcon":
        result(UIApplication.shared.alternateIconName ?? "AppIcon")
      case "setIcon":
        guard let args = call.arguments as? [String: Any],
              let iconName = args["icon"] as? String else {
          result(FlutterError(code: "INVALID_ARGUMENT", message: "Icon name is required", details: nil))
          return
        }
        guard UIApplication.shared.supportsAlternateIcons else {
          result(FlutterError(code: "NOT_SUPPORTED", message: "Alternate icons not supported", details: nil))
          return
        }
        // nil resets to the primary icon
        let alternateIconName: String? = (iconName == "AppIcon") ? nil : iconName
        self?.changeIcon(to: alternateIconName, result: result)
      default:
        result(FlutterMethodNotImplemented)
      }
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  private func changeIcon(to iconName: String?, result: @escaping FlutterResult) {
    UIApplication.shared.setAlternateIconName(iconName) { error in
      if let error = error {
        result(FlutterError(code: "ICON_CHANGE_FAILED", message: error.localizedDescription, details: nil))
      } else {
        result(nil)
      }
    }
  }
}