//
//  UserProfile.swift
//  littlelemon
//
//  Created by Ali on 24/10/23.
//

import SwiftUI

struct UserProfile: View {
    @Environment(\.presentationMode) var presentation
    private let firstName = UserDefaults.standard.string(forKey: kFirstName)
    private let lastName = UserDefaults.standard.string(forKey: kLastName)
    private let email = UserDefaults.standard.string(forKey: kEmail)
    var body: some View {
        VStack{
            Text("Personal Information")
            Image("profile-image-placeholder")
            Text("Personal Information")
            Text(firstName ?? "")
            Text(lastName ?? "")
            Text(email ?? "")
            Button("Logout"){
                UserDefaults.standard.set(false,forKey: kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            }
        }
       
    }
}

#Preview {
    UserProfile()
}
