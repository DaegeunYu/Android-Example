package com.dgyu.pdfSample;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.viewpager2.widget.ViewPager2;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.dgyu.pdfSample.Util.FileUtil;
import com.dgyu.pdfSample.Util.Log;
import com.dgyu.pdfSample.Util.Toast;

public class MainActivity extends AppCompatActivity {

    private ImageView addPdf;
    private ImageView removePdf;
    private TextView page;
    private ViewPager2 viewPager;
    private PDFFileAdapter pdfFileAdapter;

    private final int REQUEST_PICK_FILE = 1122;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        addPdf = findViewById(R.id.add_pdf);
        removePdf = findViewById(R.id.remove);
        page = findViewById(R.id.page);
        viewPager = findViewById(R.id.image_holder);

        viewPager.registerOnPageChangeCallback(new ViewPager2.OnPageChangeCallback() {
            @Override
            public void onPageSelected(int position) {
                super.onPageSelected(position);
                if (pdfFileAdapter != null) {
                    pdfFileAdapter.setCurrentPosition(position);
                    page.setText((position+1) + " / " + pdfFileAdapter.getItemCount());
                }
            }
        });

        addPdf.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                pick();
            }
        });

        removePdf.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                pdfFileAdapter.getCurrentViewHolder().getImageView().setImageResource(R.color.transparent);;
                pdfFileAdapter.removeAdapter();
                viewPager.setAdapter(pdfFileAdapter);
                removePdf.setVisibility(View.GONE);
                page.setText("");
            }
        });

    }

    @Override
    protected void onResume() {
        super.onResume();
    }

    private void pick() {
        Intent intent = new Intent(Intent.ACTION_GET_CONTENT);
        intent.setType("*/*");
        intent.addCategory(Intent.CATEGORY_OPENABLE);
        intent.putExtra(Intent.EXTRA_ALLOW_MULTIPLE, true);

        // special intent for Samsung file manager
        Intent sIntent = new Intent("com.sec.android.app.myfiles.PICK_DATA");
        sIntent.addCategory(Intent.CATEGORY_DEFAULT);
        sIntent.putExtra(Intent.EXTRA_ALLOW_MULTIPLE, true);

        Intent chooserIntent;
        if (this.getPackageManager().resolveActivity(sIntent, 0) != null){
            // it is device with Samsung file manager
            chooserIntent = sIntent;
        } else {
            chooserIntent = intent;
        }

        try {
            this.startActivityForResult(chooserIntent, REQUEST_PICK_FILE);
        } catch (android.content.ActivityNotFoundException ex) {
            Log.e("openFile: ", ex);
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if (resultCode == RESULT_OK) {
            switch (requestCode) {
                case REQUEST_PICK_FILE:
                    try {
                        if (null != data) {
                            if (null != data.getClipData()) {
                                Toast.toast(this, "하나씩만 선택해주세요.");
                            } else {
                                Uri fileUri = Uri.fromFile(FileUtil.getInstance().getFile(this, data.getData()));
                                pdfFileAdapter = new PDFFileAdapter(this, fileUri);
                                viewPager.setAdapter(pdfFileAdapter);
                                page.setText("1 / " + pdfFileAdapter.getItemCount());
                                removePdf.setVisibility(View.VISIBLE);
                            }
                        }

                    } catch (Exception e) {
                        e.printStackTrace();
                        Toast.toast(this, "잠시 후 다시 시도해주세요");
                    }
                    break;
            }
        }

    }
}