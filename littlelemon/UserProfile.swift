//
//  UserProfile.swift
//  littlelemon
//
//  Created by Ali on 24/10/23.
//

import SwiftUI

struct UserProfile: View {
    
    @Environment(\.presentationMode) var presentation
    
    
    
    
    @State private var isLoggedOut = false
    
    @State var firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    @State var lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
    @State var email = UserDefaults.standard.string(forKey: kEmail) ?? ""
    @State var phoneNumber = UserDefaults.standard.string(forKey: kPhoneNumber) ?? ""
    
    @State var orderStatuses = UserDefaults.standard.bool(forKey: kOrderStatuses)
    @State var passwordChanges = UserDefaults.standard.bool(forKey: kPasswordChanges)
    @State var specialOffers = UserDefaults.standard.bool(forKey: kSpecialOffers)
    @State var newsletter = UserDefaults.standard.bool(forKey: kNewsletter)
    
    
    @State var errorMessageShow = false
    @State var errorMessage = ""
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        HStack {
            Image(systemName: "chevron.left") // set image here
                .aspectRatio(contentMode: .fit).frame(width: 40, height: 40)
                .foregroundColor(.white).background(Color.primaryColorVariant1) .clipShape(Circle())
        }
    }
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            NavigationLink(destination: OnBoarding(), isActive: $isLoggedOut) { }
            VStack(alignment: .leading,spacing: 5)
            {
                VStack {
                    Text("Avatar")
                        .onboardingTextStyle()
                    HStack(spacing: 0) {
                        Image("profile-image-placeholder")
                            .resizable()
                            .aspectRatio( contentMode: .fit)
                            .frame(maxHeight: 75)
                            .clipShape(Circle())
                            .padding(.trailing)
                        Button("Change") { }
                            .buttonStyle(StylePrimaryButton2())
                        Button("Remove") { }
                            .buttonStyle(ButtonStylePrimaryColorReverse())
                        Spacer()
                    }
                }
                
                VStack{
                    Text("First name")
                        .onboardingTextStyle()
                    TextField("First Name", text: $firstName)
                }
                
                VStack {
                    Text("Last name")
                        .onboardingTextStyle()
                    TextField("Last Name", text: $lastName)
                    
                }
                
                VStack {
                    Text("E-mail")
                        .onboardingTextStyle()
                    TextField("E-mail", text: $email)
                        .keyboardType(.emailAddress)
                }
                
                VStack {
                    Text("Phone number")
                        .onboardingTextStyle()
                    TextField("Phone number", text: $phoneNumber)
                        .keyboardType(.default)
                }
            }
            .textFieldStyle(.roundedBorder)
            .disableAutocorrection(true)
            .padding()
            VStack(alignment: .leading)
            {
                Text("Email notifications")
                    .font(.regularText())
                    .foregroundColor(.primaryColorVariant1)
                
            }
            VStack {
                Toggle("Order statuses", isOn: $orderStatuses)
                Toggle("Password changes", isOn: $passwordChanges)
                Toggle("Special offers", isOn: $specialOffers)
                Toggle("Newsletter", isOn: $newsletter)
            }
            .padding()
            .font(Font.leadText())
            .foregroundColor(.primaryColorVariant1)
            
            Button("Log out") {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                UserDefaults.standard.set("", forKey: kFirstName)
                UserDefaults.standard.set("", forKey: kLastName)
                UserDefaults.standard.set("", forKey: kEmail)
                UserDefaults.standard.set("", forKey: kPhoneNumber)
                UserDefaults.standard.set(false, forKey: kOrderStatuses)
                UserDefaults.standard.set(false, forKey: kPasswordChanges)
                UserDefaults.standard.set(false, forKey: kSpecialOffers)
                UserDefaults.standard.set(false, forKey: kNewsletter)
                isLoggedOut = true
            }
            .buttonStyle(StylePrimaryButton1())
            Spacer(minLength: 20)
            HStack {
                Button("Discard Changes") {
                    
                    self.presentation.wrappedValue.dismiss()
                }
                .buttonStyle(ButtonStylePrimaryColorReverse())
                Button("Save changes") {
                    if validateUserInput(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber) {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        UserDefaults.standard.set(phoneNumber, forKey: kPhoneNumber)
                        UserDefaults.standard.set(orderStatuses, forKey: kOrderStatuses)
                        UserDefaults.standard.set(passwordChanges, forKey: kPasswordChanges)
                        UserDefaults.standard.set(specialOffers, forKey: kSpecialOffers)
                        UserDefaults.standard.set(newsletter, forKey: kNewsletter)
                        self.presentation.wrappedValue.dismiss()
                    }
                }
                .buttonStyle(StylePrimaryButton2())
            }
            if errorMessageShow {
                withAnimation() {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                }
            }
            
        }
        .navigationTitle(Text("Personal information"))
        .navigationBarTitleDisplayMode(.inline) .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
    }
    
    private func validateUserInput(firstName: String, lastName: String, email: String, phoneNumber: String) -> Bool {
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
    UserProfile()
}
