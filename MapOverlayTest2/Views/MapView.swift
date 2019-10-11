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

        let Pannotation = MKPointAnnotation()
        Pannotation.coordinate = CLLocationCoordinate2DMake(34.4248,-118.5971)
        Pannotation.title = "hoge"
        Pannotation.subtitle = "hogege"
        uiView.addAnnotation(Pannotation)
        
        
        let latDelta = park.overlayTopLeftCoordinate.latitude -
        park.overlayBottomRightCoordinate.latitude
        
        let span = MKCoordinateSpan(latitudeDelta: fabs(latDelta), longitudeDelta: 0.0)
        let region = MKCoordinateRegion(center: park.midCoordinate, span: span)
          
        uiView.region = region
        
        uiView.delegate = mapViewDelegate                          // (1) This should be set in makeUIView, but it is getting reset to `nil`
        uiView.translatesAutoresizingMaskIntoConstraints = false   // (2) In the absence of this, we get constraints error on rotation; and again, it seems one should do this in makeUIView, but has to be here
        //ここでoverlayを追加
        let overlay = MapOverlay(park: park)
        uiView.addOverlay(overlay)
        
        //ここからannotationの追加
        guard let attractions = Park.plist("MagicMountainAttractions") as? [[String : String]]
        else { return }
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
    
    //overlayがmapにある時に呼ばれる
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
         print("overlay呼ばれた")
          if overlay is MapOverlay {
            return MapOverlayView(overlay: overlay, overlayImage: #imageLiteral(resourceName: "kousi"))
          }
          return MKOverlayRenderer()
    }
    
    //annotationがmap上によばれている時に呼ばれる
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        print("annotationのmapViewが呼ばれた")
        let annotationView = AttractionAnnotationView(annotation: annotation, reuseIdentifier: "Attraction")
        annotationView.canShowCallout = true
        return annotationView
    }

}

