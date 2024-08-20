//
//  smallAddButton.swift
//  realmTest_swiftUI
//
//  Created by wonyoul heo on 8/20/24.
//

import SwiftUI

struct smallAddButton: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 50)
                .foregroundStyle(Color(hue: 0.328, saturation: 0.796, brightness: 0.408))
            Text("+")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundStyle(.white)
        }
        .frame(height: 50)
    }
}

#Preview {
    smallAddButton()
}
