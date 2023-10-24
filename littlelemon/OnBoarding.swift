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
public let kPhoneNumber = "phone number key"
public let kOrderStatuses = "order statuses key"
public let kPasswordChanges = "password changes key"
public let kSpecialOffers = "special offers key"
public let kNewsletter = "news letter key"

struct OnBoarding: View {
    @State var isLoggedIn = false
    @State var firstName  = ""
    @State var lastName  = ""
    @State var email  = ""
    
    @State var errorMessageShow = false
    @State var errorMessage = ""
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    TopBar()
                    Hero()
                        .padding()
                        .background(Color.primaryColorVariant1)
                        .frame(maxWidth: .infinity, maxHeight: 240)
                    VStack {
                        NavigationLink(destination: Home(), isActive: $isLoggedIn){
                            EmptyView()
                        }
                        Text("First name *")
                            .onboardingTextStyle()
                        TextField("First Name", text: $firstName)
                        Text("Last name *")
                            .onboardingTextStyle()
                        TextField("Last Name", text: $lastName)
                        Text("E-mail *")
                            .onboardingTextStyle()
                        TextField("E-mail", text: $email)
                            .keyboardType(.emailAddress)
                    }
                    .textFieldStyle(.roundedBorder)
                    .disableAutocorrection(true)
                    .padding()
                    
                    if errorMessageShow {
                        withAnimation() {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                        }
                    }
                    
                    Button("Register") {
                        if validateUserInput(firstName: firstName, lastName: lastName, email: email) {
                            UserDefaults.standard.set(firstName, forKey: kFirstName)
                            UserDefaults.standard.set(lastName, forKey: kLastName)
                            UserDefaults.standard.set(email, forKey: kEmail)
                            UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                            UserDefaults.standard.set(true, forKey: kOrderStatuses)
                            UserDefaults.standard.set(true, forKey: kPasswordChanges)
                            UserDefaults.standard.set(true, forKey: kSpecialOffers)
                            UserDefaults.standard.set(true, forKey: kNewsletter)
                            firstName = ""
                            lastName = ""
                            email = ""
                            isLoggedIn = true
                        }
                    }
                    .buttonStyle(StylePrimaryButton1())
                    
                    Spacer()
                }
            }
            .onAppear() {
                if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    isLoggedIn = true
                }
            }
        }
        .navigationBarBackButtonHidden()
        
    }
    
    private  func validateUserInput(firstName: String, lastName: String, email: String) -> Bool {
        guard !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty else {
            errorMessage = "All fields are required"
            errorMessageShow = true
            return false
        }
        
        guard email.isValidEmail() else {
            errorMessage = "Invalid email address"
            errorMessageShow = true
            return false
        }
        
        
        errorMessageShow = false
        errorMessage = ""
        return true
    }
}

#Preview {
    OnBoarding()
}
