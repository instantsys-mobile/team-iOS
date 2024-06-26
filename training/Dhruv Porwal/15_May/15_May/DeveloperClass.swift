class DeveloperClass: ProtocolForDelegate {
    
    // var managerReference: ManagerClass?
    
    func addsTowNumbers(result: Int) {
       
        print("Performing a chat operation. finally")
        
    }
    
}


class DeveloperClassA {
    
    // To return the result we would also need an instance of ManagerClass
    var managerRefernce : ManagerClassA?
    
    func developerPerform(a: Int, b: Int)
    {
        let result = a + b
        print(result)
        // After performing the function we have returned the result
        managerRefernce?.didFinishedTheTask(result: result)
        
        
    }
    
}
