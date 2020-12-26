package com.map.example;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;

import android.Manifest;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.Signature;
import android.os.Build;
import android.os.Bundle;
import android.util.Base64;
import android.util.Log;
import android.view.ViewGroup;
import android.widget.Toast;

import com.kakao.util.maps.helper.Utility;

import net.daum.mf.map.api.MapLayout;
import net.daum.mf.map.api.MapPOIItem;
import net.daum.mf.map.api.MapPoint;
import net.daum.mf.map.api.MapView;

import java.security.MessageDigest;

public class MainActivity extends AppCompatActivity implements MapView.OpenAPIKeyAuthenticationResultListener, MapView.POIItemEventListener {
    private final String TAG = "CAR_TEST";
    private String restAPIKey = "36a9ce0b41516860b591cb18ee905ce9";

    private MapView mapView = null;
    private MapView.MapViewEventListener eventListener = null;
    private MapPOIItem marker = null;
    private MapLayout mapLayout = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

//        getAppKeyHash();
//        getPermission();

        if (mapLayout == null) {
            mapLayout = new MapLayout(this);
        }

        if (mapView == null) {
            mapView = mapLayout.getMapView();
            mapView.setDaumMapApiKey(restAPIKey);
            mapView.setMapType(MapView.MapType.Standard);
        }

        final Toast[] toast = {null};

        if (eventListener == null) {
            eventListener = new MapView.MapViewEventListener() {
                @Override
                public void onMapViewInitialized(MapView mapView) {

                }

                @Override
                public void onMapViewCenterPointMoved(MapView mapView, MapPoint mapPoint) {
                    Log.i(TAG, "Map Center Cood : " + mapPoint.getMapPointGeoCoord().latitude + " " + mapPoint.getMapPointGeoCoord().longitude );
                }

                @Override
                public void onMapViewZoomLevelChanged(MapView mapView, int i) {

                }

                @Override
                public void onMapViewSingleTapped(MapView mapView, MapPoint mapPoint) {
//                    mapView.removePOIItem(marker);
                    if (toast[0] != null) {
                        toast[0].cancel();
                    }
                    toast[0] = Toast.makeText(getApplicationContext(), "동경 : " + mapPoint.getMapPointGeoCoord().longitude + "\n북위 : " + mapPoint.getMapPointGeoCoord().latitude, Toast.LENGTH_SHORT);;
                    toast[0].show();
                    marker.setMapPoint(mapPoint);
                }

                @Override
                public void onMapViewDoubleTapped(MapView mapView, MapPoint mapPoint) {

                }

                @Override
                public void onMapViewLongPressed(MapView mapView, MapPoint mapPoint) {

                }

                @Override
                public void onMapViewDragStarted(MapView mapView, MapPoint mapPoint) {

                }

                @Override
                public void onMapViewDragEnded(MapView mapView, MapPoint mapPoint) {

                }

                @Override
                public void onMapViewMoveFinished(MapView mapView, MapPoint mapPoint) {

                }
            };
        }

        mapView.setMapViewEventListener(eventListener);
        mapView.setPOIItemEventListener(this);

        ViewGroup mapViewContainer = (ViewGroup) findViewById(R.id.map_view);
        mapViewContainer.addView(mapLayout);

        MapPoint mapPoint = MapPoint.mapPointWithGeoCoord(37.56755447387695, 126.97871398925781);
        MapPoint mapPoint2 = MapPoint.mapPointWithGeoCoord(37.56755447387695, 126.97991398925781);

        if (marker == null) {
            marker = new MapPOIItem();
        }
        marker.setItemName("Marker test1");
        marker.setTag(0);
        marker.setMapPoint(mapPoint);
        marker.setMarkerType(MapPOIItem.MarkerType.BluePin);
        marker.setSelectedMarkerType(MapPOIItem.MarkerType.RedPin);

        mapView.addPOIItem(marker);

        MapPOIItem marker2 = new MapPOIItem();

        marker2.setItemName("Marker test2");
        marker2.setTag(0);
        marker2.setMapPoint(mapPoint2);
        marker2.setMarkerType(MapPOIItem.MarkerType.YellowPin);
        marker2.setSelectedMarkerType(MapPOIItem.MarkerType.RedPin);
        mapView.addPOIItem(marker2);

    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        if (mapView != null) {
            mapView.removeAllCircles();
            mapView.removeAllPOIItems();
            mapView.removeAllPolylines();
            mapView = null;
        }
    }

    @Override
    public void onDaumMapOpenAPIKeyAuthenticationResult(MapView mapView, int i, String s) {

    }

    @Override
    public void onPOIItemSelected(MapView mapView, MapPOIItem mapPOIItem) {

    }

    @Override
    public void onCalloutBalloonOfPOIItemTouched(MapView mapView, MapPOIItem mapPOIItem) {

    }

    @Override
    public void onCalloutBalloonOfPOIItemTouched(MapView mapView, MapPOIItem mapPOIItem, MapPOIItem.CalloutBalloonButtonType calloutBalloonButtonType) {

    }

    @Override
    public void onDraggablePOIItemMoved(MapView mapView, MapPOIItem mapPOIItem, MapPoint mapPoint) {

    }

    private void getAppKeyHash() {
        PackageInfo packageInfo = Utility.getPackageInfo(getApplicationContext(), PackageManager.GET_SIGNATURES);
        for (Signature signature : packageInfo.signatures) {
            try {
                MessageDigest md = MessageDigest.getInstance("SHA");
                md.update(signature.toByteArray());
                Log.e(TAG, "HASH : " + Base64.encodeToString(md.digest(), Base64.DEFAULT));
            } catch (Exception e){
                Log.e(TAG, e.toString());
            }
        }
    }

    private void getPermission() {
        if (Build.VERSION.SDK_INT >= 21) { // We need to request runtime permission for Android 6.0 (API level 23) above
            int internetPermission = ActivityCompat.checkSelfPermission(this, Manifest.permission.INTERNET);
//            int locationPermission = ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION);

            if (internetPermission != PackageManager.PERMISSION_GRANTED) {
                ActivityCompat.requestPermissions(MainActivity.this, new String[]{Manifest.permission.INTERNET},
                        1000);
            }
//            if (locationPermission != PackageManager.PERMISSION_GRANTED) {
//                ActivityCompat.requestPermissions(MainActivity.this, new String[]{Manifest.permission.ACCESS_FINE_LOCATION},
//                        100);
//            }
        }
    }

}
