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
class BillingViewController: UIViewController ,BEMCheckBoxDelegate,GMSAutocompleteViewControllerDelegate{
  
  
    

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
    
    @IBOutlet weak var getYourAddressButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        self.navigationItem.title = "BESPOKINO"
        continueButton.layer.cornerRadius = 5
        continueButton.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        checkmark.delegate = self
       self.setDataInTextField()
        
        getYourAddressButton.layer.borderWidth = 1.0
        getYourAddressButton.layer.borderColor = #colorLiteral(red: 1, green: 0.8000000119, blue: 0.400000006, alpha: 1)
        
    
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
        
        self.firstNameText.text = customer[0].firstName
        self.lastNameText.text = customer[0].lastName
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
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ShippingAddressViewController") as! ShippingAddressViewController
            newViewController.shipping = self.customer
            self.navigationController?.pushViewController(newViewController, animated: true)
        }else{
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ShippingAddressViewController") as! ShippingAddressViewController
          //  newViewController.shipping = self.customer
            self.navigationController?.pushViewController(newViewController, animated: true)
        
        }
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
}
