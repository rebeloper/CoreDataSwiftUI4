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
    
    var body: some View {
        List {
            ForEach(categories) { category in
                Text(category.value ?? "")
            }
            .onDelete(perform: delete(offsets:))
        }
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
