//
//  OnBoardingView.swift
//  littlelemon
//
//  Created by Ali on 24/10/23.
//

import SwiftUI

let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email name key"
let kIsLoggedIn = "kIsLoggedIn"

struct OnBoarding: View {
    @State var isLoggedIn = false
    @State var firstName  = ""
    @State var lastName  = ""
    @State var email  = ""
    var body: some View {
        NavigationView{
            VStack(spacing: 24) {
                NavigationLink(destination: Home(), isActive: $isLoggedIn){
                    EmptyView()
                }
                TextField("Enter first name", text: $firstName)
                TextField("Enter last name", text: $lastName)
                TextField("Enter email address", text: $email)
                Button("Register") {
                    if(!firstName.isEmpty && !lastName.isEmpty && !email.isEmpty)
                    {
                        if(email.isValidEmail())
                        {
                            UserDefaults.standard.set(firstName, forKey: kFirstName)
                            UserDefaults.standard.set(lastName, forKey: kLastName)
                            UserDefaults.standard.set(email, forKey: kEmail)
                            UserDefaults.standard.set(true,forKey: kIsLoggedIn)
                            isLoggedIn = true
                        }
                    }
                }
            }
            .padding()
            .onAppear{
                if( UserDefaults.standard.bool(forKey:kIsLoggedIn))
                {
                    isLoggedIn = true
                }
            }
        }
    }
}

#Preview {
    OnBoarding()
}
