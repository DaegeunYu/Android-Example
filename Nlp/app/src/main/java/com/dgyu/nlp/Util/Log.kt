package com.dgyu.nlp.Util

/**
 * created Yu 2022. 08. 10
 *
 * ######## 커스텀 로그 #########
 * - v : 기타 로그 메시지
 * - d : 개발 중에만 유용한 디버그 로그 메시지
 * - i : 일반적인 사용에 대해 예상할 수 있는 로그 메시지
 * - w : 아직 오류는 아니지만 발생 가능한 문제
 * - e : 오류를 일으킨 문제
 */

class Log {
    private val TAG = "Nlp"
    private val SHOW_LOG = true

    fun v(format: String?) {
        if (SHOW_LOG) {
            android.util.Log.v(TAG, buildMessage(format))
        }
    }

    fun d(format: String?) {
        if (SHOW_LOG) {
            android.util.Log.d(TAG, buildMessage(format))
        }
    }

    fun i(format: String?) {
        if (SHOW_LOG) {
            android.util.Log.i(TAG, buildMessage(format))
        }
    }

    fun w(format: String?) {
        if (SHOW_LOG) {
            android.util.Log.w(TAG, buildMessage(format))
        }
    }

    fun e(format: String?) {
        if (SHOW_LOG) {
            android.util.Log.e(TAG, buildMessage(format))
        }
    }

    private fun buildMessage(format: String?): String {
        val stackTraceElement = Thread.currentThread().stackTrace[4]
        val sb = StringBuilder()
        sb.append("[")
        sb.append(stackTraceElement.fileName)
        sb.append(" ")
        sb.append(stackTraceElement.lineNumber)
        if (format == null || format.isEmpty()) {
            sb.append("] >> ")
            sb.append(stackTraceElement.methodName)
        } else {
            sb.append("] ")
            sb.append(String.format(format))
        }
        return sb.toString()
    }
}