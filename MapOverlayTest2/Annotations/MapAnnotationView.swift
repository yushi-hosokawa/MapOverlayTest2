import UIKit
import MapKit

class AttractionAnnotationView: MKAnnotationView {
  // Required for MKAnnotationView
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
    super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    guard let attractionAnnotation = self.annotation as? AttractionAnnotation else { return }
    
    image = attractionAnnotation.type.image()
  }
}
