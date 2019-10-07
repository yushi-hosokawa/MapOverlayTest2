//
//  Park.swift
//  MapOverlayTest2
//
//  Created by yushi hosokawa on 2019/10/07.
//  Copyright © 2019 yushi hosokawa. All rights reserved.
//


import UIKit
import MapKit

class Park {
  var name: String?
  var boundary: [CLLocationCoordinate2D] = []
  
  var midCoordinate = CLLocationCoordinate2D()
  var overlayTopLeftCoordinate = CLLocationCoordinate2D()
  var overlayTopRightCoordinate = CLLocationCoordinate2D()
  var overlayBottomLeftCoordinate = CLLocationCoordinate2D()
  var overlayBottomRightCoordinate: CLLocationCoordinate2D {
    get {
      return CLLocationCoordinate2DMake(overlayBottomLeftCoordinate.latitude,
                                        overlayTopRightCoordinate.longitude)
    }
  }

  
  var overlayBoundingMapRect: MKMapRect {
    get {
        let topLeft = MKMapPoint(overlayTopLeftCoordinate)
        let topRight = MKMapPoint(overlayTopRightCoordinate)
        let bottomLeft = MKMapPoint(overlayBottomLeftCoordinate)
        
        return MKMapRect(
            x: topLeft.x,
            y: topLeft.y,
            width: fabs(topLeft.x - topRight.x),
            height: fabs(topLeft.y - bottomLeft.y))
    }
  }

    
    
    class func plist(_ plist: String) -> Any? {
      let filePath = Bundle.main.path(forResource: plist, ofType: "plist")!
      let data = FileManager.default.contents(atPath: filePath)!
      return try! PropertyListSerialization.propertyList(from: data, options: [], format: nil)
    }

    
    static func parseCoord(dict: [String: Any], fieldName: String) -> CLLocationCoordinate2D {
        guard let coord = dict[fieldName] as? String else {
        return CLLocationCoordinate2D()
      }
        let point = NSCoder.cgPoint(for: coord)
      return CLLocationCoordinate2DMake(CLLocationDegrees(point.x), CLLocationDegrees(point.y))
    }

    
    init(filename: String) {
      guard let properties = Park.plist(filename) as? [String : Any],
        let boundaryPoints = properties["boundary"] as? [String] else { return }
        
      midCoordinate = Park.parseCoord(dict: properties, fieldName: "midCoord")
      overlayTopLeftCoordinate = Park.parseCoord(dict: properties, fieldName: "overlayTopLeftCoord")
      overlayTopRightCoordinate = Park.parseCoord(dict: properties, fieldName: "overlayTopRightCoord")
      overlayBottomLeftCoordinate = Park.parseCoord(dict: properties, fieldName: "overlayBottomLeftCoord")
        
        let cgPoints = boundaryPoints.map { NSCoder.cgPoint(for: $0) }
      boundary = cgPoints.map { CLLocationCoordinate2DMake(CLLocationDegrees($0.x), CLLocationDegrees($0.y)) }
    }
    
    
    

}
