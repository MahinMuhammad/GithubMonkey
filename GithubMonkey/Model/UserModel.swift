//
//  UserModel.swift
//  GithubMonkey
//
//  Created by Md. Mahinur Rahman on 10/29/23.
//

import Foundation

struct UserModel:Decodable, Identifiable{
    let id:Int
    var username:String{
        return login
    }
    let login:String
    let avatar_url:String
}
