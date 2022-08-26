//
//  CategoryView.swift
//  CoreDataSwiftUI4
//
//  Created by Alex Nagy on 26.08.2022.
//

import SwiftUI

struct CategoryView: View {
    
    @State var category: Category
    @FetchRequest var items: FetchedResults<Item>
    
    @State private var isAddItemViewPresented = false
    
    var body: some View {
        List {
            ForEach(items) { item in
                Text(item.value ?? "")
            }
            .onDelete(perform: delete(offsets:))
        }
        .navigationTitle(category.value ?? "")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    isAddItemViewPresented.toggle()
                } label: {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $isAddItemViewPresented) {
                    AddItemView(category: category)
                }
            }
        }
    }
    
    func delete(offsets: IndexSet) {
        withAnimation {
            offsets.forEach { offset in
                let item = items[offset]
                do {
                    try PersistenceController.shared.delete(item)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

