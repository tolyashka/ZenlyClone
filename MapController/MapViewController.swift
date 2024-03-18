import UIKit
import MapKit
import CoreLocation

//import FirebaseAuth
//import Firebase

class MapViewController: UIViewController {
    private let mapView = MKMapView()
    private let locationManager = LocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsUserLocation = true
        setupLayout()
        getCurrentUserLocation()
//        
//        let ref = Database.database().reference()
////        let uid =
//        ref.child("users").child("zS8PtIAc9mXkQBZJdcfKg9S22JF3").child("friends").obse
    }
    
//     MARK: Current user location
    private func getCurrentUserLocation() {
        locationManager.getUserLocation { [weak self] location in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }
                strongSelf.addMapPin(with: location)
            }
        }
    }
        
    // MARK: Add pin
    private func addMapPin(with location: CLLocation) {
        let pin = MKPointAnnotation()
        pin.coordinate = location.coordinate
        
        mapView.setRegion(MKCoordinateRegion(center: pin.coordinate,
                                             span: MKCoordinateSpan(latitudeDelta: 0.1,
                                                                    longitudeDelta: 0.1)), animated: true)
        mapView.removeAnnotations(mapView.annotations)
        
        locationManager.resolveLocationName(with: location) { [weak self] locationName in
            self?.navigationItem.title = locationName
        }
    }
    
//     MARK: Setup layout
    private func setupLayout() {
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
