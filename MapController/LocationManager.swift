import CoreLocation
import Foundation
import MapKit

class LocationManager: NSObject {
    private let manager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        return manager
    }()
    
    private var completion: ((CLLocation) -> Void)?
    public override init() {
        super.init()
        manager.delegate = self
    }
     
    public func getUserLocation(completion: @escaping ((CLLocation) -> Void)) {
        manager.startUpdatingLocation()
        self.completion = completion
    }

    public func resolveLocationName(with location: CLLocation, completion: @escaping ((String?) -> Void)) {
        let geocoder = CLGeocoder()
        var name = String()
        let tabulation = " "
        
        geocoder.reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "RU_ru")) { placemarks, error in
            guard let place = placemarks?.first,
                  let country = place.country,
                  let locality = place.locality,
                  error == nil else {
                completion(nil)
                return
            }
            
            name = country + "," + tabulation + locality
            completion(name)
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        completion?(location)
    }
}
