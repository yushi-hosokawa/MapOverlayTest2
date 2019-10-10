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

        let overlay = MapOverlay(park: park)
        uiView.addOverlay(overlay)
        
        
        //annotationの処理
        guard let attractions = Park.plist("MagicMountainAttractions") as? [[String : String]] else { return }
          
        for attraction in attractions {
          let coordinate = Park.parseCoord(dict: attraction, fieldName: "location")
          let title = attraction["name"] ?? ""
          let typeRawValue = Int(attraction["type"] ?? "0") ?? 0
          let type = AttractionType(rawValue: typeRawValue) ?? .misc
          let subtitle = attraction["subtitle"] ?? ""
          let annotation = AttractionAnnotation(coordinate: coordinate, title: title, subtitle: subtitle, type: type)
          uiView.addAnnotation(annotation)
        }
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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
      let annotationView = AttractionAnnotationView(annotation: annotation, reuseIdentifier: "Attraction")
      annotationView.canShowCallout = true
      return annotationView
    }
}

