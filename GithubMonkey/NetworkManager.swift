//
//  NetworkManager.swift
//  GithubMonkey
//
//  Created by Md. Mahinur Rahman on 10/29/23.
//

import Foundation

final class NetworkManager{
    let urlString = "https://api.github.com/users/MahinMuhammad/followers"
    
    func fetchData(listOf:String, completion: @escaping ([UserModel], Error?)->Void){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let error{
                    completion([], error)
                    print("Request failed with error: \(error.localizedDescription)")
                }else{
                    let decoder = JSONDecoder()
                    if let data{
                        do{
                            let result = try decoder.decode([UserModel].self, from: data)
                            DispatchQueue.main.async {
                                completion(result, nil)
                            }
                        }catch{
                            completion([], error)
                            print("Failed to decode data with error: \(error.localizedDescription)")
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
