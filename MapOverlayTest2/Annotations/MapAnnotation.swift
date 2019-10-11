import UIKit
import MapKit

enum AttractionType: Int {
  case misc = 0
  case ride
  case food
  case firstAid
  
  func image() -> UIImage {
    switch self {
    case .misc:
      return #imageLiteral(resourceName: "spot4")
    case .ride:
      return #imageLiteral(resourceName: "spot1")
    case .food:
      return #imageLiteral(resourceName: "spot2")
    case .firstAid:
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
