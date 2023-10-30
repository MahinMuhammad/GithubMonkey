//
//  NetworkManager.swift
//  GithubMonkey
//
//  Created by Md. Mahinur Rahman on 10/29/23.
//

/*
 Copyright 2023 Md. Mahinur Rahman
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import Foundation

final class NetworkManager{
    var urlString = "https://api.github.com/users/MahinMuhammad/"
    
    func fetchData(listOf:String, completion: @escaping ([UserModel], Error?)->Void){
        if let url = URL(string: "\(urlString)\(listOf)?per_page=100"){
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
                                print("Data fetch successful with \(result.count) user")
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
