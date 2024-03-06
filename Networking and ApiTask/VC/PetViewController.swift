//
//  PetViewController.swift
//  Networking and ApiTask
//
//  Created by Awdhah Alazemi on 04/03/2024.
//

import UIKit
import Alamofire
import SnapKit
import Kingfisher

class PetViewController: UIViewController {
    var pet: Pet?
    let mycontainerView = UIView( )
    private let nameLabel = UILabel( )
    private let idLabel = UILabel( )
    private let adoptedLabel = UILabel( )
    private let ageLabel = UILabel( )
    private let genderLabel = UILabel()
    private let imageView = UIImageView()
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mycontainerView)
        mycontainerView.addSubview(nameLabel)
        mycontainerView.addSubview(idLabel)
        mycontainerView.addSubview(adoptedLabel)
        mycontainerView.addSubview(ageLabel)
        mycontainerView.addSubview(genderLabel)
        view.addSubview(imageView)

        
        
        
        
        
        
        
        
        setUpView( )
        setUpLayout( )
        configureWithPet( )
        view.backgroundColor = .white
        title = "Pet Details"
        let url = URL(string: pet?.image ?? "")
        imageView.kf.setImage(with: url)
        
        
        
        
        
    }
    func setUpLayout() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(view.snp.height).multipliedBy(0.5)
        }
        
        mycontainerView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.centerX.bottom.equalToSuperview()
            make.width.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-90)
            
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(mycontainerView.snp.top).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        ageLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(nameLabel)
        }
        

        adoptedLabel.snp.makeConstraints { make in
            make.top.equalTo(ageLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(nameLabel)
        }
        
        genderLabel.snp.makeConstraints { make in
            make.top.equalTo(adoptedLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(nameLabel)
        }
    }

    
    
   
            func setUpView( ){
        
//                mycontainerView.backgroundColor = ./*lightGray*/
                mycontainerView.layer.cornerRadius = 10
                mycontainerView.clipsToBounds = true
                imageView.layer.cornerRadius = 10
                imageView.clipsToBounds = true
                adoptedLabel.font = .systemFont(ofSize: 18)
                ageLabel.font = .systemFont(ofSize: 18)
                genderLabel.font = .systemFont(ofSize: 18)
                idLabel.font = .systemFont(ofSize: 18)
                nameLabel.font = .systemFont(ofSize: 28, weight: .heavy)
}

    func configureWithPet() {
        guard let pet = pet else { return }
        nameLabel.text = "Name: \(pet.name)"
        ageLabel.text = "Age: \(pet.age)"
        genderLabel.text = "Gender: \(pet.gender)"
        if pet.adopted {
            adoptedLabel.text = "Status: Adopted"
        } else {
            adoptedLabel.text = "Status: Not Adopted"
        }
    }}

   
   
  
    
    
    

   
