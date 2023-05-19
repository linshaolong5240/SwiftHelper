//
//  SwiftUITextView.swift
//  SwiftHelper
//
//  Created by sauron on 2023/2/22.
//  Copyright © 2023 com.sauronpi. All rights reserved.
//

import SwiftUI

struct SwiftUITextView: View {
    @State private var ingredients: [String] = ["A", "B", "C"]
    @State private var rolls: [Int] = [1, 2, 3]
    let length = Measurement(value: 225, unit: UnitLength.centimeters)
    
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    let dueDate = Date.now

    var body: some View {
        VStack {
            Text(ingredients, format: .list(type: .and))
            Button("Add Ingredient") {
                let possibles = ["Sausage", "Bacon", "Spam"]

                if let newIngredient = possibles.randomElement() {
                    ingredients.append(newIngredient)
                }
            }
            
            Text(rolls, format: .list(memberStyle: .number, type: .and))
            Button("Roll Dice") {
                let result = Int.random(in: 1...6)
                rolls.append(result)
            }
            
            Text(length, format: .measurement(width: .wide))
            Text("Task due date: \(dueDate, formatter: Self.taskDateFormat)")
        }
    }
}

struct SwiftUITextView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUITextView()
    }
}
