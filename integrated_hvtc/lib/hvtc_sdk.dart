import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class HvtcSdk {
  static final HvtcSdk _singleton = HvtcSdk._internal();

  /// Chatbot HVTC SDK config
  static const String keyTokenSSO = "token_sso";
  static const String keyBotId = "bot_id";
  static const String keyBotName = "bot_name";
  static const String keyLlmStreamUrl = "llm_stream_url";
  static const String keyBotConfigUrl = "bot_config_url";
  static const String keyBotFeedbackUrl = "bot_feedback_url";
  static const String keyLivechatConnectUrl = "livechat_connect_url";
  static const String keyLivechatSocketUrl = "livechat_socket_url";
  static const String keyLivechatTokenSseUrl = "livechat_token_sse_url";

  /// Chatbot HVTC SDK method
  static const String methodStartSdk = "startSDK";

  /// Gets the only running instance of Chatbot HVTC SDK.
  static HvtcSdk get instance {
    return _singleton;
  }

  HvtcSdk._internal();

  Future<void> start({
    required String tokenSso,
    required String botId,
    required String botName,
    String? llmStreamUrl,
    String? botConfigUrl,
    String? botFeedbackUrl,
    String? livechatConnectUrl,
    String? livechatSocketUrl,
    String? livechatTokenSseUrl,
  }) async {
    await Channels.channel.invokeMethodOnMobile<void>(methodStartSdk, {
      keyTokenSSO: tokenSso,
      keyBotId: botId,
      keyBotName: botName,
      keyLlmStreamUrl: llmStreamUrl,
      keyBotConfigUrl: botConfigUrl,
      keyBotFeedbackUrl: botFeedbackUrl,
      keyLivechatConnectUrl: livechatConnectUrl,
      keyLivechatSocketUrl: livechatSocketUrl,
      keyLivechatTokenSseUrl: livechatTokenSseUrl,
    });
  }
}

extension MethodChannelMobile on MethodChannel {
  Future<T?> invokeMethodOnMobile<T>(String method, [dynamic arguments]) {
    if (kIsWeb) {
      return Future.value(null);
    }

    return invokeMethod(method, arguments);
  }
}

/// Native channels.
class Channels {
  static const MethodChannel channel = MethodChannel('vnptit.integrated/hvtc');
}
