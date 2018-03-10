//
//  Model.swift
//  Joystick Junkies
//
//  Created by student on 3/9/18.
//  Copyright © 2018 student. All rights reserved.
//

import Foundation

class Game{
    
    var games:[String] = ["Mario","Counter Strike","Project IGI","Contra","GTA Vice City","FIFA 18"]
    
    var gamesGenre:[String] = ["Action","Fantasy","Kids"]
    func verifyLogin(email:String,password:String) -> (Bool,String) {
        if email.contains("@") && password.trimmingCharacters(in: .whitespaces).count > 4 {
            return (true,"")
        }
        return (false,"please enter a valid email and password with more than four characters")
    }
    
    
    func veifyRegistration(fName:String,lName:String,city:String,contact:String,email:String,password:String,confirmPassword:String) -> (Bool,String){
        var message = ""
        var registered = true
        
        print("fname: \(fName.trimmingCharacters(in: .whitespaces))")
        
        if fName.trimmingCharacters(in: .whitespaces).count == 0 || fName.rangeOfCharacter(from: .decimalDigits) != nil {
            registered = false
            message += "Enter FirstName \n"
        }
        
        if lName.trimmingCharacters(in: .whitespaces).count == 0 || lName.rangeOfCharacter(from: .decimalDigits) != nil {
            registered = false
            message += "Enter LastName \n"
        }
        
        if contact.trimmingCharacters(in: .whitespaces).count != 10 || (contact.rangeOfCharacter(from: .letters) != nil) {
            registered = false
            message += "Enter contact \n"
        }
        if city.trimmingCharacters(in: .whitespaces).count == 0 || city.rangeOfCharacter(from: .decimalDigits) != nil {
            registered = false
            message += "Enter city \n"
        }
        if email.trimmingCharacters(in: .whitespaces).count == 0 || !email.contains("@") {
            registered = false
            message += "Enter Email \n"
        }
        if password.trimmingCharacters(in: .whitespaces).count == 0 {
            registered = false
            message += "Enter Password \n"
        }
        if confirmPassword.trimmingCharacters(in: .whitespaces).count == 0 {
            registered = false
            message += "Enter Confirm Password \n"
        }
        if password.trimmingCharacters(in: .whitespaces).count > 0 ||  confirmPassword.trimmingCharacters(in: .whitespaces).count > 0 || password != confirmPassword{
            registered = false
            message += "Passwords Do not match \n"
        }
     //   print("\(registered)      message  :  \(message)")
        return (registered,message)
    }
    
    
    
    
    
    
    
    
    
    
    
}
