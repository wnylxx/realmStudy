//
//  TaskRow.swift
//  realmTest_swiftUI
//
//  Created by wonyoul heo on 8/20/24.
//

import SwiftUI

struct TaskRow: View {
    var task: String
    var completed: Bool
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: completed ? "checkmark.circle" : "circle")
            
            Text(task)
        }
    }
}

#Preview {
    TaskRow(task: "Do laundry", completed: true)
}
