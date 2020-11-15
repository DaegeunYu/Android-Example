package com.example.sttexample;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.ContextCompat;

import android.Manifest;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.media.AudioManager;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.provider.Settings;
import android.speech.RecognitionListener;
import android.speech.RecognizerIntent;
import android.speech.SpeechRecognizer;
import android.util.Log;
import android.view.MotionEvent;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.Locale;

public class MainActivity extends AppCompatActivity {

    private EditText editText;
    private ImageView imageView;
    private SpeechRecognizer mSpeech;
    private Intent mSpeechIntent;
    private boolean isrun = true;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        checkPermission();

        imageView = findViewById(R.id.stt_button);
        editText = findViewById(R.id.edit_text);
        mSpeech = SpeechRecognizer.createSpeechRecognizer(this);
        mSpeechIntent = new Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH);
        mSpeechIntent.putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL, RecognizerIntent.LANGUAGE_MODEL_FREE_FORM);
        mSpeechIntent.putExtra(RecognizerIntent.EXTRA_LANGUAGE, Locale.getDefault());

        AudioManager audioManager = (AudioManager) this.getSystemService(AUDIO_SERVICE);
        audioManager.adjustStreamVolume(AudioManager.STREAM_MUSIC,AudioManager.ADJUST_MUTE,0);

        mSpeech.startListening(mSpeechIntent);
        editText.setText("");

        mSpeech.setRecognitionListener(new RecognitionListener() {
            @Override
            public void onReadyForSpeech(Bundle params) {

            }

            @Override
            public void onBeginningOfSpeech() {

            }

            @Override
            public void onRmsChanged(float rmsdB) {

            }

            @Override
            public void onBufferReceived(byte[] buffer) {

            }

            @Override
            public void onEndOfSpeech() {

            }

            @Override
            public void onError(int error) {
                Log.e("Yu",""+error);
                new Handler().postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        mSpeech.startListening(mSpeechIntent);
                        editText.setText("");
                    }
                },100);
            }

            @Override
            public void onResults(Bundle results) {
                ArrayList<String> matches = results.getStringArrayList(SpeechRecognizer.RESULTS_RECOGNITION);

                //displaying the first match
                if (matches != null) {
                    editText.setText(matches.get(0));
                    Toast.makeText(getApplicationContext(), editText.getText().toString(), Toast.LENGTH_SHORT).show();
                }

                mSpeech.startListening(mSpeechIntent);
                editText.setText("");
            }

            @Override
            public void onPartialResults(Bundle partialResults) {

            }

            @Override
            public void onEvent(int eventType, Bundle params) {

            }
        });

        imageView.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                switch (event.getAction()) {
                    case MotionEvent.ACTION_UP:
                        //sttTest.setImageResource(R.drawable.btn_mic_on_minimize);
                        mSpeech.stopListening();
                        break;
                    case MotionEvent.ACTION_DOWN:
                        //sttTest.setImageResource(R.drawable.btn_mic_on);
                        mSpeech.startListening(mSpeechIntent);
                        editText.setText("");
                        break;
                }
                return false;
            }
        });

    }

    private Handler handler = new Handler();

    private Runnable runnable = new Runnable() {
        @Override
        public void run() {




            if(isrun) {
                handler.postDelayed(runnable,1000);
            }
        }
    };

    private void checkPermission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (!(ContextCompat.checkSelfPermission(this, Manifest.permission.RECORD_AUDIO) == PackageManager.PERMISSION_GRANTED)) {
                Intent intent = new Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS,
                        Uri.parse("package:" + this.getPackageName()));
                startActivity(intent);
                finish();
            }
        }
    }
}
