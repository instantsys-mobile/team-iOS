
class TestingSubClass: TestingClass {
    
    var extraProperty = 10
    func filedComplaint(){
        print("Customer \(firstName) \(lastName) filed a complaint")
    }
    
    init(extraProperty: Int = 10, firstName: String, lastName: String) {
        super.init(firstName: firstName, lastName: lastName)
        self.extraProperty = extraProperty
    }
    
    override func usedNetBankingToPay() {
        
        super.usedNetBankingToPay() // We changed the functionality of super class and also used some of it
        
        print("Customer \(firstName) \(lastName) specifically used Bank to Bank Transfer method")
    }
    
}

// Apples most basic class is NSObject -> Next Step simplest and most generic
// UIResponder has been built upon it
// UIView is built upon UIResponder
// UIControl is built upon top of that
// UIButton is built upon top of that
