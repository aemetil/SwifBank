// Write your code below 🏦
struct SwiftBank {
   // Using a property observer on the balance property
  private var balance: Double = 0 {
  // Call the method to display a low balance warning if the balance is below $100
    didSet {
      if balance < 100 {
        displayLowBalanceMessage()
      }
    }
  }
  static let depositBonusRate = 0.01
  private let password: String

  init(password: String, initialDeposit: Double){
    self.password = password
    makeDeposit(ofAmount: initialDeposit)
  }
  //check password & authorized access or not
  private func isValid(enteredPassword: String) -> Bool {
    return enteredPassword == password
  }

  //display the current balance
  func displayBalance(usingPassword password: String) {
    if isValid(enteredPassword: password) {
      print("Your current balance is $\(balance)")
    } else {
      print("Error: Invalid password. Cannot retrieve balance.")
      return
    }
  }

  //calculate the total deposit amount w/ bonus
  private func finalDepositWithBonus(fromInitialDeposit deposit: Double) -> Double {
    return (deposit * SwiftBank.depositBonusRate) + deposit
  }
  //Handle deposit and notify user
  mutating func makeDeposit(ofAmount depositAmount: Double) {
    //update - deposit with bonus only if deposit >= 1000
    if depositAmount >= 1000 {
      let depositWithBonus = finalDepositWithBonus( fromInitialDeposit: depositAmount)
      print("Making a deposit of $\(depositAmount) with a bonus rate. The final amount deposited is $\(depositWithBonus).")
      self.balance +=  depositWithBonus

    } else if depositAmount <= 0.0 {
      print("Error: the deposit amount is invalid")
    } else {
      print("Making a deposit of $\(depositAmount)")
      self.balance += depositAmount
    }
    
  }
  // Method to make a withdrawal using the password
  mutating func makeWithDrawal(ofAmount withDrawalAmount: Double, usingPassword password: String) {
    // Check if the password is valid
    if !isValid(enteredPassword: password) {
      print("Error: Invalid password. Cannot make withdrawal.")
      return
    } else if withDrawalAmount <= 0 {
      print("Error: Invalid amount withdrawal")
      return
    } else if balance < withDrawalAmount {
       // Check if the balance is sufficient
      print ("You're current balance is $\(balance) & Your balance is not sufficient to make a withdrawal of $\(withDrawalAmount)")
      return
    } else {
      // Perform the withdrawal and display the withdrawn amount
      balance -= withDrawalAmount
      print("Making a $\(withDrawalAmount) withdrawal")
    }
  }
    
  // Private method to display a message when the balance is low
  private func displayLowBalanceMessage() {
    print("Alert: Your balance is under $100")
  }
}

//Using example
var myAccount = SwiftBank(password: "truePassword", initialDeposit: -1)

myAccount.makeDeposit(ofAmount: 500)
myAccount.makeDeposit(ofAmount: 50)
//myAccount.displayBalance(usingPassword: "truePassword")

// Withdrawal with incorrect password
myAccount.makeWithDrawal(ofAmount: 100, usingPassword: "falsePassword")

//Withdrawal with insufficient balance
myAccount.makeWithDrawal(ofAmount: 1000, usingPassword: "truePassword")

//new feature deposit & bonus
myAccount.makeDeposit(ofAmount: 1000)

//checking our balance 
myAccount.displayBalance(usingPassword: "truePassword")
