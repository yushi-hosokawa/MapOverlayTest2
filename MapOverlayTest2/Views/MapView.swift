//
//  MapView.swift
//  MapOverlayTest2
//
//  Created by yushi hosokawa on 2019/10/07.
//  Copyright © 2019 yushi hosokawa. All rights reserved.
//
import SwiftUI
import MapKit

    
struct SUMapView: UIViewRepresentable {
    
    
    typealias UIViewType = MKMapView
    let mapViewDelegate = MapViewDelegate()
    var park = Park(filename: "MagicMountain")
    func makeUIView(context: UIViewRepresentableContext<SUMapView>) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    


    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<SUMapView>) {

  
        let latDelta = park.overlayTopLeftCoordinate.latitude -
        park.overlayBottomRightCoordinate.latitude
        
        let span = MKCoordinateSpan(latitudeDelta: fabs(latDelta), longitudeDelta: 0.0)
        let region = MKCoordinateRegion(center: park.midCoordinate, span: span)
          
        uiView.region = region
        
        uiView.delegate = mapViewDelegate                          // (1) This should be set in makeUIView, but it is getting reset to `nil`
        uiView.translatesAutoresizingMaskIntoConstraints = false   // (2) In the absence of this, we get constraints error on rotation; and again, it seems one should do this in makeUIView, but has to be here

        addMap(park:park,view:uiView)
        
    }
}

private extension SUMapView {
    func addMap(park:Park,view:MKMapView)
    {
        let overlay = MapOverlay(park: park)
        view.addOverlay(overlay)
    }
}

class MapViewDelegate: NSObject, MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        print("呼ばれた")
          if overlay is MapOverlay {
            return MapOverlayView(overlay: overlay, overlayImage: #imageLiteral(resourceName: "overlay_park"))
          }
          return MKOverlayRenderer()
        }
}

