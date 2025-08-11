import Foundation
import MapKit

class MapViewModel {
    
    var outputMapAnnotation: Observable<[MKPointAnnotation]> = Observable([])
    var inputMapRegin: Observable<String> = Observable("전체")
    
    init() {
        inputMapRegin.bind { [weak self] value in
            guard let self = self else { return }
            showAllAnnotations()
        }
    }
    
    private func showAllAnnotations() {
        
        let annotations = RestaurantList.restaurantArray.filter {
            if inputMapRegin.value == "전체" {
                return true
            } else {
                return $0.category == inputMapRegin.value
            }
        }.map { item in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)
            annotation.title = item.name
            annotation.subtitle = item.address
            return annotation
        }
        outputMapAnnotation.value = annotations
    }
}
