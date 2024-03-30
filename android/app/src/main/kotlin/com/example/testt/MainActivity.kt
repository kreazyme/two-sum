package com.example.testt

import io.flutter.embedding.android.FlutterActivity


import kotlin.random.Random
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity(){
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "demo-methodchanel").setMethodCallHandler {
                call, result ->
            if(call.method == "twoSumNumber") {
               val firstNumber = call.argument<String>("firstNum")!!.toInt()
               val secondNumber =call.argument<String>("secondNum")!!.toInt()
                result.success(firstNumber + secondNumber)
            }
            else {
                result.notImplemented()
            }
        }
    }
}
