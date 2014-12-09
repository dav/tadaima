import CoreLocation
import CoreBluetooth
import UIKit

class BeaconManager: NSObject, CLLocationManagerDelegate, CBCentralManagerDelegate, CBPeripheralManagerDelegate, CBPeripheralDelegate {
    struct Static {
        static var sharedInstance: BeaconManager?
    }
    
    class var sharedInstance: BeaconManager {
        if Static.sharedInstance == nil {
            Static.sharedInstance = BeaconManager()
        }
        
        return Static.sharedInstance!
    }

    var cManager: CBCentralManager!
    var peripheralManager: CBPeripheralManager!
    var locManager = CLLocationManager()
    
    var beaconRegion = CLBeaconRegion()
    var discoveredPeripheral:CBPeripheral?

    override init() {
        super.init()
        cManager = CBCentralManager(delegate: self, queue: nil)
        
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        
        locManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locManager.delegate = self
    }

    @IBAction func scanForBeacons(sender: AnyObject) {
        var curDevice = UIDevice.currentDevice()
        
        println("--------\nSTART SCANNING FOR BEACONS; CURRENT DEVICE INFO:")
        println("VENDOR ID: \(curDevice.identifierForVendor)")
        println("BATTERY LEVEL: \(curDevice.batteryLevel)")
        println("DEVICE DESCRIPTION: \(curDevice.description)")
        println("MODEL: \(curDevice.model)\n\n")
        
        cManager.scanForPeripheralsWithServices(nil, options: nil)
        //sensorData.text = "\nNow Scanning for PERIPHERALS!\n"
    }

    // MARK : delegate
    
    func centralManagerDidUpdateState(central: CBCentralManager!) {
        
        switch cManager.state {
            
        case .PoweredOff:
            println("CoreBluetooth BLE hardware is powered off")
            //self.sensorData.text = "CoreBluetooth BLE hardware is powered off\n"
            break
        case .PoweredOn:
            println("CoreBluetooth BLE hardware is powered on and ready")
            //self.sensorData.text = "CoreBluetooth BLE hardware is powered on and ready\n"
            // We can now call scanForBeacons
            self.scanForBeacons(self)
            break
        case .Resetting:
            println("CoreBluetooth BLE hardware is resetting")
            //self.sensorData.text = "CoreBluetooth BLE hardware is resetting\n"
            break
        case .Unauthorized:
            println("CoreBluetooth BLE state is unauthorized")
            //self.sensorData.text = "CoreBluetooth BLE state is unauthorized\n"
            
            break
        case .Unknown:
            println("CoreBluetooth BLE state is unknown")
            //self.sensorData.text = "CoreBluetooth BLE state is unknown\n"
            break
        case .Unsupported:
            println("CoreBluetooth BLE hardware is unsupported on this platform")
            //self.sensorData.text = "CoreBluetooth BLE hardware is unsupported on this platform\n"
            break
            
        default:
            println("WARNING: unexpected BLE state: \(cManager.state)")
            break
        }
    }
    
    func centralManager(central: CBCentralManager!, didDiscoverPeripheral peripheral: CBPeripheral!, advertisementData: [NSObject : AnyObject]!, RSSI: NSNumber!) {
            central.connectPeripheral(peripheral, options: nil)
            
            // We have to set the discoveredPeripheral var we declared earlier to reference the peripheral, otherwise we won't be able to interact with it in didConnectPeripheral. And you will get state = connecting> is being dealloc'ed while pending connection error.
            
            self.discoveredPeripheral = peripheral
            
            println("--------\nFOUND DEVICE INFO\n")
            println("PERIPHERAL NAME: \(peripheral.name)\n AdvertisementData: \(advertisementData)\n RSSI: \(RSSI)\n")
            println("UUID DESCRIPTION: \(peripheral.identifier.UUIDString)\n")
            println("IDENTIFIER: \(peripheral.identifier)\n")
            
            //sensorData.text = sensorData.text + "FOUND PERIPHERALS: \(peripheral) AdvertisementData: \(advertisementData) RSSI: \(RSSI)\n"
            
            cManager.stopScan()
    }
    
    func centralManager(central: CBCentralManager!, didConnectPeripheral peripheral: CBPeripheral!) {
        peripheral.delegate = self
        peripheral.discoverServices(nil)
        println("Connected to peripheral: \(peripheral)")
    }
    
    
    func centralManager(central: CBCentralManager!, didFailToConnectPeripheral peripheral: CBPeripheral!, error: NSError!) {
        println("FAILED TO CONNECT \(error)")
    }


    // MARK :: CBPeripheralDelegate
    
    
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager!) {
        
        switch peripheralManager.state {
            
        case .PoweredOff:
            println("Peripheral - CoreBluetooth BLE hardware is powered off")
            break
            
        case .PoweredOn:
            println("Peripheral - CoreBluetooth BLE hardware is powered on and ready")
            break
            
        case .Resetting:
            println("Peripheral - CoreBluetooth BLE hardware is resetting")
            break
            
        case .Unauthorized:
            println("Peripheral - CoreBluetooth BLE state is unauthorized")
            break
            
        case .Unknown:
            println("Peripheral - CoreBluetooth BLE state is unknown")
            break
            
        case .Unsupported:
            println("Peripheral - CoreBluetooth BLE hardware is unsupported on this platform")
            break
            
        default:
            break
        }
    }
    
    // Invoked when you discover the peripheral's available services.
    func peripheral(peripheral: CBPeripheral!, didDiscoverServices error: NSError!) {
        if (error != nil) { println("ERROR: \(error)") }
        
        var svc: CBService
        
        for svc in peripheral.services {
            println("Service \(svc)\n")
            println("Discovering Characteristics for Service : \(svc)")
            peripheral.discoverCharacteristics(nil, forService: svc as CBService)
        }
    }
    
    func peripheral(peripheral: CBPeripheral!, didDiscoverCharacteristicsForService service: CBService!, error: NSError!)
    {
        println("CHARACTERISTICS:")
        var myCharacteristic = CBCharacteristic()
        
        for myCharacteristic in service.characteristics {
            println("didDiscoverCharacteristicsForService - Service: \(service) Characteristic: \(myCharacteristic)\n\n")
            peripheral.readValueForCharacteristic(myCharacteristic as CBCharacteristic)
        }
    }

    
    func peripheral(peripheral: CBPeripheral!, didUpdateNotificationStateForCharacteristic characteristic: CBCharacteristic!, error: NSError!) {
        println("\nCharacteristic \(characteristic.description) isNotifying: \(characteristic.isNotifying)\n")
        if characteristic.isNotifying == true {
            peripheral.readValueForCharacteristic(characteristic as CBCharacteristic)
        }
    }



}
