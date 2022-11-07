package com.dgyu.pdfSample;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.RectF;
import android.net.Uri;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.pspdfkit.document.PdfDocument;
import com.pspdfkit.document.PdfDocumentLoader;

import java.io.IOException;
import java.util.ArrayList;

public class PDFFileAdapter extends RecyclerView.Adapter<PDFFileAdapter.PDFViewHolder> {

    private Context context;
    private PDFViewHolder[] viewHolder;
    private RectF[] pageImageSize;

    private int currentPosition;

    private ArrayList<Bitmap> bitmaps;

    public PDFFileAdapter(Context context, Uri uri) {
        this.context = context;
        if (bitmaps != null) {
            bitmaps.clear();
        }
        bitmaps = new ArrayList<>();

        try {
            PdfDocument document = PdfDocumentLoader.openDocument(context, uri);
            int pageSize = document.getPageCount();
            pageImageSize = new RectF[pageSize];
            viewHolder = new PDFViewHolder[pageSize];
            for (int i = 0; i < pageSize; i++) {
                pageImageSize[i] = document.getPageSize(i).toRect();
                bitmaps.add(document.renderPageToBitmap(context, i, (int)pageImageSize[i].width(), (int)pageImageSize[i].height()));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void removeAdapter() {
        bitmaps.clear();
        bitmaps = null;
        pageImageSize = null;
        viewHolder = null;
    }

    @NonNull
    @Override
    public PDFViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_pdf_image, parent, false);
        return new PDFViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull PDFViewHolder holder, int position) {
        viewHolder[position] = holder;
        viewHolder[position].imageView.setImageBitmap(bitmaps.get(position));
    }

    @Override
    public int getItemCount() {
        if (bitmaps == null) {
            return 0;
        }
        return bitmaps.size();
    }

    public PDFViewHolder getCurrentViewHolder() {
        return viewHolder[currentPosition];
    }

    public void setCurrentPosition(int currentPosition) {
        this.currentPosition = currentPosition;
    }

    public class PDFViewHolder extends RecyclerView.ViewHolder {
        private ImageView imageView;

        public PDFViewHolder(@NonNull View itemView) {
            super(itemView);
            imageView = itemView.findViewById(R.id.pdf_image);
        }

        public ImageView getImageView() {
            return imageView;
        }
    }
}
