//
//  ViewController.swift
//  UserDefaults and Property Wrappers
//
//  Created by Bo on 6/5/20.
//  Copyright © 2020 Jessica Trinh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

struct Defaults {

     static let token = "token"
     static let tokenKey = "tokenKey"

     struct Model {
         var token: String?

         init(token: String) {
           //complete the initializer
            self.token = token
         }
     }

     static var saveToken = { (token: String) in
       //complete the method
        UserDefaults.standard.set(token, forKey: tokenKey)
        
     }

     static var getToken = { () -> String in
       //complete the method
        return UserDefaults.standard.string(forKey: tokenKey)!
    }

     static func clearUserData(){
       //complete the method using removeObject
        UserDefaults.standard.removeObject(forKey: tokenKey)
     }
 }


struct Person {
    var name: String
    var favoriteColor: UIColor
}
extension Person: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case favoriteColor
    }
    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      name = try container.decode(String.self, forKey: .name)
      let colorData = try container.decode(Data.self, forKey: .favoriteColor) //color back as Data
      favoriteColor = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(colorData) as? UIColor ?? UIColor.purple
    }
    func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(name, forKey: .name)
      let colorData = try NSKeyedArchiver.archivedData(withRootObject: favoriteColor, requiringSecureCoding: false)
      try container.encode(colorData, forKey: .favoriteColor)
    }
}
