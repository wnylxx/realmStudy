//
//  ContentView.swift
//  realmTest_swiftUI
//
//  Created by wonyoul heo on 8/20/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var realmManager = RealmManager()
    @State private var showAddTaskView = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            TasksView()
                .environmentObject(realmManager)
            
            smallAddButton()
                .padding()
                .onTapGesture {
                    showAddTaskView.toggle()
                }
            
        }
        .sheet(isPresented: $showAddTaskView, content: {
            addTaskView()
                .environmentObject(realmManager)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))

    }
}

#Preview {
    ContentView()
}
