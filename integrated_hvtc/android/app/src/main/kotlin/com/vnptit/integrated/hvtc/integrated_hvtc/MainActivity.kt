package com.vnptit.integrated.hvtc.integrated_hvtc

import android.content.Intent
import com.ic.icenter.chat.hvtc.ui.ChatbotActivity
import com.ic.icenter.chat.hvtc.util.KeyIntentConstants
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject

class MainActivity : FlutterActivity() {

  companion object {
    private const val CHANNEL = "vnptit.integrated/hvtc"
    private const val METHOD_START_SDK = "startSDK"

    private const val KEY_TOKEN_SSO = "token_sso"
    private const val KEY_BOT_ID = "bot_id"
    private const val KEY_BOT_NAME = "bot_name"
    private const val KEY_SENDER_ID = "sender_id"
    private const val KEY_LLM_STREAM_URL = "llm_stream_url"
    private const val KEY_BOT_CONFIG_URL = "bot_config_url"
    private const val KEY_BOT_FEEDBACK_URL = "bot_feedback_url"
    private const val KEY_LIVECHAT_CONNECT_URL = "livechat_connect_url"
    private const val KEY_LIVECHAT_SOCKET_URL = "livechat_socket_url"
    private const val KEY_LIVECHAT_TOKEN_SSE_URL = "livechat_token_sse_url"
  }

  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
      .setMethodCallHandler { call, result ->
        if (call.method == METHOD_START_SDK) {
          val args = call.argumentsJSONObject()
          Intent(this, ChatbotActivity::class.java).also {
            it.putExtra(KeyIntentConstants.TOKEN_SSO, args.optString(KEY_TOKEN_SSO))
            it.putExtra(KeyIntentConstants.BOT_ID, args.optString(KEY_BOT_ID))
            it.putExtra(KeyIntentConstants.SENDER_ID, args.optString(KEY_SENDER_ID))
            it.putExtra(KeyIntentConstants.APP_NAME, args.optString(KEY_BOT_NAME, "Trợ lý Học viện Tài chính"))
            it.putExtra(KeyIntentConstants.IS_SHOW_DISMISS_SDK, true)
            it.putExtra(KeyIntentConstants.IS_START_WITHOUT_INITIAL, true)
            it.putExtra(KeyIntentConstants.LLM_STREAM_URL, args.optString(KEY_LLM_STREAM_URL))
            it.putExtra(KeyIntentConstants.BOT_CONFIG_URL, args.optString(KEY_BOT_CONFIG_URL))
            it.putExtra(KeyIntentConstants.BOT_FEEDBACK_URL, args.optString(KEY_BOT_FEEDBACK_URL))
            it.putExtra(KeyIntentConstants.LIVECHAT_CONNECT_URL, args.optString(KEY_LIVECHAT_CONNECT_URL))
            it.putExtra(KeyIntentConstants.LIVECHAT_SOCKET_URL, args.optString(KEY_LIVECHAT_SOCKET_URL))
            it.putExtra(KeyIntentConstants.TOKEN_SSE_LIVECHAT_URL, args.optString(KEY_LIVECHAT_TOKEN_SSE_URL))
            startActivity(it)
          }
        } else {
          result.notImplemented()
        }
      }
  }

  private fun MethodCall.argumentsJSONObject(): JSONObject {
    return try {
      @Suppress("UNCHECKED_CAST")
      JSONObject(arguments as Map<String, Any>)
    } catch (_: Exception) {
      JSONObject(mapOf<String, Any>())
    }
  }
}
