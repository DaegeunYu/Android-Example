package com.dgyu.nlp.Util;

import android.content.Context;

import org.snu.ids.kkma.ma.MExpression;
import org.snu.ids.kkma.ma.MorphemeAnalyzer;
import org.snu.ids.kkma.ma.Sentence;

import java.util.List;

public class Kkma {
    private static Kkma instance;
    private MorphemeAnalyzer morphemeAnalyzer;
    private Callback callback;
    private Log log;

    public static Kkma getInstance(){
        if(instance == null)
            instance = new Kkma();
        return instance;
    }

    public interface Callback{
        void callbackMethod();
    }

    public void destroy() {
        if (morphemeAnalyzer != null) {
            morphemeAnalyzer = null;
        }
    }

    public void init() {
//        this.callback = callback;

        if (morphemeAnalyzer == null) {
            morphemeAnalyzer = new MorphemeAnalyzer();
        }
        if (log == null) {
            log = new Log();
        }
//        this.callback.callbackMethod();
    }

    public String nlp(String string) {
        String result = "";
        try{
            morphemeAnalyzer.createLogger(null);
            List<MExpression> ret = morphemeAnalyzer.analyze(string);
            ret = morphemeAnalyzer.postProcess(ret);
            ret = morphemeAnalyzer.leaveJustBest(ret);
            List<Sentence> stl = morphemeAnalyzer.divideToSentences(ret);

            for (int i = 0; i <stl.size(); i++) {
                Sentence st = stl.get(i);
                log.e("1 : " + stl.get(i).toString());
                for (int j = 0; j < st.size(); j++) {
                    log.e("2 : " + st.get(j).toString());
                    for (int k = 0; k < st.get(j).size(); k++) {
                        log.e("3 : " + st.get(j).get(k).toString());

                        if (result.equals("")) {
                            result = "[" + st.get(j).get(k).toString() + "]";
                        } else {
                            result = result + "\n[" + st.get(j).get(k).toString() + "]";
                        }

//                        String tmp1 = st.get(j).get(k).toString().split("/")[1];
//                        String tmp2 = st.get(j).get(k).toString().split("/")[2];
//
//                        if (tmp2.contains("NN") || tmp2.contains("NP") || tmp2.contains("OL") || tmp2.contains("ON")) {
//                            if (result.equals("")) {
//                                result = tmp1;
//                            } else {
//                                result = result + " " + tmp1;
//                            }
//                        }
//
//                        if (tmp2.equals("VV") || tmp2.equals("VA") || tmp2.equals("VXA")) {
//                            if (result.equals("")) {
//                                result = tmp1 + "다";
//                            } else {
//                                result = result + " " + tmp1 + "다";
//                            }
//                        }

                    }
                }
            }

            morphemeAnalyzer.closeLogger();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
}
