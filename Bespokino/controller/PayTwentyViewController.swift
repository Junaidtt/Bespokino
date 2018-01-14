//
//  PayTwentyViewController.swift
//  Bespokino
//
//  Created by Bespokino on 29/11/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import UIKit
import GooglePlaces

class PayTwentyViewController: UIViewController,UISearchBarDelegate ,GMSAutocompleteViewControllerDelegate {


    @IBOutlet weak var creditCardButton: UIButton!
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var cellNumberText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var addressText: UITextField!
    @IBOutlet weak var stateText: UITextField!
    @IBOutlet weak var zipText: UITextField!
    
    var searchResultController:SearchResultsController!
    var resultsArray = [String]()
    
    var street_number = ""
    var route = ""
    var neighborhood = ""
    var locality = ""
    var administrative_area_level_1  = ""
    var country = ""
    var postal_code = ""
    var postal_code_suffix = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)

        self.navigationItem.title = "BESPOKINO"
        
        creditCardButton.layer.cornerRadius = 3.0
        creditCardButton.layer.shadowColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        creditCardButton.layer.shadowRadius = 5
        creditCardButton.layer.masksToBounds = true
        creditCardButton.titleLabel?.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        getUserInfo()

    }

    @IBAction func creditCardButtonDidTap(_ sender: Any) {
        
        
        print(addressText.text!)
        print(stateText.text!)
        print(zipText.text!)
        Customer.address = addressText.text!
        Customer.state = stateText.text!
        Customer.zip = zipText.text!
      
        if (Customer.address!.isEmpty || Customer.state!.isEmpty || Customer.zip!.isEmpty)
        {
        self.displayAlertMessage(messageToDisplay: "All fields are necessary")
        }else{
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "TransactionViewController") as! TransactionViewController
            
            Payment.ccPay = 20.0
            
            self.navigationController?.pushViewController(newViewController, animated: true)
            
        }
     
    }
    
    
    struct GetUser {
        static var phone:Double?
        static var email:String?
        static var lastName:String?
        static var firstName:String?
    }
    
    
    func getUserInfo()  {
        
        guard let url = URL(string: "http://www.bespokino.com/cfc/app2.cfc?wsdl&method=getSignupInfo&userID=\(Order.userId)") else { return }
        
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
                    
                    guard let userinfo = json as? [String:Any] else{return}
                    DispatchQueue.main.async {
                        self.firstNameText.text = userinfo["firstName"] as? String
                        self.lastNameText.text = userinfo["lastName"] as? String
                        self.emailText.text = userinfo["Email"] as? String
                        self.cellNumberText.text = userinfo["PhoneNo"] as? String
                        Customer.firstName = userinfo["firstName"] as? String
                        Customer.lastName  = userinfo["lastName"] as? String
                        Customer.email  =  userinfo["Email"] as? String
                        Customer.phoneNumber = userinfo["PhoneNo"] as? String
                        
                    }
              

                    
                    
                } catch {
                    print(error)
                }
                
            }
            }.resume()
    }
    
    @IBAction func getYourAddressDidTap(_ sender: Any) {
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        // Set a filter to return only addresses.
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        autocompleteController.autocompleteFilter = filter
        
        present(autocompleteController, animated: true, completion: nil)
        
        
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
    
    
    // Populate the address form fields.
    func fillAddressForm() {
        addressText.text = street_number + " " + route
        stateText.text = locality
        stateText.text = administrative_area_level_1
        if postal_code_suffix != "" {
            zipText.text = postal_code + "-" + postal_code_suffix
        } else {
            zipText.text = postal_code
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
    func displayAlertMessage(messageToDisplay: String)
    {
        let alertController = UIAlertController(title: "info", message: messageToDisplay, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            // Code in this block will trigger when OK button tapped.
            print("Ok button tapped");
            
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
    }
    
}
