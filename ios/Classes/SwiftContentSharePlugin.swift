import Flutter
import UIKit

public class SwiftContentSharePlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "content_share", binaryMessenger: registrar.messenger())
        let instance = SwiftContentSharePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let methodName = MethodName(rawValue: call.method) {
            switch methodName {
            case .getPlatformVersion:
                result("iOS " + UIDevice.current.systemVersion)
            case .share, .shareFile:
                if let data = call.arguments as? [String: String], let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []),
                   let decodedResult = try? JSONDecoder().decode(ShareContentModel.self, from: jsonData)
                {
                    self.shareContent(response: decodedResult)
                }
                result(true)
            }

        } else {
            result(FlutterMethodNotImplemented)
        }

        result("iOS " + UIDevice.current.systemVersion)
    }

    private func shareContent(response: ShareContentModel) {
        var items = [Any]()
        if response.text != nil {
            items.append(response.text!)
        }
        if let fileURL = response.filePath, let url = URL(string: fileURL) {
            items.append(url)
        }
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        UIApplication.shared.topMostViewController()?.present(ac, animated: true, completion: nil)
    }
}
