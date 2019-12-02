
import Foundation
import CoreBluetooth

class BluetoothPeripheral {
    enum State {
        case poweredOn
        case unavailable
    }
    
    var didUpdateStateHandler: ((BluetoothPeripheral, State) -> ())?
    var currentState: State = .unavailable
    var isAdvertising: Bool {
        return manager.isAdvertising
    }
    
    private var uuid: CBUUID!
    private var delegator: BluetoothPeripheralDelegator!
    private var manager: CBPeripheralManager!
    
    static var hasPermission: Bool {
        return CBPeripheralManager().authorization == .allowedAlways
    }
    
    convenience init(uuid: String) {
        self.init()
        
        self.uuid = CBUUID(string: uuid)
        delegator = BluetoothPeripheralDelegator()
        manager = CBPeripheralManager(delegate: delegator, queue: nil, options: [CBCentralManagerOptionShowPowerAlertKey: false])
        setupAction()
    }
    
    private func setupAction() {
        delegator.didUpdateState = { [weak self] manager in
            guard let self = self else { return }
            if manager.state == .poweredOn {
                self.currentState = .poweredOn
                self.didUpdateStateHandler?(self, .poweredOn)
            } else {
                self.currentState = .unavailable
                self.didUpdateStateHandler?(self, .unavailable)
            }
        }
    }
    
    func post(duration: TimeInterval? = nil, _ string: String) {
        stop()
        print("Peripheral Start Post: \(string)")
        manager.startAdvertising([CBAdvertisementDataLocalNameKey: string,
                                  CBAdvertisementDataServiceUUIDsKey: [uuid]])
        
        if let duration = duration {
            Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { [weak self] (timer) in
                timer.invalidate()
                self?.stop()
            }
        }
    }
    
    func stop() {
        print("Peripheral Stop Post")
        manager.stopAdvertising()
    }
}


private class BluetoothPeripheralDelegator: NSObject, CBPeripheralManagerDelegate {
    fileprivate var didUpdateState: ((CBPeripheralManager) -> ())?
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        didUpdateState?(peripheral)
    }
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        print(#function, error?.localizedDescription ?? "")
    }
}


