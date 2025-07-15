import Flutter
import UIKit
import ICSmartVoiceUIHVTC

@main
@objc class AppDelegate: FlutterAppDelegate {
    
    var methodChannel: FlutterResult?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: "vnptit.integrated/hvtc",
                                           binaryMessenger: controller.binaryMessenger)
        channel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            // Note: this method is invoked on the UI thread.
            // Handle battery messages.
            self.methodChannel = result
            DispatchQueue.main.async {
                self.openSDK(controller, arguments: call.arguments)
            }
        
        })
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func openSDK(_ controller: UIViewController, arguments: Any?) {
        let tokenSSO = (arguments as? [String: Any])?["token_sso"] as? String ?? ""
        let botId = (arguments as? [String: Any])?["bot_id"] as? String ?? ""
        let botName = (arguments as? [String: Any])?["bot_name"] as? String ?? ""
        let llmStreamURL = (arguments as? [String: Any])?["llm_stream_url"] as? String ?? ""
        let botConfigURL = (arguments as? [String: Any])?["bot_config_url"] as? String ?? ""
        let botFeedbackURL = (arguments as? [String: Any])?["bot_feedback_url"] as? String ?? ""
        let livechatConnectURL = (arguments as? [String: Any])?["livechat_connect_url"] as? String ?? ""
        let livechatSocketURL = (arguments as? [String: Any])?["livechat_socket_url"] as? String ?? ""
        let livechatTokenSSEURL = (arguments as? [String: Any])?["livechat_token_sse_url"] as? String ?? ""

        let icSVMainUIStart = ICStartRouter.createModule() as! ICStartViewController
        icSVMainUIStart.tokenSSO = tokenSSO
        icSVMainUIStart.botID = botId
        icSVMainUIStart.appName = botName
        // icSVMainUIStart.imageLogo = UIImage(named: "chatbot_hvtc_ic")
        icSVMainUIStart.isShowDismissSDK = false
        
        icSVMainUIStart.llmStreamURL = llmStreamURL
        icSVMainUIStart.getInfoBot = botConfigURL
        icSVMainUIStart.postFeedback = botFeedbackURL
        icSVMainUIStart.wssLiveChat = livechatSocketURL
        icSVMainUIStart.postSSOToken = livechatTokenSSEURL
        icSVMainUIStart.postLiveChatConnect = livechatConnectURL
        
        icSVMainUIStart.startWithoutInitial(controller)
    }
}
