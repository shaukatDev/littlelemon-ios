//
//  Menu.swift
//  littlelemon
//
//  Created by Ali on 24/10/23.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var searchText = ""
    @State var startersIsEnabled = true
    @State var mainsIsEnabled = true
    @State var dessertsIsEnabled = true
    @State var drinksIsEnabled = true
    
    var body: some View {
        VStack
        {
            VStack {
                Hero().frame(maxHeight: 180)
                TextField("Search...", text: $searchText)
                    .textFieldStyle(.roundedBorder)
            }
            .padding()
            .background(Color.primaryColorVariant1)
            
            
            Text("ORDER FOR DELIVERY!")
                .font(.sectionTitle())
                .foregroundColor(.highlightColorVariant2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
                .padding(.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    Toggle("Starters", isOn: $startersIsEnabled)
                    Toggle("Mains", isOn: $mainsIsEnabled)
                    Toggle("Desserts", isOn: $dessertsIsEnabled)
                    Toggle("Drinks", isOn: $drinksIsEnabled)
                }
                .toggleStyle(MyToggleStyle())
                .padding(.horizontal)
            }
            
            FetchedObjects (predicate: buildPredicate(),
                            sortDescriptors: buildSortDescriptors()) {
                (dishes: [Dish]) in
            
                    List {
                        ForEach(dishes, id:\.self) { dish in
                            VStack {
                                NavigationLink {
                                    MenuDetail(dish: dish)
                                } label: {
                                    MenuItemView(dish: dish)
                                }
                                
                            }
                            .contentShape(Rectangle())
                        }
                    }.listStyle(.plain)
                }
          
        }.task{
            await getMenuData()
        }
        
    }
    
    func buildPredicate() -> NSCompoundPredicate {
        let search = searchText == "" ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        let starters = !startersIsEnabled ? NSPredicate(format: "category != %@", "starters") : NSPredicate(value: true)
        let mains = !mainsIsEnabled ? NSPredicate(format: "category != %@", "mains") : NSPredicate(value: true)
        let desserts = !dessertsIsEnabled ? NSPredicate(format: "category != %@", "desserts") : NSPredicate(value: true)
        let drinks = !drinksIsEnabled ? NSPredicate(format: "category != %@", "drinks") : NSPredicate(value: true)

        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [search, starters, mains, desserts, drinks])
        return compoundPredicate
    }
    
    private func buildSortDescriptors() -> [NSSortDescriptor] {
        [NSSortDescriptor(key: "title",
                          ascending: true,
                          selector:
                            #selector(NSString.localizedStandardCompare))]
    }
    
    private func getMenuData() async
    {
        PersistenceController.shared.clear()
        
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
        let urlSession = URLSession.shared
        
        do {
            let (data, _) = try await urlSession.data(from: url)
            let fullMenu = try JSONDecoder().decode(MenuList.self, from: data)
            let menuItems = fullMenu.menu
            
            
            for menuItem in menuItems {
                
                let oneDish = Dish(context: viewContext)
                oneDish.title = menuItem.title
                oneDish.image = menuItem.image
                oneDish.price = menuItem.price
                oneDish.itemDesc = menuItem.description
                oneDish.category = menuItem.category
                
            }
            try? viewContext.save()
            // populate Core Data
            //Dish.deleteAll(coreDataContext)
            //Dish.createDishesFrom(menuItems:menuItems, coreDataContext)
        }
        catch { }
    }
}

#Preview {
    Menu()
}
