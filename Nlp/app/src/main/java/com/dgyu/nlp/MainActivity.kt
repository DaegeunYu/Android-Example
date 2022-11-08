package com.dgyu.nlp

import android.os.Bundle
import android.view.View
import android.widget.EditText
import android.widget.ImageView
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import com.dgyu.nlp.Util.Kkma

class MainActivity : AppCompatActivity() {
    private var button: ImageView? = null
    private var input: EditText? = null
    private var result: TextView? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        button = findViewById(R.id.input_button)
        input = findViewById(R.id.input)
        result = findViewById(R.id.result)

        Kkma.getInstance().init()

        button!!.setOnClickListener(View.OnClickListener {
            if (input!!.text != null && !input!!.text.toString().equals("")) {
                result!!.setText(Kkma.getInstance().nlp(input!!.text.toString()));
            }
        })


    }
}