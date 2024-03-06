//
//  ViewController.swift
//  Networking and ApiTask
//
//  Created by Awdhah Alazemi on 04/03/2024.
//

import UIKit
import Eureka
import Alamofire

class ViewController: FormViewController {
    let name =  TagsEnum.name
    let gender = TagsEnum.gender
    let age = TagsEnum.age
    let adoption = TagsEnum.adoption
    let image = TagsEnum.image

    
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupForm()
    }
    private func setupForm() {
        form +++ Section("Add New Pet")
        <<< TextRow() { row in
            row.title = "Pet Name"
            row.placeholder = "Enter Name"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.tag = name.TagsToString()
            row.cellUpdate { cell, row in
                if !row.isValid {
                            cell.titleLabel?.textColor = .red
                        }
                    }
        }
        <<< ActionSheetRow<String>() { row in
            row.title = "Gender"
            row.selectorTitle = "Select Gender"
            row.options = ["Female", "Male"]
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.value = "Gender"
            row.tag = gender.TagsToString()
           
        }
        
        <<< IntRow( ){row in
            row.title = "Age"
            row.placeholder = "Enter Age"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.tag = age.TagsToString()
            row.cellUpdate { cell, row in
                if !row.isValid {
                            cell.titleLabel?.textColor = .red
                        }
                    }
        }
        <<< ActionSheetRow<String>() { row in
            row.title = "Adoption"
            row.selectorTitle = "Adoption Status"
            row.options = ["Yes"," No"]
            row.value = "status"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.tag = adoption.TagsToString()
           
          
        }
        <<< URLRow(){row in
            row.title = "Image Url"
            row.placeholder = "Enter Url"
            row.add(rule: RuleURL())
            row.validationOptions = .validatesOnChange
            row.tag = image.TagsToString()
            row.cellUpdate { cell, row in
               
                    if !row.isValid {
                                cell.titleLabel?.textColor = .red
                            }
                        }
        }
        <<< ButtonRow() { row in
            row.title = "Add"
        }.onCellSelection { _, _ in
            self.addPetTapped()
        }
    }
    
    func stringToBool(_ string: String) -> Bool? {
            switch string.lowercased() {
            case "yes":
                return true
            case "no":
                return false
            default:
                return nil
            }
        }
    @objc func addPetTapped() {
        // validation
        let errors = form.validate()
        guard errors.isEmpty else {
            presentAlertWithTitle(title: "Error", message: "Please fill out all fields.")
            return
        }
        
        let nameRow: TextRow? = form.rowBy(tag: name.TagsToString())
        let genderRow: ActionSheetRow<String>? = form.rowBy(tag: gender.TagsToString())
        let ageRow: IntRow? = form.rowBy(tag: age.TagsToString())
        let adoptionRow: ActionSheetRow<String>? = form.rowBy(tag: adoption.TagsToString())
        
        let imageUrlRow: URLRow? = form.rowBy(tag: image.TagsToString())
        let name = nameRow?.value ?? ""
        let gender = genderRow?.value ?? ""
        let age = ageRow?.value ?? 0
        let adoption = adoptionRow?.value ?? ""
        
        let imageUrl = imageUrlRow?.value?.absoluteString ?? ""
        let adopted = stringToBool(adoption) ?? false
        
    
        
            let pet = Pet(name: name, image: imageUrl, age: Int(age), gender: gender, adopted: adopted)
        
            NetworkManager.shared.addPet(pet: pet) { success in
                DispatchQueue.main.async {
                    if success {
                        self.dismiss(animated: true, completion: nil)
                    } else {
                    }
                }
            }
        
    }
    private func presentAlertWithTitle(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
    
    
   
    }

