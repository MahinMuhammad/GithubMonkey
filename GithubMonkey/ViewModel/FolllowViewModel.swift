//
//  FolllowViewModel.swift
//  GithubMonkey
//
//  Created by Md. Mahinur Rahman on 10/29/23.
//

import Foundation

enum listOf{
    case followers
    case following
    case nonfollowers
}

final class FolllowViewModel:ObservableObject{
    @Published  var followers: [UserModel] = []
    @Published  var following: [UserModel] = []
    @Published var nonfollowers: [UserModel] = []
    @Published var selectedListType = listOf.followers
    let networkManager = NetworkManager()
    
    func getUsersToPopulateList()->[UserModel]{
        switch selectedListType{
        case .followers:
            return followers
        case .following:
            return following
        case .nonfollowers:
            return nonfollowers
        }
    }
    
    func getTitle()->String{
        switch selectedListType{
        case .followers:
            return "Followers"
        case .following:
            return "Following"
        case .nonfollowers:
            return "Nonfollowers"
        }
    }
    
    func getSubHedding()->String{
        switch selectedListType{
        case .followers:
            return "These are the people follow you"
        case .following:
            return "These are the people you follow"
        case .nonfollowers:
            return "People doesn't follow you back"
        }
    }
    
    func loadList(){
        followers = []
        following = []
        nonfollowers = []
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
            self.nonfollowers = self.following.filter{user in !self.followers.contains(where: {user.id == $0.id})}
        }
    }
}
