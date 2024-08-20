//
//  TasksView.swift
//  realmTest_swiftUI
//
//  Created by wonyoul heo on 8/20/24.
//

import SwiftUI
import RealmSwift

struct TasksView: View {
    @EnvironmentObject var realmManager: RealmManager
    
    var body: some View {
        VStack {
            Text("My tasks")
                .font(.title3).bold()
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            List {
                if realmManager.tasks != nil {
                    ForEach(realmManager.tasks!, id: \.id) { task in
                        if !task.isInvalidated {
                            TaskRow(task: task.title, completed: task.completed)
                                .onTapGesture {
                                    realmManager.updateTask(id: task.id, completed: !task.completed)
                                }
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        realmManager.deleteTask(id: task.id)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }
                        
                    }
                }
                
            }
            .onAppear {
                UITableView.appearance().backgroundColor = .clear
                UITableViewCell.appearance().backgroundColor = .clear
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
    }
}

#Preview {
    TasksView()
        .environmentObject(RealmManager())
}
