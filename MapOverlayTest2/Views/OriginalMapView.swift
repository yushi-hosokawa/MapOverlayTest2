//
//  OriginalMapView.swift
//  MapOverlayTest2
//
//  Created by yushi hosokawa on 2019/10/07.
//  Copyright © 2019 yushi hosokawa. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit
import SwiftUI

class OriginalMapView: UIView {
    @IBOutlet weak var MapView: MKMapView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let location:CLLocationCoordinate2D
            = CLLocationCoordinate2DMake(35.709764,139.523009)
        
        self.MapView.setCenter(location,animated:true)
        
        
        var region:MKCoordinateRegion = self.MapView.region
        region.center = location
        region.span.latitudeDelta = 0.005
        region.span.longitudeDelta = 0.005
        
        self.MapView.setRegion(region,animated:true)
        

        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
    }


}
struct OriginalMapSwiftUIView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView{
        let view: OriginalMapView = OriginalMapView()
        view.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        //
    }
}
