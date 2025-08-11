import UIKit
import MapKit
import SnapKit

class MapViewController: UIViewController {
    private let mapView = MKMapView()
    private let viewModel = MapViewModel()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupMapView()
        
        viewModel.outputMapAnnotation.bind { [weak self] value in
            guard let self = self else { return }
            let annotations = value
            
            mapView.addAnnotations(annotations)
            mapView.showAnnotations(annotations, animated: true)
        }
    }
     
   
     
    @objc private func rightBarButtonTapped() {
        let alertController = UIAlertController(
            title: "메뉴 선택",
            message: "원하는 옵션을 선택하세요",
            preferredStyle: .actionSheet
        )
        
        let alert1Action = UIAlertAction(title: "전체", style: .default) { value in
            guard let title = value.title else { return }
            self.viewModel.inputMapRegin.value = title
        }
        
        let alert2Action = UIAlertAction(title: "한식", style: .default) { value in
            guard let title = value.title else { return }
            self.viewModel.inputMapRegin.value = title
        }
        
        let alert3Action = UIAlertAction(title: "일식", style: .default) { value in
            guard let title = value.title else { return }
            self.viewModel.inputMapRegin.value = title
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { value in
            guard let title = value.title else { return }
            self.viewModel.inputMapRegin.value = title
        }
        
        alertController.addAction(alert1Action)
        alertController.addAction(alert2Action)
        alertController.addAction(alert3Action)
        alertController.addAction(cancelAction)
         
        present(alertController, animated: true, completion: nil)
    }
}
 


extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        
//        print("어노테이션이 선택되었습니다.")
//        print("제목: \(annotation.title ?? "제목 없음")")
//        print("부제목: \(annotation.subtitle ?? "부제목 없음")")
//        print("좌표: \(annotation.coordinate.latitude), \(annotation.coordinate.longitude)")
        
        // 선택된 어노테이션으로 지도 중심 이동
        let region = MKCoordinateRegion(
            center: annotation.coordinate,
            latitudinalMeters: 1000,
            longitudinalMeters: 1000
        )
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        print("어노테이션 선택이 해제되었습니다.")
    }
    
    
}




extension MapViewController {
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "지도"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "메뉴",
            style: .plain,
            target: self,
            action: #selector(rightBarButtonTapped)
        )
         
        view.addSubview(mapView)
         
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupMapView() {
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .none
         
        let mullaeStationCoordinate = CLLocationCoordinate2D(latitude: 37.515690, longitude: 126.891630)
        let region = MKCoordinateRegion(
            center: mullaeStationCoordinate,
            latitudinalMeters: 5000,
            longitudinalMeters: 5000
        )
        mapView.setRegion(region, animated: true)
    }
    
}
