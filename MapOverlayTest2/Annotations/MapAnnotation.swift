import UIKit
import MapKit

enum AttractionType: Int {
  case misc = 0
  case spot1
  case spot2
  case spot3
  
  func image() -> UIImage {
    switch self {
    case .misc:
      return #imageLiteral(resourceName: "spot4")
    case .spot1:
      return #imageLiteral(resourceName: "spot1")
    case .spot2:
      return #imageLiteral(resourceName: "spot2")
    case .spot3:
      return #imageLiteral(resourceName: "spot3")
    }
  }
}

class AttractionAnnotation: NSObject, MKAnnotation {
  var coordinate: CLLocationCoordinate2D
  var title: String?
  var subtitle: String?
  var type: AttractionType
  
  init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, type: AttractionType) {
    self.coordinate = coordinate
    self.title = title
    self.subtitle = subtitle
    self.type = type
  }
}
