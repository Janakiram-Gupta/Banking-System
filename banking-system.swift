import Foundation

class bankingSystem {
    var accNumb : Int
    var accName : String
    var accYear : Int
    var accGender : String
    var accType : String
    var accBalance : Double
    
    init(accNumb : Int, accName : String, accYear : Int, accGender : String , accType : String, accBalance : Double) {
        self.accNumb = accNumb
        self.accName = accName
        self.accYear = accYear
        self.accGender = accGender
        self.accType = accType
        self.accBalance = accBalance
    }
    
    func printDetails(){
        print("Hi your account has been created successfully. Your account number is :\n\n\(self.accNumb)\n")
    }
}

var customersDetails = [bankingSystem]()

// method to generate account number while creating a new bank account
func generateAccountNumber() -> Int {
    return Int.random(in: 1000000000..<5000000000)
}

// function for displaying initial details when customer enters into banking system to perform operations on his account
func displayAccountDetails(accNumber: Int){
    for eachCustomer in customersDetails {
        if eachCustomer.accNumb == accNumber {
            print("\nHi \(eachCustomer.accName). Welcome to banking system. Your account details are as follows : ")
            print("Account Type - \(eachCustomer.accType) Account")
        }
    }
}

// method which validates whether customer entered account number exists in banking system database or not
func checkIfBankAccountExists(inputNumber: Int) -> String{
    var flagVal : String = ""
    for eachCustomer in customersDetails {
        if inputNumber == eachCustomer.accNumb {
            flagVal = "exists"
            break
        } else {
            flagVal = "not-exists"
        }
    }
    return flagVal
}

//method used to update account balance during deposit, withdraw and tansfer
func updateAccountBalance(accNumber: Int, operationType : String, enteredAmount : Double){
    var updatedBalance : Double = 0.0
    for eachCustomer in customersDetails {
        if eachCustomer.accNumb == accNumber {
            if operationType == "add" {
                eachCustomer.accBalance = eachCustomer.accBalance + enteredAmount
                //updating balance after operation is successful
                updatedBalance = eachCustomer.accBalance
            } else if operationType == "subtract" {
                if eachCustomer.accBalance > enteredAmount {
                    eachCustomer.accBalance = eachCustomer.accBalance - enteredAmount
                    //updating balance after operation is successful
                    updatedBalance = eachCustomer.accBalance
                } else {
                    print("Entered amount is greater than your account balance i.e. \(eachCustomer.accBalance)")
                }
            }
        }
    }
    print("Account Number - \(accNumber) updated balance is : \(updatedBalance)")
}

// function for displaying account details for reference
func showYourAccountAllDetails(accNumber: Int){
    print("**************************************************************\n")
    for eachCustomer in customersDetails {
        if eachCustomer.accNumb == accNumber {            
			print("Account Number - \(accNumber) \nAccount Holder Name - \(eachCustomer.accName) \nYear of Birth - \(eachCustomer.accYear) \nGender - \(eachCustomer.accGender) \nAccount type - \(eachCustomer.accType) \nCurrent Balance - \(eachCustomer.accBalance)")
        }
    }
    print("\n**************************************************************\n")
}

// function that handles while updating Bank Account details
func updateBankAccountDetails(accNumber: Int){
    print("\nPlease select which field you want to update from below list ")
    print("**************************************************************\n")
    print("1. Name \n2. Year of birth \n3. Gender \n4. Account type\n")
    let selOption = Int(readLine()!)!
    
    switch selOption {
        case 1:
            print("Enter your new name : ", terminator: "")
            let updatedName = readLine()!
            
            for eachCustomer in customersDetails {
                if eachCustomer.accNumb == accNumber {            
        			eachCustomer.accName = updatedName
                }
            }
            
        case 2:
            print("Enter your new Year of birth : ", terminator: "")
            let updatedYearOfBirth = Int(readLine()!)!
            
            for eachCustomer in customersDetails {
                if eachCustomer.accNumb == accNumber {            
        			eachCustomer.accYear = updatedYearOfBirth
                }
            }
            
        case 3:
            print("Enter your updated Gender (Male or Female): ", terminator: "")
            let updatedGender = readLine()!
            
            for eachCustomer in customersDetails {
                if eachCustomer.accNumb == accNumber {            
        			eachCustomer.accGender = updatedGender
                }
            }
        case 4:
            print("Please select the account type \n1. Current Acccount 2. Savings Account")
            let selectedUpdatedAccountType = Int(readLine()!)!
            var updatedAccountType = ""
            if selectedUpdatedAccountType == 1{
                updatedAccountType = "Current"
            } else if selectedUpdatedAccountType == 2{
                updatedAccountType = "Savings"
            }
            
            for eachCustomer in customersDetails {
                if eachCustomer.accNumb == accNumber {            
        			eachCustomer.accType = updatedAccountType
                }
            }
        default:
            print("Irrelevant option has been selected")    
    }
    print("Your details have been updated. Displaying your account details below for reference\n")
    showYourAccountAllDetails(accNumber: accNumber)
}

