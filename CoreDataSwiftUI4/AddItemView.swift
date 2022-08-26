//
//  AddItemView.swift
//  CoreDataSwiftUI4
//
//  Created by Alex Nagy on 26.08.2022.
//

import SwiftUI

struct AddItemView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var value = ""
    
    var category: Category
    
    var body: some View {
        VStack {
            
            TextField("Item", text: $value)
                .textFieldStyle(.roundedBorder)
            
            Button {
                save()
            } label: {
                Text("Save")
            }

            
            Spacer()
        }
        .padding()
    }
    
    func save() {
        let item = Item(context: viewContext)
        item.value = value
        item.addToCategories(category)
        do {
            try PersistenceController.shared.save()
            dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
}

