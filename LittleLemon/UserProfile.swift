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
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    
    // This will automatically reference the presentation environment in SwiftUI
    // which will allow you to reach the navigation logic
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Personal information")
                    .bold()
                
                Text("Avatar")
                    .font(.footnote)
                
                HStack(spacing: 16) {
                    Image("profile-image-placeholder")
                        .resizable()
                        .frame(width: 88, height: 88)
                        .cornerRadius(44)
                    
                    Button(action: {
                        // ACtion here
                    }, label: {
                        Text("Change")
                    })
                    .buttonStyle(.bordered)
                    .foregroundColor(.white)
                    .background(Color("Green"))
                    .cornerRadius(10)
                    
                    Button("Remove") {
                        
                    }
                    .border(.gray)
                    .buttonStyle(.bordered)
                    .foregroundColor(.gray)
                    .background(.clear)
                }
                
                VStack(alignment: .leading) {
                    Text("First name")
                        .font(.subheadline)
                    
                    TextField("\(userFirstName!)", text: $firstName)
                }
                
                VStack(alignment: .leading) {
                    Text("Last name")
                        .font(.subheadline)
                    
                    TextField("\(userLastName!)", text: $lastName)
                }
                
                VStack(alignment: .leading) {
                    Text("Email")
                        .font(.subheadline)
                    
                    TextField(userEmail!, text: $email)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }
                
                VStack(alignment: .leading) {
                    Text("Phone number")
                        .font(.subheadline)
                    
                    TextField("(217) 555-0113", text: $phoneNumber)
                        .textContentType(.telephoneNumber)
                        .keyboardType(.phonePad)
                }
                VStack(alignment: .leading) {
                    Text("Email notifications")
                        .font(.subheadline)
                        .bold()
                    EmailNotificationView()
                }
                
                Button("Log out") {
                    UserDefaults.standard.set(false, forKey: keyIsLoggedIn)
                    self.presentation.wrappedValue.dismiss()
                }
                .buttonStyle(.bordered)
                .foregroundColor(Color.black)
                .background(Color("Yellow"))
                
                HStack(spacing: 20) {
                    Spacer()
                    Button {
                        //
                    } label: {
                        Text("Discard changes")
                            .font(.subheadline)
                            .bold()
                    }
                    .border(.gray)
                    .foregroundColor(.gray)
                    .background(.white)
                    
                    Button {
                        //
                    } label: {
                        Text("Save changes")
                    }
                    .foregroundColor(.white)
                    .background(Color("Green"))
                    .cornerRadius(10)
                    
                    Spacer()
                }
                .buttonStyle(.bordered)

            }
            .textFieldStyle(.roundedBorder)
            .submitLabel(.done)
        }
        .padding([.leading, .trailing], 16)
        .scrollIndicators(.hidden)

    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}

// Source: https://www.appcoda.com/swiftui-checkbox/

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
 
            RoundedRectangle(cornerRadius: 4.0)
                .stroke(lineWidth: 2)
                .frame(width: 20, height: 20)
                .cornerRadius(4.0)
                .overlay {
                    Image(systemName: configuration.isOn ? "checkmark" : "")
                        .background(Color("Green"))
                        .foregroundColor(.white)
                }
                .onTapGesture {
                    withAnimation(.spring()) {
                        configuration.isOn.toggle()
                    }
                }
 
            configuration.label
 
        }
    }
}

struct EmailNotificationView: View {
    @State private var isOrderStatueOn = false
    @State private var isPasswordChanged = false
    @State private var isSpecialOffersChecked = false
    @State private var isNewsletterOn = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Toggle(isOn: $isOrderStatueOn) {
                Text("Order statuses")
            }
            Toggle(isOn: $isPasswordChanged) {
                Text("Password changes")
            }
            Toggle(isOn: $isSpecialOffersChecked) {
                Text("Special offers")
            }
            Toggle(isOn: $isNewsletterOn) {
                Text("Newsletter")
            }
        }
        .toggleStyle(CheckboxToggleStyle())
        .font(.footnote)
        
    }
}