// function to handle banking system operations
func handleBankOperations(accNumber: Int, selInput : Int){
    
    switch selInput {
        case 1:
            print("Below is all your account details for reference")
            showYourAccountAllDetails(accNumber: accNumber)
            updateBankAccountDetails(accNumber: accNumber)
        case 2:
            var currentBalanceVal : Double = 0.0
            for eachCustomer in customersDetails {
                if eachCustomer.accNumb == accNumber {
                    currentBalanceVal = eachCustomer.accBalance
                }
            }
            print("Your current balance is : \(currentBalanceVal)")
            
        case 3:
            print("Please enter amount to deposit money into your account : ", terminator: "")
            updateAccountBalance(accNumber: accNumber, operationType : "add", enteredAmount : Double(readLine()!)!)
        case 4:
            print("Please enter amount to withdraw money from your account : ", terminator: "")
            updateAccountBalance(accNumber: accNumber, operationType : "subtract", enteredAmount : Double(readLine()!)!)
        case 5:
            print("Please enter account number to the account you want to transfer your funds : ", terminator: "")
            let enteredVal = Int(readLine()!)!
            
            if accNumber == enteredVal {
                print("Sorry. from-account and to-account cannot be same. self transfer is not valid")
            } else {
                let checkAccountExists = checkIfBankAccountExists(inputNumber: enteredVal)
                if checkAccountExists == "exists" {
                    print("\nPlease enter amount you want to transfer : ", terminator: "")
                    // transfering the amount in to-account
                    updateAccountBalance(accNumber: enteredVal, operationType : "add", enteredAmount : Double(readLine()!)!)
                    // deducting amount in from-account
                    updateAccountBalance(accNumber: accNumber, operationType : "subtract", enteredAmount : Double(readLine()!)!)
                } else if checkAccountExists == "not-exists" {
                    print("Sorry your entered account number - \(enteredVal) does not exists in our database.")
                }
            }
            
        case 6:
            print("You have a electricity bill to pay of amount 1250. Would you like to pay your pending utility bill ? yes/no")
            if readLine()! == "yes" {
                updateAccountBalance(accNumber: accNumber, operationType : "subtract", enteredAmount : 1250.0)
            } else {
                print("Have a nice day.")
            }
        default:
            print("Wrong input has been entered")
    }
}

// Banking system starts from here

print("Hi sir, Would you like to create a account in our bank ? yes/no")
if readLine()! == "yes" {
    repeat{
        // If customer selects yes then he can create account............. logic starts here
            print("\nWe require basic details about the account holder. Please enter the following details : ")
            print("*******************************************************************************************\n")
            
            print("Enter the Account holder Name : ", terminator: "")
            let accName = readLine()!
            print("Enter the Account holder Year of birth : ", terminator: "")
            let Year = Int(readLine()!)!
            print("Enter the Account holder Gender (Male or Female) : ", terminator: "")
            let accGender = readLine()!
            print("Please select the account type \n1. Current Acccount 2. Savings Account")
            var accType = ""
            if Int(readLine()!)! == 1{
                accType = "Current"
            } else if Int(readLine()!)! == 1{
                accType = "Savings"
            }
            
            print("\nNote : As per the terms and policies of our bank, Its mandatory to deposit atleast $2000 in your account as opening balance if you are new customer\n")
            var accBalance = 2000.0
            print("Would you like to deposit any other money in your account ? yes/no : ", terminator: "")
            if readLine()! == "yes" {
                print("Please enter the amount to deposit : ", terminator: "")
                accBalance += Double(readLine()!)!
            }
            let acntNumb = generateAccountNumber()
            customersDetails.append(bankingSystem(accNumb : acntNumb, accName : accName, accYear : Year, accGender : accGender , accType : accType, accBalance : accBalance))
            bankingSystem(accNumb : acntNumb, accName : accName, accYear : Year, accGender : accGender , accType : accType, accBalance : accBalance).printDetails()
            
        print("Do you want to open/create another account in our bank ? yes/no")
    } while(readLine()! == "yes")
} else {
    print("Thank you so much for approaching to our banking services. Have a nice day !!")
}

// logic where banking system operations starts

print("\nWould you like to perform any operations on your bank account ? yes/no")
let userOption = readLine()!
if userOption == "yes" {
    repeat{
        print("Please enter your account number : ")
        let entrdAccNumb = Int(readLine()!)!
        
        let checkFlag = checkIfBankAccountExists(inputNumber: entrdAccNumb)
        if checkFlag == "exists" {
            displayAccountDetails(accNumber: entrdAccNumb)
            repeat{
                print("\nPlease select any option you would like to perform from below ")
                print("********************************************************************\n")
                print("1. Update your details \n2. Display your current balance \n3. Deposit money \n4. Draw money \n5. Transfer money to other accounts within the bank \n6. Pay utility bills\n")
                handleBankOperations(accNumber: entrdAccNumb, selInput :Int(readLine()!)!)
                
                print("\nWant to perform more operations on your bank account - \(entrdAccNumb) ? yes/no")
            } while(readLine()! == "yes")
        } else if checkFlag == "not-exists" {
            print("Your entered account number is not valid.")
                
            print("\nDo you want to perform any other operations on your bank account ? yes/no")
        }
    } while(readLine()! == "yes")
} else {
    print("OK Thank you !!!")
}