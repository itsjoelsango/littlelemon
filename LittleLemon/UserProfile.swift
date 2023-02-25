//
//  UserProfile.swift
//  LittleLemon
//
//  Created by Jo Michael on 2/25/23.
//

import SwiftUI

struct UserProfile: View {
    private let userFirstName = UserDefaults.standard.string(forKey: keyFirstName)
    private let userLastName = UserDefaults.standard.string(forKey: keyLastName)
    private let userEmail = UserDefaults.standard.string(forKey: keyEmail)
    
    // This will automatically reference the presentation environment in SwiftUI
    // which will allow you to reach the navigation logic
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Personal information")
            Image("profile-image-placeholder")
                .resizable()
                .frame(width: 88, height: 88)
            
            Text(userFirstName ?? "firstname")
            Text(userLastName ?? "lastname")
            Text(userEmail ?? "email")
            
            Button("Logout") {
                var isLoggedIn = UserDefaults.standard.bool(forKey: kIsLoggedIn)
                isLoggedIn.toggle()
                self.presentation.wrappedValue.dismiss()
            }
            .buttonStyle(.bordered)
            
            Spacer()
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
