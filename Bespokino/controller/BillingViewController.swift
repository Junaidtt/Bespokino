//
//  BillingViewController.swift
//  Bespokino
//
//  Created by Bespokino on 1/12/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit
import BEMCheckBox
import GooglePlaces
import AcceptSDK
import SVProgressHUD
import PassKit

//payment properties

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}

fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l >= r
    default:
        return !(lhs < rhs)
    }
}

fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l <= r
    default:
        return !(rhs < lhs)
    }
}

let reachability = Reachability();

var ccPayAmt = Payment.ccPay
var desc:String?
var tocken:String?

let kClientName = "785d4yCQ47"
let kClientKey  = "93v555Vx94fahCX2HTe5WrWb4ebT9xqt97DP3CZ5qszVH533xq9AGdn9vuBmyUGL"

let kAcceptSDKDemoCreditCardLength:Int = 16
let kAcceptSDKDemoCreditCardLengthPlusSpaces:Int = (kAcceptSDKDemoCreditCardLength + 3)
let kAcceptSDKDemoExpirationLength:Int = 4
let kAcceptSDKDemoExpirationMonthLength:Int = 2
let kAcceptSDKDemoExpirationYearLength:Int = 2
let kAcceptSDKDemoExpirationLengthPlusSlash:Int = kAcceptSDKDemoExpirationLength + 1
let kAcceptSDKDemoCVV2Length:Int = 4

let kAcceptSDKDemoCreditCardObscureLength:Int = (kAcceptSDKDemoCreditCardLength - 4)

let kAcceptSDKDemoSpace:String = " "
let kAcceptSDKDemoSlash:String = "/"

var activeTextField = UITextField()
let asyncTask  = AsyncTask()
var customer = [Invoice]()

class BillingViewController: UIViewController ,BEMCheckBoxDelegate,GMSAutocompleteViewControllerDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,PKPaymentAuthorizationViewControllerDelegate{
  //apple pay properties
    @objc let SupportedPaymentNetworks = [PKPaymentNetwork.visa, PKPaymentNetwork.masterCard, PKPaymentNetwork.amex]
    private let applePayMerchantId = "merchant.com.innovationm.applepaydemo"
   //Patment vairiables
    @IBOutlet weak var totalAmount: UILabel!

    //@IBOutlet weak var cardNameTextField: UITextField!
    @IBOutlet weak var cardNumberTextField:UITextField!
    @IBOutlet weak var expirationMonthTextField:UITextField!
    @IBOutlet weak var expirationYearTextField:UITextField!
    @IBOutlet weak var cardVerificationCodeTextField:UITextField!
    
    @IBOutlet weak var getTokenButton: UIButton!
    
    @IBOutlet weak var activityIndicatorAcceptSDKDemo:UIActivityIndicatorView!
    @IBOutlet weak var textViewShowResults:UITextView!
    @IBOutlet weak var headerView:UIView!
    
    fileprivate var cardNumber:String!
    fileprivate var cardExpirationMonth:String!
    fileprivate var cardExpirationYear:String!
    fileprivate var cardVerificationCode:String!
    fileprivate var cardNumberBuffer:String!
    
    var activeTF = UITextField()
    var size = ["01-Jan","02-Feb","03-Mar","04-Apr","05-May","06-Jun","07-Jul","08-Aug","09-Sep","10-Oct","11-Nov","12-Dec"]
    var month = ["01","02","03","04","05","06","07","08","09","10","11","12"]
    
    var year = ["2017","2018","2019","2020","2021","2022","2023","2024","2025","2026","2027","2028"]
    var yr = ["17","18","19","20","21","22","23","24","25","26","27","28"]
    
    var data = [String]()
    let picker = UIPickerView()
    
    

    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var streetAddressText: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipTextField: UITextField!
   // @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var checkmark: BEMCheckBox!
    @IBOutlet weak var continueButton: UIButton!
    var checkmarkSelected:Bool = false
    
    var customer = [Invoice]()
    
    var street_number = ""
    var route = ""
    var neighborhood = ""
    var locality = ""
    var administrative_area_level_1  = ""
    var country = ""
    var postal_code = ""
    var postal_code_suffix = ""
    var activeTextField = UITextField()
    @IBOutlet weak var getYourAddressButton: UIButton!
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        self.navigationItem.title = "BESPOKINO"
       // continueButton.layer.cornerRadius = 5
       // continueButton.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        checkmark.delegate = self
       //self.setDataInTextField()
        
