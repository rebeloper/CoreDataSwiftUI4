//
//  ContentView.swift
//  CoreDataSwiftUI4
//
//  Created by Alex Nagy on 25.08.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isAddCategoryViewPresented = false
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Category.value, ascending: true)],
        animation: .default)
    private var categories: FetchedResults<Category>
    
    @State private var searchQuery = ""
    
    var body: some View {
        List {
            ForEach(categories) { category in
                NavigationLink {
                    let itemsFetchRequest = FetchRequest<Item>(sortDescriptors: [NSSortDescriptor(keyPath: \Item.value, ascending: true)], predicate: NSPredicate(format: "%K CONTAINS[cd] %@", #keyPath(Item.categories), category), animation: .default)
                    CategoryView(category: category, items: itemsFetchRequest)
                } label: {
                    Text(category.value ?? "")
                }
            }
            .onDelete(perform: delete(offsets:))
        }
        .searchable(text: $searchQuery)
        .onChange(of: searchQuery, perform: { newValue in
            categories.nsPredicate = searchPredicate(query: newValue)
        })
        .navigationTitle("Categories")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    isAddCategoryViewPresented.toggle()
                } label: {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $isAddCategoryViewPresented) {
                    AddCategoryView()
                }
            }
        }
    }
    
    private func delete(offsets: IndexSet) {
        withAnimation {
            offsets.forEach { offset in
                let category = categories[offset]
                do {
                    try PersistenceController.shared.delete(category)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func searchPredicate(query: String) -> NSPredicate? {
        if query.isEmpty { return nil }
        return NSPredicate(format: "%K CONTAINS[cd] %@", #keyPath(Category.value), query)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
