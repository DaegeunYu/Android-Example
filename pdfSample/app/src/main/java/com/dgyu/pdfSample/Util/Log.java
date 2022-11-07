package com.dgyu.pdfSample.Util;

/**
 * created Yu 2020. 04. 10
 *
 * ######## 커스텀 로그 #########
 * - v : 기타 로그 메시지
 * - d : 개발 중에만 유용한 디버그 로그 메시지
 * - i : 일반적인 사용에 대해 예상할 수 있는 로그 메시지
 * - w : 아직 오류는 아니지만 발생 가능한 문제
 * - e : 오류를 일으킨 문제
 */

public class Log {
    private static final String TAG = "DG_YU";
    private static final boolean SHOW_LOG = true;

    public static void v(Object message) {
        if (SHOW_LOG) {
            android.util.Log.v(TAG, buildMessage(null, message));
        }
    }

    public static void d(Object message) {
        if (SHOW_LOG) {
            android.util.Log.d(TAG, buildMessage(null, message));
        }
    }

    public static void i(Object message) {
        if (SHOW_LOG) {
            android.util.Log.i(TAG, buildMessage(null, message));
        }
    }

    public static void w(Object message) {
        if (SHOW_LOG) {
            android.util.Log.w(TAG, buildMessage(null, message));
        }
    }

    public static void e(Object message) {
        if (SHOW_LOG) {
            android.util.Log.e(TAG, buildMessage(null, message));
        }
    }

    public static void v(String format, Object... message) {
        if (SHOW_LOG) {
            android.util.Log.v(TAG, buildMessage(format, message));
        }
    }

    public static void d(String format, Object... message) {
        if (SHOW_LOG) {
            android.util.Log.d(TAG, buildMessage(format, message));
        }
    }

    public static void i(String format, Object... message) {
        if (SHOW_LOG) {
            android.util.Log.i(TAG, buildMessage(format, message));
        }
    }

    public static void w(String format, Object... message) {
        if (SHOW_LOG) {
            android.util.Log.w(TAG, buildMessage(format, message));
        }
    }

    public static void e(String format, Object... message) {
        if (SHOW_LOG) {
            android.util.Log.e(TAG, buildMessage(format, message));
        }
    }

    private static String buildMessage(String format, Object... message) {
        StackTraceElement stackTraceElement = Thread.currentThread().getStackTrace()[4];
        StringBuilder sb = new StringBuilder();
        sb.append("[");
        sb.append(stackTraceElement.getFileName());
        sb.append(" ");
        sb.append(stackTraceElement.getLineNumber());

        if (format == null || format.isEmpty()) {
            if (message == null || message.length <= 0) {
                sb.append("] >> ");
                sb.append(stackTraceElement.getMethodName());
            } else if (message.length > 1) {
                sb.append("] ");
                sb.append(message);
            } else {
                sb.append("] ");
                sb.append(message[0]);
            }
        } else if (message == null || message.length <= 0) {
            sb.append(format);
        } else {
            sb.append("] ");
            sb.append(String.format(format, message));
        }

        return sb.toString();
    }
}
