//
//  FolllowViewModel.swift
//  GithubMonkey
//
//  Created by Md. Mahinur Rahman on 10/29/23.
//

import Foundation

enum listOf{
    case follower
    case following
}

final class FolllowViewModel:ObservableObject{
    @Published var selected = listOf.follower
    @Published var users: [UserModel] = []
    let networkManager = NetworkManager()
    
    func loadList(){
        users = []
        networkManager.fetchData(listOf: selected == .follower ? "followers" : "following") { result, error in
            if error == nil{
                self.users = result
            }
        }
    }
}
