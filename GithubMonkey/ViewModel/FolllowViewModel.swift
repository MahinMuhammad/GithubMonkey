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
    var followers: [UserModel] = []
    var following: [UserModel] = []
    let networkManager = NetworkManager()
    @Published var usersNotFollowers: [UserModel] = []
    
    func loadList(){
        followers = []
        following = []
        usersNotFollowers = []
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        networkManager.fetchData(listOf: "followers") { result, error in
            if error == nil{
                DispatchQueue.main.async {
                    self.followers = (result)
                    dispatchGroup.leave()
                }
            }
        }
        
        dispatchGroup.enter()
        networkManager.fetchData(listOf: "following") { result, error in
            if error == nil{
                DispatchQueue.main.async {
                    self.following = (result)
                    dispatchGroup.leave()
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.usersNotFollowers = self.following.filter{user in !self.followers.contains(where: {user.id == $0.id})}
        }
    }
}
