package me.iamsahil.flutterandroidnativeintegration

import android.content.Context
import io.flutter.embedding.android.FlutterFragment
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class CustomFlutterFragment : FlutterFragment() {


    private var methodChannel: MethodChannel? = null

    override fun onAttach(context: Context) {
        super.onAttach(context)
        // Initialize the MethodChannel when the fragment is attached
        methodChannel =
            flutterEngine?.dartExecutor?.binaryMessenger?.let { MethodChannel(it, CHANNEL) }
    }

    override fun onDetach() {
        super.onDetach()
        // Clean up the MethodChannel when the fragment is detached
        methodChannel = null
    }

    fun canHandleBackPress(callback: (Boolean) -> Unit) {
        methodChannel?.invokeMethod("canHandleBackPress", null, object : MethodChannel.Result {
            override fun success(result: Any?) {
                callback(result as? Boolean ?: false)
            }

            override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
                // Handle error if needed
                callback(false)
            }

            override fun notImplemented() {
                // Handle method not implemented
                callback(false)
            }
        })
    }

    companion object {
        private const val CHANNEL = "com.example/my_channel"
    }
}