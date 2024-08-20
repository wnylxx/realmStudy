//
//  addTaskView.swift
//  realmTest_swiftUI
//
//  Created by wonyoul heo on 8/20/24.
//

import SwiftUI

struct addTaskView: View {
    @EnvironmentObject var realmManager: RealmManager
    @State var title: String = ""
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Create a new task")
                .font(.title3).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField("Enter your task here", text: $title)
                .textFieldStyle(.roundedBorder)
            
            Button {
                print("Task added!")
                if title != "" {
                    realmManager.addTask(taskTitle: title)
                }
                dismiss()
            } label: {
                Text("Add task")
                    .foregroundStyle(.white)
                    .padding()
                    .padding(.horizontal)
                    .background(Color(hue: 0.328, saturation: 0.796, brightness: 0.408))
                    .clipShape(.capsule)
            }
            
            Spacer()
        }
        .padding(.top, 40)
        .padding(.horizontal)
        .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))

    }
}

#Preview {
    addTaskView()
        .environmentObject(RealmManager())
}
