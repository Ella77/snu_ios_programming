
import Foundation
import CoreBluetooth

class BluetoothCentral {
    enum State {
        case poweredOn
        case unavailable
    }
    
    var didUpdateStateHandler: ((BluetoothCentral, State) -> ())?
    var didReceivedDataHandler: ((_ localName: String?, _ rssi: Int64, _ powerLevel: Double?) -> ())?
    var currentState: State = .unavailable
    var isScanning: Bool {
        return manager?.isScanning ?? false
    }
    
    private var uuid: CBUUID!
    private var delegator: BluetoothCentralDelegator!
    private var manager: CBCentralManager?
    
    convenience init(uuid: String) {
        self.init()
        
        self.uuid = CBUUID(string: uuid)
        delegator = BluetoothCentralDelegator()
    }
    
    func initialize() {
        if manager == nil {
            manager = CBCentralManager(delegate: delegator, queue: nil, options: [CBCentralManagerOptionShowPowerAlertKey: false])
            setupAction()
        }
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
        delegator.didReceivedData = { [weak self] peripheral, data, rssi in
            self?.stop()
            self?.didReceivedDataHandler?(peripheral.name,
                                          rssi.int64Value,
                                          data[CBAdvertisementDataTxPowerLevelKey] as? Double)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                self?.scan(allowDuplicate: false)
            }
        }
    }
    
    func scan(allowDuplicate: Bool = true) {
        if manager == nil { fatalError("required call initialize()") }
        guard let uuid = uuid, !isScanning else { return }
        manager?.scanForPeripherals(withServices: [uuid], options: [CBCentralManagerScanOptionAllowDuplicatesKey: allowDuplicate])
    }
    
    func stop() {
        if manager == nil { fatalError("required call initialize()") }
        manager?.stopScan()
    }
}

private class BluetoothCentralDelegator: NSObject, CBCentralManagerDelegate {
    fileprivate var didUpdateState: ((CBCentralManager) -> ())?
    fileprivate var didReceivedData: ((CBPeripheral, [String : Any], NSNumber) -> ())?
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        didUpdateState?(central)
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        didReceivedData?(peripheral, advertisementData, RSSI)
    }
}

