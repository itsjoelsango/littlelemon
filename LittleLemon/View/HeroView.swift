//
//  HeroView.swift
//  LittleLemon
//
//  Created by Jo Michael on 3/15/23.
//

import SwiftUI

struct HeroView: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Little Lemon")
                    .font(Font.custom("MarkaziText", size: 32, relativeTo: .title))
                    .foregroundColor(Color("Yellow"))
                
                Text("Chicago")
                    .font(Font.custom("MarkaziText", size: 24, relativeTo: .subheadline))
                    .foregroundColor(Color("Secondary-dark-whiter"))
                
                HStack {
                    Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                        .foregroundColor(Color("Secondary-dark-whiter"))
                        .font(Font.custom("Karla", size: 16, relativeTo: .subheadline))
                        .lineLimit(6)
                    Spacer()
                    Image("Hero image")
                        .resizable()
                        .clipped()
                        .frame(width: 112, height: 128)
                        .cornerRadius(16)
                }
            }
            .foregroundColor(Color("Secondary-dark-whiter"))
            .padding([.leading, .trailing, .bottom], 20)
        }
        .background(Color("Green"))
        .padding([.top])
    }
}

struct HeroView_Previews: PreviewProvider {
    static var previews: some View {
        HeroView()
    }
}
