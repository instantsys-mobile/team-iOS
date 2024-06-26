class TestingClass {
    var firstName = "CustomerFirstName"
    var lastName = "CustomerLastName"
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    init(){}
    
    func usedCreditCardToPay() {
        print("Customer \(firstName) \(lastName) Used Credit Card To Pay")
    }
    
    func usedDebitCardToPay() {
        print("Customer \(firstName) \(lastName)  Used Debit Card To Pay")
    }
    
    func usedNetBankingToPay() {
        print("Customer \(firstName) \(lastName)  Used Net Banking To Pay")
    }
    
}
