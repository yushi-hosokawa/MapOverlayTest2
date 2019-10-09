//
//  MapView.swift
//  MapOverlayTest2
//
//  Created by yushi hosokawa on 2019/10/07.
//  Copyright © 2019 yushi hosokawa. All rights reserved.
//
import SwiftUI
import MapKit



struct SUMapView: UIViewRepresentable{
    typealias UIViewType = MKMapView
    var park = Park(filename: "MagicMountain")
    func makeUIView(context: UIViewRepresentableContext<SUMapView>) -> MKMapView {
        MKMapView(frame: .zero)
    }
    



 

    
  
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<SUMapView>) {
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
          
          print("呼ばれた")
            if overlay is MapOverlay {
              return MapOverlayView(overlay: overlay, overlayImage: #imageLiteral(resourceName: "overlay_park"))
            }
            return MKOverlayRenderer()
          }

        
  
        
        //座標から直接最初に現れる画面を設定する方法
        /*
        let coordinate = CLLocationCoordinate2DMake(34.4248,-118.5971)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)
        */
  
         //同じく座標から直接最初に現れる画面を設定する方法だけどParkDataを利用
        let latDelta = park.overlayTopLeftCoordinate.latitude -
        park.overlayBottomRightCoordinate.latitude
        
        let span = MKCoordinateSpan(latitudeDelta: fabs(latDelta), longitudeDelta: 0.0)
        let region = MKCoordinateRegion(center: park.midCoordinate, span: span)
          
        uiView.region = region
        
        let overlay = MapOverlay(park: park)
        uiView.addOverlay(overlay)
        
    }
}
