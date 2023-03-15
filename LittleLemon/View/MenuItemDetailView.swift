//
//  MenuItemDetailView.swift
//  LittleLemon
//
//  Created by Jo Michael on 3/15/23.
//

import SwiftUI

struct MenuItemDetailView: View {
    var dish: Dish
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(16)

            } placeholder: {
                ProgressView()
                    .frame(width: 88, height: 88)
            }
            .frame(height: 200)
            .clipped()
            
            
            VStack(alignment: .leading, spacing: 10) {
                Text(dish.title!)
                    .font(.title)
                
                HStack(spacing: 10) {
                    Text("Price:")
                    
                    Text("$\(dish.price!)")
                        .font(.subheadline)
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Dish description")
                    
                    Text(dish.dishDescription ?? "")
                        .foregroundColor(Color("Green"))
                        .font(.body)
                        .bold(false)
                    
                    Text("Dish category")
                    
                    Text(dish.category ?? "")
                        .foregroundColor(Color("Green"))
                        .font(.body)
                }
            }
            .bold()
            .padding([.leading, .trailing], 20)
            
            Spacer()
        }
    }
}

struct MenuItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MenuItemDetailView(dish: Dish())
    }
}
