//
//  ViewController.swift
//  Networking and ApiTask
//
//  Created by Awdhah Alazemi on 04/03/2024.
//

import UIKit

class PetTableViewController: UITableViewController, AddPetDelegate {
    var pets: [Pet] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.addPetDelegate = self

        view.backgroundColor = .white
        setupNavigationBar( )
        setUPnavBar( )
        didAddPet( )
        //addPetTapped( )
        title = "Pet"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        fetchPetsData()
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pets.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let pet = pets[indexPath.row]
        cell.textLabel?.text = pet.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     let petVC = PetViewController()
    let selectedPet = pets[indexPath.row]
        petVC.pet = selectedPet

       navigationController?.pushViewController(petVC, animated: true)


    
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let petToDelete = pets[indexPath.row]
            NetworkManager.shared.deletePet(id: petToDelete.id ?? 0) { [weak self] success in
                DispatchQueue.main.async {
                    if success {
                      
                        self?.pets.remove(at: indexPath.row)

                       
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    } else {
                        self?.showDeleteFailureAlert()
                    }
                }
            }
        }
    }
    func didAddPet() {
           fetchPetsData()
       }
 
    
    func showDeleteFailureAlert() {
        let alert = UIAlertController(title: "Error", message: "Failed to delete pet.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func setupNavigationBar() {
        
        let filterButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterButtonTapped))
            navigationItem.rightBarButtonItem = filterButton
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus.rectangle.portrait"),
            style: .plain,
            target: self,
            action: #selector(thePopOver)
        )
        navigationItem.leftBarButtonItem?.tintColor = UIColor.systemCyan
    }
    @objc func thePopOver( ){
        
        let thirdVC = ViewController( )
        thirdVC.modalPresentationStyle = .popover
     self.present(thirdVC, animated: true )

    }
    
    func setUPnavBar( ){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
    }
    
    @objc func filterButtonTapped() {
        let alertController = UIAlertController(title: "Filter Pets", message: "filter option", preferredStyle: .actionSheet)

       
        let notAdoptedAction = UIAlertAction(title: "Not Adopted", style: .default) { _ in
            self.filterPetsByAdoptionStatus(adopted: false);
        }

        alertController.addAction(notAdoptedAction)

        
        let adoptedAction = UIAlertAction(title: "Adopted", style: .default) { _ in
            self.filterPetsByAdoptionStatus(adopted: true);
        }

        alertController.addAction(adoptedAction)

        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        fetchPetsData()


        
        present(alertController, animated: true, completion: nil)
    }

    func filterPetsByAdoptionStatus(adopted: Bool) {
        pets = pets.filter { $0.adopted == adopted }
        tableView.reloadData()
        
    }
    
    
    //just added
//    @objc private func addPetTapped() {
//            let navigationController = UINavigationController(rootViewController: ViewController())
//            present(navigationController, animated: true, completion: nil)
//        }
//
   }





extension PetTableViewController{
    
    func fetchPetsData( ){
        
        NetworkManager.shared.fetchPets{ fetchedPets in
            DispatchQueue.main.async{
                self.pets = fetchedPets ?? []
                self.tableView.reloadData()
                
            }
       
        }
    }
}

