//
//  Onboarding.swift
//  LittleLemon
//
//  Created by Jo Michael on 2/25/23.
//

import SwiftUI

let keyFirstName = "first name key"
let keyLastName = "last name kay"
let keyEmail = "default email"

struct Onboarding: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    
    @State private var isLoggedIn = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                .navigationTitle("Sign up")
                
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Email", text: $email)
                
                Button("Register") {
                    if !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty {
                        
                        if isValidEmailAddress(email: email) {
                            UserDefaults.standard.set(firstName, forKey: keyFirstName)
                            UserDefaults.standard.set(lastName, forKey: keyLastName)
                            UserDefaults.standard.set(email, forKey: keyEmail)
                            isLoggedIn = true
                        } else {
                            print("Invalid Email")
                        }
                    } else {
                        print("Empty field found!")
                    }
                }
                .buttonStyle(.bordered)
            }
            .textFieldStyle(.roundedBorder)
            .padding()
        }
    }
    
    private func isValidEmailAddress(email: String) -> Bool {
        guard !email.isEmpty else { return false }
        let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
        return emailValidationPredicate.evaluate(with: email)
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
