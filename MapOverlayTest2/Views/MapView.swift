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
    
 /*   func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      if overlay is MapOverlay {
        return MapOverlayView(overlay: overlay, overlayImage: #imageLiteral(resourceName: "overlay_park"))
      }
      return MKOverlayRenderer()
    }
*/
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
     
        return MapOverlayView(overlay: overlay, overlayImage: #imageLiteral(resourceName: "overlay_park"))
      }
      

    
  
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<SUMapView>) {
        let coordinate = CLLocationCoordinate2DMake(34.4248,-118.5971)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)
        let overlay = MapOverlay(park: park)
        uiView.addOverlay(overlay)
        
    }
}
