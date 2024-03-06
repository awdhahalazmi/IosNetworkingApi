//
//  NetworkManager.swift
//  Networking and ApiTask
//
//  Created by Awdhah Alazemi on 04/03/2024.
//

import Foundation
import Alamofire
class NetworkManager{

    //MARK: API
    private let baseURL = "https://coded-pets-api-crud.eapi.joincoded.com/pets"
    
    //MARK: Singleton
    static let shared = NetworkManager()
    weak var addPetDelegate: AddPetDelegate?

    
    func fetchPets(completion: @escaping ([Pet]?) -> Void ){
        
        AF.request(baseURL).responseDecodable(of: [Pet].self) { response in
            
            switch response.result{
            case .success(let pet): completion(pet)
            case .failure: completion(nil)
            }
            
        }
        
        
        
    }

    func addPet(pet: Pet, completion: @escaping (Bool) -> Void) {
            AF.request(baseURL, method: .post, parameters: pet, encoder: JSONParameterEncoder.default).response { response in
                switch response.result {
                case .success:
                    self.addPetDelegate?.didAddPet()
                    completion(true)
                case .failure(let error):
                    print(error)
                    completion(false)
                }
            }
        }
    
    
    func deletePet(id: Int, completion: @escaping (Bool) -> Void) {
        AF.request("\(baseURL)/\(id)", method: .delete).response { response in
            switch response.result {
            case .success:
                completion(true)
            case .failure(let error):
                print("Error occurred while deleting the pet: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
    
    
    
    
}
