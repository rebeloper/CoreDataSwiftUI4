//
//  AddCategoryView.swift
//  CoreDataSwiftUI4
//
//  Created by Alex Nagy on 25.08.2022.
//

import SwiftUI

struct AddCategoryView: View {
    
    @State private var value = ""
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        VStack {
            TextField("Category", text: $value)
                .textFieldStyle(.roundedBorder)
            
            Button {
                save()
            } label: {
                Text("Save")
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .padding()
    }
    
    func save() {
        let category = Category(context: viewContext)
        category.value = value
        do {
            try PersistenceController.shared.save()
            dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct AddCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryView()
    }
}
