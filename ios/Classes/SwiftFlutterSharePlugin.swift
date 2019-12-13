import Flutter
import UIKit
import MessageUI

public class SwiftFlutterSharePlugin: NSObject, FlutterPlugin, UINavigationControllerDelegate, MFMessageComposeViewControllerDelegate {
    public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_share", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterSharePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "isInstallWhatsApp":
            result(isInstallWhatsApp())
            break
        case "isInstallSms":
            result(isInstallSms())
            break
        case "sendSms":
            let _arguments = call.arguments as! [String : Any]
            let phone = _arguments["phone"] as? String
            let text = _arguments["text"] as? String
            result(sendSms(phone, text: text))
            break
        case "sendToWhatsApp":
            let _arguments = call.arguments as! [String : Any]
            let text = _arguments["text"] as? String
            result(sendToWhatsApp(text))
            break
        default:
            break
        }
    }
    
    public func isInstallWhatsApp() -> Bool {
        let url = URL(string: "whatsapp://send?text=Hello%2C%20World!")
        return UIApplication.shared.canOpenURL(url!)
    }
    
    public func isInstallSms() -> Bool {
        return MFMessageComposeViewController.canSendText()
    }
    
    public func sendSms(_ phone: String?, text: String?) -> Bool {
        let controller = MFMessageComposeViewController()
        controller.body = text!
        controller.recipients = [phone!]
        controller.messageComposeDelegate = self
        UIApplication.shared.keyWindow?.rootViewController?.present(controller, animated: true, completion: nil)
        return true
    }
    
    public func sendToWhatsApp(_ text: String?) -> Bool {
        let str = String(format: "whatsapp://send?text=%@", text!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)
        let url = URL(string: str)
        if (UIApplication.shared.canOpenURL(url!)) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url!)
            }
            return true
        } else {
            return false
        }
    }
    
    public func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        let _: [MessageComposeResult: String] = [
            MessageComposeResult.sent: "sent",
            MessageComposeResult.cancelled: "cancelled",
            MessageComposeResult.failed: "failed",
        ]
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}
