//
//  Menu.swift
//  LittleLemon
//
//  Created by Jo Michael on 2/25/23.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Group {
                    HeroView()
                    VStack {
                        TextField("Search menu", text: $searchText)
                            .autocorrectionDisabled(true)
                    }
                    .padding([.leading, .trailing], 20)
                    .padding(.bottom, 10)
                    .textFieldStyle(.roundedBorder)
                    .background(Color("Green"))
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("ORDER FOR DELIVERY!")
                            .bold()
                        HStack {
                            ButtomView(buttomTitle: "Started")
                            ButtomView(buttomTitle: "Mains")
                            ButtomView(buttomTitle: "Desserts")
                            ButtomView(buttomTitle: "Drinks")
                        }
                        .buttonStyle(.bordered)
                        .foregroundColor(Color("Green"))
                        .bold()
                    }
                    .padding([.top])
                    .padding([.bottom], 5)

                }
                
                FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptor()) { (dishes: [Dish]) in
                    List {
                        ForEach(dishes) { dish in
                            
                            HStack {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("\(dish.title!)")
                                        .bold()
                                    
                                    Text(dish.dishDescription ?? "")
                                        .foregroundColor(Color("Green"))
                                        .lineLimit(2)
                                    
                                    Text("$\(dish.price!)")
                                        .foregroundColor(Color("Green"))
                                }

                                Spacer()
                                
                                AsyncImage(url: URL(string: dish.image!)) { image in
                                    image.resizable()
                                        .cornerRadius(16)
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 88, height: 88)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
                
            }
            .onAppear() {
                getMenuData()
            }
            .navigationTitle("little lemon")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("Logo")
                }
            }
        }
    }
    
    func getMenuData() {
        PersistenceController.shared.clear()
        
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let menuList = try decoder.decode(MenuList.self, from: data)
                    for item in menuList.menu {
                        let newDish = Dish(context: viewContext)
                        newDish.title = item.title
                        newDish.image = item.image
                        newDish.price = item.price
                        newDish.dishDescription = item.description
                        newDish.category = item.category
                        newDish.id = item.id
                    }
//                    try? viewContext.save()
                    Dish.saveDatabase(viewContext)
                }
                catch let error {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    func buildSortDescriptor() -> [NSSortDescriptor] {
        
        return [
            NSSortDescriptor(key: "title",
                             ascending: true,
                             selector: #selector(NSString.localizedCaseInsensitiveCompare))
        ]
    }
    
    func buildPredicate() -> NSPredicate {
        return searchText.isEmpty ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", searchText)
    }
}

struct ButtomView: View {
    var buttomTitle: String
    
    var body: some View {
        Button {
            // code here
        } label: {
            Text(buttomTitle)
        }.background(Color("Secondary-white"))
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
