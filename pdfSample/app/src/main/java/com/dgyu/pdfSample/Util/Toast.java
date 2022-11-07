package com.dgyu.pdfSample.Util;

import android.content.Context;

/**
 * created Yu 2020. 04. 10
 *
 */

public class Toast {
    private static final boolean SHOW_TOAST = true;

    private static android.widget.Toast toast;
    private static Toast instance;
    private static Context context;

    public static Toast getInstance(){
        if(instance == null)
            instance = new Toast();

        return instance;
    }

    public void init(Context context) {
        this.context = context;
    }

    public void toast(Object message) {
        toast(context, message);
    }

    public static void toast(Context context, Object message, boolean showDefault, boolean build, boolean isLong) {
        if (SHOW_TOAST || showDefault) {
            if (toast == null) {
                toast = new android.widget.Toast(context);
                toast.setDuration(android.widget.Toast.LENGTH_SHORT);
            }
            if (toast != null) {
                toast.cancel();
            }
            if (isLong) {
                toast.setDuration(android.widget.Toast.LENGTH_LONG);
            } else {
                toast.setDuration(android.widget.Toast.LENGTH_SHORT);
            }
            if (message != null && message.toString() != "") {
                if (build) {
                    toast.setText(buildMessage(message));
                } else {
                    toast.setText(message.toString());
                }
                toast.show();
            }
        }
    }

    public static void toast(Context context, Object message, boolean showDefault, boolean build) {
        if (build) {
            toast(context, buildMessage(message), showDefault, false, false);
        } else {
            toast(context, message, showDefault, false, false);
        }
    }

    public static void toast(Context context, Object message, boolean showDefault) {
        toast(context, message, showDefault, false, false);
    }

    public static void toast(Context context, Object message) {
        toast(context, message, false, false, false);
    }

    private static String buildMessage(Object message) {
        StackTraceElement stackTraceElement = Thread.currentThread().getStackTrace()[4];
        StringBuilder sb = new StringBuilder();
        sb.append("[");
        sb.append(stackTraceElement.getFileName());
        sb.append(" ");
        sb.append(stackTraceElement.getLineNumber());
        sb.append("] ");
        sb.append(message);

        return sb.toString();
    }
}