import UIKit

class GimbalManager: NSObject, GMBLPlaceManagerDelegate {
    var gimbal : Gimbal?
    var placeManager : GMBLPlaceManager?
    
    override init() {
        super.init()
        Gimbal.setAPIKey("SOME API KEY", options: nil)
        println("GMBL: api init id=\(Gimbal.applicationInstanceIdentifier())")
        
        placeManager = GMBLPlaceManager()
        placeManager?.delegate = self
        GMBLPlaceManager.startMonitoring()
    }
    
    // MARK : GMBLPlaceManagerDelegate
    
    func placeManager(manager: GMBLPlaceManager!, didEnterPlace place: GMBLPlace!, date: NSDate!) {
        println("GMBL: did enter place \(place)")
    }
    
    func placeManager(manager: GMBLPlaceManager!, didExitPlace place: GMBLPlace!, date: NSDate!) {
        println("GMBL: did exit place \(place)")
    }
}