        getYourAddressButton.layer.borderWidth = 1.0
        getYourAddressButton.layer.borderColor = #colorLiteral(red: 1, green: 0.8000000119, blue: 0.400000006, alpha: 1)
        
        
        let yesData = defaults.bool(forKey: "USERINFO")
        if yesData{
            self.firstNameText.text = defaults.string(forKey: "FIRSTNAME")
            self.lastNameText.text = defaults.string(forKey: "LASTNAME")
//            self.cellNumberText.text = defaults.string(forKey: "CELLNUMBER")
            self.streetAddressText.text = defaults.string(forKey: "ADDRESS")
            self.stateTextField.text = defaults.string(forKey: "STATE")
            self.zipTextField.text = defaults.string(forKey: "ZIP")
//
        }
        let rightBarButton = UIBarButtonItem(title: "Home", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.myRightSideBarButtonItemTapped(_:)))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        
        //payment
        
      //  ccPayAmt = Payment.ccPay!
       // print(ccPayAmt!)
        // print(Customer.firstName!)
        // print(Customer.lastName!)
        picker.delegate = self
        picker.dataSource = self
        
        
        // cardNameTextField.text = "\(String(describing: Customer.firstName!)) \(String(describing: Customer.lastName!))"
        
        
        
        expirationMonthTextField.inputView = picker
        expirationYearTextField.inputView = picker
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        //  self.headerView.backgroundColor = UIColor.init(red: 48.0/255.0, green: 85.0/255.0, blue: 112.0/255.0, alpha: 1.0)
        self.setUIControlsTagValues()
        self.initializeUIControls()
        self.initializeMembers()
        
        self.updateTokenButton(false)
        
        let toolbarDone = UIToolbar.init()
        toolbarDone.sizeToFit()
        let barBtnDone = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.done,
                                              target: self, action: #selector(doneButton_Clicked))
        
        
        toolbarDone.items = [barBtnDone] // You can even add cancel button too
        expirationMonthTextField.inputAccessoryView = toolbarDone
        expirationYearTextField.inputAccessoryView = toolbarDone
        
        //self.totalAmount.text = "$\(String(format: "%.2f", Payment.ccPay!))"
    
    }
    
    
    @IBAction func getYourAddressDidTap(_ sender: Any) {
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        // Set a filter to return only addresses.
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        autocompleteController.autocompleteFilter = filter
        
        present(autocompleteController,animated: true, completion: nil)
        
    }
    
    func setDataInTextField()  {

        
       // self.firstNameText.text = Customer.firstName!
        self.firstNameText.text = customer[0].firstName
        self.lastNameText.text = customer[0].lastName
        // self.lastNameText.text = Customer.lastName!
        self.streetAddressText.text = customer[0].address
        self.cityTextField.text = customer[0].city
       // self.stateTextField.text = customer[0].state
        self.zipTextField.text = customer[0].zip
      //  self.countryTextField.text = customer[0].country
        
        
        
    }

    func didTap(_ checkBox: BEMCheckBox) {
        
        print(checkBox.on)
        self.checkmarkSelected = checkBox.on
        
    }
    @IBAction func continueButtonDidTap(_ sender: Any) {
        
       print(checkmark.isSelected)
        
        if checkmarkSelected{
            
//            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ConfirmPayViewController") as! ConfirmPayViewController
//            //newViewController.shipping = self.customer
//            self.navigationController?.pushViewController(newViewController, animated: true)
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ConfirmPayViewController") as! ConfirmPayViewController
            //  newViewController.shipping = self.customer
           // self.present(newViewController, animated: true, completion: nil)
            self.navigationController?.pushViewController(newViewController, animated: true)
        }else{
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ConfirmPayViewController") as! ConfirmPayViewController
          //  newViewController.shipping = self.customer
          //  self.present(newViewController, animated: true, completion: nil)

            self.navigationController?.pushViewController(newViewController, animated: true)
        
        }
    }
    
    @objc func myRightSideBarButtonItemTapped(_ sender:UIBarButtonItem!)
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        
        
        self.present(newViewController, animated: true, completion: nil)
      //  self.navigationController?.pushViewController(newViewController, animated: true)
    }

    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        // Print place info to the console.
        print("Place name: \(place.name)")
        print("Place address: \(String(describing: place.formattedAddress))")
        print("Place attributions: \(String(describing: place.attributions))")
        
        // TODO: Add code to get address components from the selected place.
        
        // Get the address components.
        if let addressLines = place.addressComponents {
            // Populate all of the address fields we can find.
            for field in addressLines {
                switch field.type {
                case kGMSPlaceTypeStreetNumber:
                    street_number = field.name
                case kGMSPlaceTypeRoute:
                    route = field.name
                case kGMSPlaceTypeNeighborhood:
                    neighborhood = field.name
                case kGMSPlaceTypeLocality:
                    locality = field.name
                case kGMSPlaceTypeAdministrativeAreaLevel1:
                    administrative_area_level_1 = field.name
                case kGMSPlaceTypeCountry:
                    country = field.name
                case kGMSPlaceTypePostalCode:
                    postal_code = field.name
                case kGMSPlaceTypePostalCodeSuffix:
                    postal_code_suffix = field.name
                // Print the items we aren't using.
                default:
                    print("Type: \(field.type), Name: \(field.name)")
                }
            }
        }
        
        // Call custom function to populate the address form.
        fillAddressForm()
        // Close the autocomplete widget.
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Show the network activity indicator.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    // Hide the network activity indicator.
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        activeTextField = textField
        
        switch activeTextField {
        case firstNameText:
            lastNameText.becomeFirstResponder()
        case lastNameText:
            streetAddressText.becomeFirstResponder()
        case streetAddressText:
            cityTextField.becomeFirstResponder()
        case cityTextField:
            zipTextField.becomeFirstResponder()
        case zipTextField:
            stateTextField.becomeFirstResponder()
        default:
            print("No text field selected")
        }
        
        
        return false
    }
    
    // Populate the address form fields.
    func fillAddressForm() {
        streetAddressText.text = street_number + " " + route
        cityTextField.text = locality
        cityTextField.text = administrative_area_level_1
        if postal_code_suffix != "" {
            zipTextField.text = postal_code + "-" + postal_code_suffix
        } else {
            zipTextField.text = postal_code
        }
        // countryTF.text = country
        
        // Clear values for next time.
        street_number = ""
        route = ""
        neighborhood = ""
        locality = ""
        administrative_area_level_1  = ""
        country = ""
        postal_code = ""
        postal_code_suffix = ""
    }
    
    
    
    
    
    
    @objc func doneButton_Clicked() {
        expirationMonthTextField.resignFirstResponder()
        expirationYearTextField.becomeFirstResponder()
    }
    
    func setUIControlsTagValues() {
        self.cardNumberTextField.tag = 1
        self.expirationMonthTextField.tag = 2
        self.expirationYearTextField.tag = 3
        self.cardVerificationCodeTextField.tag = 4
    }
    
    func initializeUIControls() {
        self.cardNumberTextField.text = ""
        self.expirationMonthTextField.text = ""
        self.expirationYearTextField.text = ""
        self.cardVerificationCodeTextField.text = ""
        self.textChangeDelegate(self.cardNumberTextField)
        self.textChangeDelegate(self.expirationMonthTextField)
        self.textChangeDelegate(self.expirationYearTextField)
        self.textChangeDelegate(self.cardVerificationCodeTextField)
        
        self.cardNumberTextField.delegate = self
        self.expirationMonthTextField.delegate = self
        self.expirationYearTextField.delegate = self
        self.cardVerificationCodeTextField.delegate = self
    }
    
    func initializeMembers() {
        self.cardNumber = nil
        self.cardExpirationMonth = nil
        self.cardExpirationYear = nil
        self.cardVerificationCode = nil
        self.cardNumberBuffer = ""
    }
    
    func darkBlueColor() -> UIColor {
        let color = UIColor.init(red: 51.0/255.0, green: 102.0/255.0, blue: 153.0/255.0, alpha: 1.0)
        return color
    }
    
    @IBAction func getTokenButtonTapped(_ sender: AnyObject) {
        // self.activityIndicatorAcceptSDKDemo.startAnimating()
        let checkInternet = CheckInternetConnection()
        
        
        
        if checkInternet.isConnectedToNetwork(){
            SVProgressHUD.show()
            self.updateTokenButton(false)
            
            self.getToken()
            
        }else{
            
            self.displayAlert()
            
        }
        
    }
    
    @IBAction func backButtonButtonTapped(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func updateTokenButton(_ isEnable: Bool) {
        self.getTokenButton.isEnabled = isEnable
        if isEnable {
            self.getTokenButton.backgroundColor = UIColor.init(red: 48.0/255.0, green: 85.0/255.0, blue: 112.0/255.0, alpha: 1.0)
        } else {
            self.getTokenButton.backgroundColor = UIColor.init(red: 48.0/255.0, green: 85.0/255.0, blue: 112.0/255.0, alpha: 0.2)
        }
    }
    
    func getToken() {
        
        let handler = AcceptSDKHandler(environment: AcceptSDKEnvironment.ENV_LIVE)
        
        let request = AcceptSDKRequest()
        request.merchantAuthentication.name = kClientName
        request.merchantAuthentication.clientKey = kClientKey
        
        request.securePaymentContainerRequest.webCheckOutDataType.token.cardNumber = self.cardNumberBuffer
        request.securePaymentContainerRequest.webCheckOutDataType.token.expirationMonth = self.cardExpirationMonth
        request.securePaymentContainerRequest.webCheckOutDataType.token.expirationYear = self.cardExpirationYear
        request.securePaymentContainerRequest.webCheckOutDataType.token.cardCode = self.cardVerificationCode
        
        handler!.getTokenWithRequest(request, successHandler: { (inResponse:AcceptSDKTokenResponse) -> () in
            DispatchQueue.main.async(execute: {
                self.updateTokenButton(true)
                
                // self.activityIndicatorAcceptSDKDemo.stopAnimating()
                print("Token--->%@", inResponse.getOpaqueData().getDataValue())
                
                tocken = inResponse.getOpaqueData().getDataValue()
                desc = inResponse.getOpaqueData().getDataDescriptor()
                self.postPaymentTask()
                var output = String(format: "Response: %@\nData Value: %@ \nDescription: %@", inResponse.getMessages().getResultCode(), inResponse.getOpaqueData().getDataValue(), inResponse.getOpaqueData().getDataDescriptor())
                output = output + String(format: "\nMessage Code: %@\nMessage Text: %@", inResponse.getMessages().getMessages()[0].getCode(), inResponse.getMessages().getMessages()[0].getText())
                // self.textViewShowResults.text = output
                // self.textViewShowResults.textColor = UIColor.green
                
            })
        }) { (inError:AcceptSDKErrorResponse) -> () in
            //self.activityIndicatorAcceptSDKDemo.stopAnimating()
            self.updateTokenButton(true)
            
            let output = String(format: "Response:  %@\nError code: %@\nError text:   %@", inError.getMessages().getResultCode(), inError.getMessages().getMessages()[0].getCode(), inError.getMessages().getMessages()[0].getText())
            // self.textViewShowResults.text = output
            // self.textViewShowResults.textColor = UIColor.red
            print(output)
        }
    }
    
    func scrollTextViewToBottom(_ textView:UITextView) {
        if(textView.text.characters.count > 0 )
        {
            let bottom = NSMakeRange(textView.text.characters.count-1, 1)
            textView.scrollRangeToVisible(bottom)
        }
    }
    
    func updateTextViewWithMessage(_ message:String) {
        if message.characters.count > 0 {
            // self.textViewShowResults.text = self.textViewShowResults.text + message
            // self.textViewShowResults.text = self.textViewShowResults.text + "\n"
        } else {
            // self.textViewShowResults.text = self.textViewShowResults.text + "Empty Message\n"
        }
        
        // self.scrollTextViewToBottom(self.textViewShowResults)
    }
    
    @IBAction func hideKeyBoard(_ sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    func formatCardNumber(_ textField:UITextField) {
        var value = String()
        
        if textField == self.cardNumberTextField {
            let length = self.cardNumberBuffer.characters.count
            
            for (i, _) in self.cardNumberBuffer.characters.enumerated() {
                
                // Reveal only the last character.
                if (length <= kAcceptSDKDemoCreditCardObscureLength) {
                    if (i == (length - 1)) {
                        let charIndex = self.cardNumberBuffer.index(self.cardNumberBuffer.startIndex, offsetBy: i)
                        let tempStr = String(self.cardNumberBuffer.characters.suffix(from: charIndex))
                        //let singleCharacter = String(tempStr.characters.first)
                        
                        value = value + tempStr
                    } else {
                        value = value + "●"
                    }
                } else {
                    if (i < kAcceptSDKDemoCreditCardObscureLength) {
                        value = value + "●"
                    } else {
                        let charIndex = self.cardNumberBuffer.index(self.cardNumberBuffer.startIndex, offsetBy: i)
                        let tempStr = String(self.cardNumberBuffer.characters.suffix(from: charIndex))
                        //let singleCharacter = String(tempStr.characters.first)
                        //let singleCharacter = String(tempStr.characters.suffix(1))
                        
                        value = value + tempStr
                        break
                    }
                }
                
                //After 4 characters add a space
                if (((i + 1) % 4 == 0) && (value.characters.count < kAcceptSDKDemoCreditCardLengthPlusSpaces)) {
                    value = value + kAcceptSDKDemoSpace
                }
            }
        }
        
        textField.text = value
    }
    
    func isMaxLength(_ textField:UITextField) -> Bool {
        var result = false
        
        if (textField.tag == self.cardNumberTextField.tag && textField.text?.characters.count > kAcceptSDKDemoCreditCardLengthPlusSpaces)
        {
            result = true
        }
        
        if (textField == self.expirationMonthTextField && textField.text?.characters.count > kAcceptSDKDemoExpirationMonthLength)
        {
            result = true
        }
        
        if (textField == self.expirationYearTextField && textField.text?.characters.count > kAcceptSDKDemoExpirationYearLength)
        {
            result = true
        }
        if (textField == self.cardVerificationCodeTextField && textField.text?.characters.count > kAcceptSDKDemoCVV2Length)
        {
            result = true
        }
        
        return result
    }
    
    
    // MARK:
    // MARK: UITextViewDelegate delegate methods
    // MARK:
    
    func textFieldDidBeginEditing(_ textField:UITextField) {
        
      //  activeTextField = self.cardNameTextField
        self.activeTF = textField
    }
    
    func textFieldShouldBeginEditing(_ textField:UITextField) -> Bool {
        
        
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let result = true
        
        let str = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
//
//        if textField == cardNameTextField{
//
//            let allowedCharacters = CharacterSet.letters
//            let characterSet = CharacterSet(charactersIn:string)
//            return allowedCharacters.isSuperset(of: characterSet)
//
//        }
        
        switch (textField.tag)
        {
        case 1:
            if (string.characters.count > 0)
            {
                if (self.isMaxLength(textField)) {
                    return false
                }
                
                self.cardNumberBuffer = String(format: "%@%@", self.cardNumberBuffer, string)
            }
            else
            {
                if (self.cardNumberBuffer.characters.count > 1)
                {
                    let length = self.cardNumberBuffer.characters.count - 1
                    
                    //self.cardNumberBuffer = self.cardNumberBuffer[self.cardNumberBuffer.index(self.cardNumberBuffer.startIndex, offsetBy: 0)...self.cardNumberBuffer.index(self.cardNumberBuffer.startIndex, offsetBy: length-1)]
                    
                    self.cardNumberBuffer = String(self.cardNumberBuffer[self.cardNumberBuffer.index(self.cardNumberBuffer.startIndex, offsetBy: 0)...self.cardNumberBuffer.index(self.cardNumberBuffer.startIndex, offsetBy: length - 1)])
                }
                else
                {
                    self.cardNumberBuffer = ""
                }
            }
            self.formatCardNumber(textField)
            return false
        case 2:
            
            if (string.characters.count > 0) {
                if (self.isMaxLength(textField)) {
                    return false
                }
            }
            
            break
        case 3:
            
            if (string.characters.count > 0) {
                if (self.isMaxLength(textField)) {
                    return false
                }
            }
            
            break
        case 4:
            
            if (string.characters.count > 0) {
                if (self.isMaxLength(textField)) {
                    return false
                }
            }
            
            break
            
        default:
            break
        }
        
        return result
    }
    
    func validInputs() -> Bool {
        var inputsAreOKToProceed = false
        
        let validator = AcceptSDKCardFieldsValidator()
        
        if (validator.validateSecurityCodeWithString(self.cardVerificationCodeTextField.text!) && validator.validateExpirationDate(self.expirationMonthTextField.text!, inYear: self.expirationYearTextField.text!) && validator.validateCardWithLuhnAlgorithm(self.cardNumberBuffer)) {
            inputsAreOKToProceed = true
        }
        
        return inputsAreOKToProceed
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let validator = AcceptSDKCardFieldsValidator()
        
        switch (textField.tag)
        {
            
        case 1:
            
            self.cardNumber = self.cardNumberBuffer
            
            let luhnResult = validator.validateCardWithLuhnAlgorithm(self.cardNumberBuffer)
            
            if ((luhnResult == false) || (textField.text?.characters.count < AcceptSDKCardFieldsValidatorConstants.kInAppSDKCardNumberCharacterCountMin))
            {
                self.cardNumberTextField.textColor = UIColor.red
            }
            else
            {
                self.cardNumberTextField.textColor = self.darkBlueColor() //[UIColor greenColor]
            }
            
            if (self.validInputs())
            {
                self.updateTokenButton(true)
            }
            else
            {
                self.updateTokenButton(false)
            }
            
            break
        case 2:
            self.validateMonth(textField)
            if let expYear = self.expirationYearTextField.text {
                self.validateYear(expYear)
            }
            
            break
        case 3:
            
            self.validateYear(textField.text!)
            
            break
        case 4:
            
            self.cardVerificationCode = textField.text
            
            if (validator.validateSecurityCodeWithString(self.cardVerificationCodeTextField.text!))
            {
                self.cardVerificationCodeTextField.textColor = self.darkBlueColor()
            }
            else
            {
                self.cardVerificationCodeTextField.textColor = UIColor.red
            }
            
            if (self.validInputs())
            {
                self.updateTokenButton(true)
            }
            else
            {
                self.updateTokenButton(false)
            }
            
            break
            
        default:
            break
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if (textField == self.cardNumberTextField)
        {
            self.cardNumberBuffer = String()
        }
        
        return true
    }
    
    func validateYear(_ textFieldText: String) {
        
        self.cardExpirationYear = textFieldText
        let validator = AcceptSDKCardFieldsValidator()
        
        let newYear = Int(textFieldText)
        if ((newYear >= validator.cardExpirationYearMin())  && (newYear <= AcceptSDKCardFieldsValidatorConstants.kInAppSDKCardExpirationYearMax))
        {
            self.expirationYearTextField.textColor = self.darkBlueColor() //[UIColor greenColor]
        }
        else
        {
            self.expirationYearTextField.textColor = UIColor.red
        }
        
        if (self.expirationYearTextField.text?.characters.count == 0)
        {
            return
        }
        if (self.expirationMonthTextField.text?.characters.count == 0)
        {
            return
        }
        if (validator.validateExpirationDate(self.expirationMonthTextField.text!, inYear: self.expirationYearTextField.text!))
        {
            self.expirationMonthTextField.textColor = self.darkBlueColor()
            self.expirationYearTextField.textColor = self.darkBlueColor()
        }
        else
        {
            self.expirationMonthTextField.textColor = UIColor.red
            self.expirationYearTextField.textColor = UIColor.red
        }
        
        if (self.validInputs())
        {
            self.updateTokenButton(true)
        }
        else
        {
            self.updateTokenButton(false)
        }
    }
    
    func validateMonth(_ textField: UITextField) {
        
        self.cardExpirationMonth = textField.text
        
        if (self.expirationMonthTextField.text?.characters.count == 1)
        {
            if ((textField.text == "0") == false) {
                self.expirationMonthTextField.text = "0" + self.expirationMonthTextField.text!
            }
        }
        
        let newMonth = Int(textField.text!)
        
        if ((newMonth >= AcceptSDKCardFieldsValidatorConstants.kInAppSDKCardExpirationMonthMin)  && (newMonth <= AcceptSDKCardFieldsValidatorConstants.kInAppSDKCardExpirationMonthMax))
        {
            self.expirationMonthTextField.textColor = self.darkBlueColor() //[UIColor greenColor]
            
        }
        else
        {
            self.expirationMonthTextField.textColor = UIColor.red
        }
        
        if (self.validInputs())
        {
            self.updateTokenButton(true)
        }
        else
        {
            self.updateTokenButton(false)
        }
    }
    
    func textChangeDelegate(_ textField: UITextField) {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UITextFieldTextDidChange, object: textField, queue: nil, using: { note in
            if (self.validInputs()) {
                self.updateTokenButton(true)
            } else {
                self.updateTokenButton(false)
            }
        })
    }
   
    
    func postPaymentTask() -> Void {
        
        
        
        struct Transaction: Codable {
            
            let createTransactionRequest: CreateTransactionRequest
            
        }
        
        struct CreateTransactionRequest: Codable {
            
            let merchantAuthentication: MerchantAuthentication
            let refId: String
            let transactionRequest: TransactionRequest
        }
        
        struct MerchantAuthentication: Codable {
            let name: String
            let transactionKey: String
        }
        
        struct TransactionRequest: Codable {
            let transactionType: String
            let amount: String
            
            let payment: Payment
        }
        struct Payment: Codable {
            
            let opaqueData: OpaqueData
        }
        struct OpaqueData: Codable {
            
            let dataDescriptor: String
            
            let dataValue: String
            
        }
        
        
        
        struct billTo:Codable{
            let firstName:String
            let lastName:String
            let company:String
            let address:String
            let state:String
            let zip:String
            let country:String
            
            
        }
        
        
        let opaqueData = OpaqueData(dataDescriptor: desc!, dataValue: tocken!)
        
        let payment  = Payment(opaqueData: opaqueData)
        
        let transactionRequest = TransactionRequest(transactionType: "authCaptureTransaction", amount: "\(ccPayAmt!)", payment: payment)
        
        let merchentAuthentication = MerchantAuthentication(name: "785d4yCQ47", transactionKey: "8Qm5kGEK2G28Z2n6")
        
        let createTransactionRequest = CreateTransactionRequest(merchantAuthentication: merchentAuthentication, refId: "123123", transactionRequest: transactionRequest)
        
        
        let transaction = Transaction(createTransactionRequest: createTransactionRequest)
        
        
        
        var postData: String {
            
            
            let ctr = createTransactionRequest
            let ma = ctr.merchantAuthentication
            let ctrtr = ctr.transactionRequest
            let od = ctrtr.payment.opaqueData
            return """
            { "createTransactionRequest":
            { "merchantAuthentication": { "name": "\(ma.name)", "transactionKey": "\(ma.transactionKey)" },
            "refId": "\(ctr.refId)",
            "transactionRequest": {"transactionType": "\(ctrtr.transactionType)", "amount": "\(ctrtr.amount)",
            "payment":
            { "opaqueData": {"dataDescriptor": "\(od.dataDescriptor)", "dataValue": "\(od.dataValue)" } } } } }
            """
            
        }
        
        
        var data: Data {
            
            return Data(postData.utf8)
            
        }
        print(data)
        let postString = String(data: data, encoding: .utf8)!
        print(postString)
        
        guard let url = URL(string: "https://api.authorize.net/xml/v1/request.api") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        do {
            
            request.httpBody = data
        }
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            SVProgressHUD.dismiss()
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    
                    print(json)
                    
                    
                    guard let response = json as? [String: Any] else { return }
                    
                    print(response)
                    
                    guard let transactionResponse = response["transactionResponse"] as? Any else { print("not a dic"); return }
                    
                    print(transactionResponse)
                    
                    guard let transactionDic = transactionResponse as? [String:Any] else {return}
                    
                    guard let responseCode = transactionDic["responseCode"] as? String else {return}
                    
                    print("\(responseCode)")
                    
                    DispatchQueue.main.async {
                        
                        
                        if responseCode == "1"{
                            
                            if ccPayAmt! == 20.0{
                                //self.postTwentyPayment()
                            }else {
                                self.FinalOrderPlacementTask()
                                
                            }
                            
                            
                            DispatchQueue.main.async {
                                
                                self.displayAlertMessage(messageToDisplay: "Your transaction has Approved", title: "success")
                                
                            }
                        }else if responseCode == "2"{
                            
                            
                            
                            guard let avsResultCode = transactionDic["avsResultCode"] as? String else {return}
                            
                            if avsResultCode == "A"{
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: "Address (Street) matches, ZIP does not,Try Again", title: "Declined")
                                    
                                }
                                
                            }else if avsResultCode == "B"{
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: "Address information not provided for AVS check,Try Again", title: "Declined")
                                    
                                }
                                
                            }else if avsResultCode == "E"{
                                
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: " Address verification error,Try Again", title: "Declined")
                                    
                                }
                                
                            }else if avsResultCode == "G"{
                                
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: "Non-U.S. Card Issuing Bank,Try Again", title: "Declined")
                                    
                                }
                                
                            }else if avsResultCode == "P"{
                                
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: " Address verification not applicable for this transaction.Try Again", title: "Declined")
                                    
                                }
                                
                            }else if avsResultCode == "R"{
                                
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: "Retry — System unavailable or timed out.Try Again", title: "Declined")
                                    
                                }
                                
                            }else if avsResultCode == "S"{
                                
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: "Service not supported by issuer.Try Again", title: "Declined")
                                    
                                }
                                
                            }else if avsResultCode == "U"{
                                
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: "Address information is unavailable.Try Again", title: "Declined")
                                    
                                }
                                
                            }else if avsResultCode == "W"{
                                
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: "Nine digit ZIP matches, Address (Street) does not.Try Again ", title: "Declined")
                                    
                                }
                                
                            }else if avsResultCode == "Z"{
                                
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: " Five digit ZIP matches, Address (Street) does not. Try Again", title: "Declined")
                                    
                                }
                                
                            }
                            
                        }
                        else if responseCode == "3"{
                            
                            guard let avsResultCode = transactionDic["avsResultCode"] as? String else {return}
                            
                            if avsResultCode == "A"{
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: "Address (Street) matches, ZIP does not,Try Again", title: "Declined")
                                    
                                }
                                
                            }else if avsResultCode == "B"{
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: "Address information not provided for AVS check,Try Again", title: "Declined")
                                    
                                }
                                
                            }else if avsResultCode == "E"{
                                
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: " Address verification error,Try Again", title: "Declined")
                                    
                                }
                                
                            }else if avsResultCode == "G"{
                                
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: "Non-U.S. Card Issuing Bank,Try Again", title: "Declined")
                                    
                                }
                                
                            }else if avsResultCode == "P"{
                                
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: " Address varification service not applicable for this transaction.Try Again", title: "Declined")
                                    
                                }
                                
                            }else if avsResultCode == "R"{
                                
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: "Retry — System unavailable or timed out.Try Again", title: "Declined")
                                    
                                }
                                
                            }else if avsResultCode == "S"{
                                
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: "Service not supported by issuer.Try Again", title: "Declined")
                                    
                                }
                                
                            }else if avsResultCode == "U"{
                                
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: "Address information is unavailable.Try Again", title: "Declined")
                                    
                                }
                                
                            }else if avsResultCode == "W"{
                                
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: "Nine digit ZIP matches, Address (Street) does not.Try Again ", title: "Declined")
                                    
                                }
                                
                            }else if avsResultCode == "Z"{
                                
                                DispatchQueue.main.async {
                                    self.displayAlertMessage(messageToDisplay: " Five digit ZIP matches, Address (Street) does not. Try Again", title: "Declined")
                                    
                                }
                                
                            }
                            
                        }else if responseCode == "4"{
                            
                            DispatchQueue.main.async {
                                self.displayAlertMessage(messageToDisplay: "Your transaction has been held for review", title: "Transaction Held")
                                
                            }
                            
                            
                        }
                        
                    }
                    
                } catch {
                    print(error)
                }
            }
            
            }.resume()
        
    }
    
    func displayAlertMessage(messageToDisplay: String,title:String)
    {
        let alertController = UIAlertController(title: title, message: messageToDisplay, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            // Code in this block will trigger when OK button tapped.
            print("Ok button tapped");
            
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
    }
    
    
    func displayAlert()  {
        let topWindow = UIWindow(frame: UIScreen.main.bounds)
        topWindow.rootViewController = UIViewController()
        topWindow.windowLevel = UIWindowLevelAlert + 1
        let alert = UIAlertController(title: "No Internet", message: "please check your internet connection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "confirm"), style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
            // continue your work
            // important to hide the window after work completed.
            // this also keeps a reference to the window until the action is invoked.
            topWindow.isHidden = true
        }))
        topWindow.makeKeyAndVisible()
        topWindow.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if activeTF == expirationYearTextField{
            self.data = year
        }else if activeTF == expirationMonthTextField{
            self.data = size
        }
        
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if activeTF == expirationMonthTextField{
            self.data = size
        }else if activeTF == expirationYearTextField{
            self.data = year
        }
        
        return data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        if activeTF == expirationMonthTextField{
            expirationMonthTextField.text = month[row]
            
        }else if activeTF == expirationYearTextField{
            expirationYearTextField.text = yr[row]
        }
        
        self.view.endEditing(false)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) //This will hide the keyboard
    }
    
    
    func FinalOrderPlacementTask()  {
        
        guard let url = URL(string: "http://www.bespokino.com/cfc/app3.cfc?wsdl&method=placeOrderAndCreatePDF&customerID=\(Order.customerID)&orderNo=\(Order.orderNo)&paperNo=\(Order.paperNo)") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                print(data)
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
                
            }
            }.resume()
        
    }
    
    func postTwentyPayment(){
        
        let ccLastNo = String(self.cardNumber.suffix(4))
        print(ccLastNo)
        let parameters = """
        {"firstName":\(Customer.firstName!),"lastName":\(Customer.lastName!),"email":\(Customer.email!),
        "phoneNo":\(Customer.phoneNumber!),"userId":\(Order.userId), "ccType":"xxx","ccNo":\(self.cardNumber),  "ccExpMonth":\(self.cardExpirationMonth),"ccExpYear":\(self.cardExpirationYear),"ccCode":\(cardVerificationCode), "address":\(Customer.address!), "city":\(Customer.state),"state":\(Customer.state),"zip":\(Customer.zip!),"ccLastNo":\(ccLastNo)}
        """
        
        
        print(parameters)
        
        
        guard let url = URL(string: "http://www.bespokino.com/cfc/app2.cfc?wsdl&method=CustomerMeasuringToolDeposit") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
            
            }.resume()
        
    }
    //Apple Payment code
    
    
    @IBAction func payWithApplePay(_ sender: Any) {
        
        let supportedNetworks = [ PKPaymentNetwork.amex, PKPaymentNetwork.masterCard, PKPaymentNetwork.visa ]
        
        if PKPaymentAuthorizationViewController.canMakePayments() == false {
            let alert = UIAlertController(title: "Apple Pay is not available", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alert, animated: true, completion: nil)
        }
        
        if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: supportedNetworks) == false {
            let alert = UIAlertController(title: "No Apple Pay payment methods available", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alert, animated: true, completion: nil)
        }
        
        let request = PKPaymentRequest()
        request.currencyCode = "USD"
        request.countryCode = "US"
        request.merchantIdentifier = "merchant.bespokino.com.Bespokino"
        request.supportedNetworks = SupportedPaymentNetworks
        // DO NOT INCLUDE PKMerchantCapability.capabilityEMV
        request.merchantCapabilities = PKMerchantCapability.capability3DS
        
        
        //        let sameDay = PKShippingMethod(label: "Same Day Delivery", amount: 12.99)
        //        sameDay.identifier = "sameDay"
        //        sameDay.detail = "Guaranteed to be delivered same day."
        //
        //        let twoDay = PKShippingMethod(label: "Two Day Delivery", amount: 8.99)
        //        twoDay.identifier = "twoDay"
        //        twoDay.detail = "Guaranteed to be delivered in two days."
        
        let standard = PKShippingMethod(label: "Standard Delivery", amount: 0)
        standard.identifier = "standard"
        standard.detail = "Delivery will be held within 4 - 6 days."
        
        //set the array of shipping methods to the shippingMethods property of payment request
        request.shippingMethods = [standard]
        
        // request.paymentSummaryItems = [PKPaymentSummaryItem(label: "Total", amount: 1.00)]
        request.paymentSummaryItems = self.itemToSell(shipping: 0)
        
        let applePayController = PKPaymentAuthorizationViewController(paymentRequest: request)
        applePayController?.delegate = self
        
        self.present(applePayController!, animated: true, completion: nil)
    }
    
    func itemToSell(shipping: Double) -> [PKPaymentSummaryItem] {
        
        
        print(ApplepayInfo.ccPay!)
        print(ApplepayInfo.subTotalAmount!)
        print(ApplepayInfo.shippingCost!)
        print(ApplepayInfo.totalSalesAmount!)
        print(ApplepayInfo.salesTaxAmount!)
        print(ApplepayInfo.ccPay!)
        let ccpay : NSDecimalNumber = ApplepayInfo.ccPay!
        print(ccpay)
        let stax: NSDecimalNumber = ApplepayInfo.salesTaxAmount!
        //let shipping:NSDecimalNumber = ApplepayInfo.shippingCost!
        //let totalSaleAmt:NSDecimalNumber = ApplepayInfo.totalSalesAmount!
        let totCCpay:NSDecimalNumber = ApplepayInfo.ccPay!
        let sTotal:NSDecimalNumber = ApplepayInfo.subTotalAmount!
        let subtotal = PKPaymentSummaryItem(label: "Subtotal", amount: sTotal)
        let salestax = PKPaymentSummaryItem(label: "Sales Tax", amount:stax)
        let shippingCost = PKPaymentSummaryItem(label: "Shipping ", amount: 0)
        //  let totalSaleAmount = PKPaymentSummaryItem(label: "Total Sales Amount ", amount: totalSaleAmt)
        //let totalAmount = subtotal.amount.adding(discount.amount)
        let total = PKPaymentSummaryItem(label: "Bespokino", amount: totCCpay)
        return [subtotal, salestax, shippingCost,total]
        //  return [total]
        
    }
    
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: (@escaping (PKPaymentAuthorizationStatus) -> Void)) {
        print("paymentAuthorizationViewController delegates called")
        
        if payment.token.paymentData.count > 0 {
            let base64str = self.base64forData(payment.token.paymentData)
            let messsage = String(format: "Data Value: %@", base64str)
            print(base64str)
            print(messsage)
           // self.postPaymentTask(base64str: base64str)
            let alert = UIAlertController(title: "Authorization Success", message: messsage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.performApplePayCompletion(controller, alert: alert)
        } else {
            let alert = UIAlertController(title: "Authorization Failed!", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            return self.performApplePayCompletion(controller, alert: alert)
        }
    }
    
    @objc func performApplePayCompletion(_ controller: PKPaymentAuthorizationViewController, alert: UIAlertController) {
        controller.dismiss(animated: true, completion: {() -> Void in
            self.present(alert, animated: false, completion: nil)
        })
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
        print("paymentAuthorizationViewControllerDidFinish called")
    }
    
    @objc func base64forData(_ theData: Data) -> String {
        let charSet = CharacterSet.urlQueryAllowed
        
        let paymentString = NSString(data: theData, encoding: String.Encoding.utf8.rawValue)!.addingPercentEncoding(withAllowedCharacters: charSet)
        
        
        return paymentString!
    }
    
    
}
