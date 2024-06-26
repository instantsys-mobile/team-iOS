
class ManagerClass {

    // On adding weak keyword this program is not working why?
   weak var delegate: ProtocolForDelegate? // whenever delegate is not used then flush its memory i.e. make it nil to avoid memory leak and retain cycles
    
    // weak and strong can only be used with classes
    
    init(_delegate: DeveloperClass) {
        self.delegate = _delegate
    }
    
    func addsTowNumbers() {
        self.delegate?.addsTowNumbers(result: 10)
    }

}


class ManagerClassA {
    
    // We created an instance of DeveloperClassA here to get the result from DeveloperClassA
    
    var developer: DeveloperClassA?
    
    init(_developer: DeveloperClassA) {
        self.developer = _developer // first we assigned the developer then we would assign the manager of that developer to self in here to complete the cycle
        
        self.developer?.managerRefernce = self // we hace completed the circle/ linkage by adding setting managerReferance back to self
    }
    //  Here, developer?.managerReferance = self is a line that establishes a reverse delegation relationship between the ManagerClassA and DeveloperClassA instances.
    
    func didFinishedTheTask(result: Int) {
        debugPrint("result of data is \(result)")
    }
    
    func addTwoNumber(x:Int, y:Int) {
        self.developer?.developerPerform(a: x, b: y)
    }
}


