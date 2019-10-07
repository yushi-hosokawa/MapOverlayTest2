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

    func makeUIView(context: UIViewRepresentableContext<SUMapView>) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<SUMapView>) {
        let coordinate = CLLocationCoordinate2DMake(35.709764, 139.523009)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)
    }
}
