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
        VStack(spacing: 10) {
            Text("Little Lemon")
                .font(.title)
            
            Text("Chicago")
            
            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
            
            VStack {
                TextField("Search menu", text: $searchText)
                    .autocorrectionDisabled(true)
            }
            .padding([.leading, .trailing], 20)
            .textFieldStyle(.roundedBorder)
            
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptor()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        
                        HStack {
                            Text("\(dish.title!) \(dish.price!)")

                            Spacer()
                            
                            AsyncImage(url: URL(string: dish.image!)) { image in
                                image.resizable()
                                    .cornerRadius(16)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 50)
                        }
                    }
                }
            }
            
        }
        .onAppear() {
            getMenuData()
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
                        newDish.id = item.id
                    }
                    try? viewContext.save()
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

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
