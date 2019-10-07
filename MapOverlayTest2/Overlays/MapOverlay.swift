//
//  MapOverlay.swift
//  MapOverlayTest2
//
//  Created by yushi hosokawa on 2019/10/07.
//  Copyright © 2019 yushi hosokawa. All rights reserved.
//

import UIKit
import MapKit

class ParkMapOverlay: NSObject, MKOverlay {
  var coordinate: CLLocationCoordinate2D
  var boundingMapRect: MKMapRect

  init(park: Park) {
    boundingMapRect = park.overlayBoundingMapRect
    coordinate = park.midCoordinate
  }
}
