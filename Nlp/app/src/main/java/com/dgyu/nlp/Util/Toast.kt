package com.dgyu.nlp.Util

import android.content.Context
import android.os.Build
import android.widget.Toast

/**
 * created Yu 2022. 10. 05
 *
 */

class Toast {
    private val SHOW_TOAST = true

    private var toast: Toast? = null
    private var toastDuration = 0

    fun toast(
        context: Context?,
        message: Any?,
        showDefault: Boolean,
        build: Boolean,
        isLong: Boolean
    ) {
        if (SHOW_TOAST || showDefault) {
            if (toast == null) {
                toast = Toast(context)
                if (Build.VERSION.SDK_INT > Build.VERSION_CODES.R) {
                    toast!!.duration = Toast.LENGTH_SHORT
                } else {
                    toastDuration = Toast.LENGTH_SHORT
                }
            }
            if (toast != null) {
                toast!!.cancel()
            }
            if (isLong) {
                if (Build.VERSION.SDK_INT > Build.VERSION_CODES.R) {
                    toast!!.duration = Toast.LENGTH_LONG
                } else {
                    toastDuration = Toast.LENGTH_LONG
                }
            } else {
                if (Build.VERSION.SDK_INT > Build.VERSION_CODES.R) {
                    toast!!.duration = Toast.LENGTH_SHORT
                } else {
                    toastDuration = Toast.LENGTH_SHORT
                }
            }
            if (message != null && message.toString() !== "") {
                var messages: String? = ""
                messages = if (build) {
                    buildMessage(message)
                } else {
                    message.toString()
                }
                if (Build.VERSION.SDK_INT > Build.VERSION_CODES.R) {
                    toast!!.setText(messages)
                    toast!!.show()
                } else {
                    Toast.makeText(context, messages, toastDuration).show()
                }
            }
        } else {
            Log().e(message.toString())
        }
    }

    fun toast(context: Context?, message: Any, showDefault: Boolean, build: Boolean) {
        if (build && SHOW_TOAST) {
            toast(context, buildMessage(message), showDefault, false, false)
        } else {
            toast(context, message, showDefault, false, false)
        }
    }

    fun toast(context: Context?, message: Any?, showDefault: Boolean) {
        toast(context, message, showDefault, false, false)
    }

    fun toast(context: Context?, message: Any?) {
        toast(context, message, false, false, false)
    }

    private fun buildMessage(message: Any): String? {
        val stackTraceElement = Thread.currentThread().stackTrace[4]
        val sb = StringBuilder()
        sb.append("[")
        sb.append(stackTraceElement.fileName)
        sb.append(" ")
        sb.append(stackTraceElement.lineNumber)
        sb.append("] ")
        sb.append(message)
        return sb.toString()
    }
}