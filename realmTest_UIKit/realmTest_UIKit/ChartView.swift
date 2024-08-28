//
//  ChartView.swift
//  realmTest_UIKit
//
//  Created by wonyoul heo on 8/28/24.
//

import SwiftUI
import Charts


struct OverallData: Identifiable {
    let id = UUID()
    let date: Date
    let coffee: Int
    
    // Date를 쉽게 생성할 수 있는 유틸리티 메서드
    static func makeDate(year: Int, month: Int, day: Int = 1) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        return Calendar.current.date(from: dateComponents) ?? Date()
    }
    
    static func mockData() -> [OverallData] {
        return [
            .init(date: makeDate(year: 2023, month: 8, day: 1), coffee: 12),
            .init(date: makeDate(year: 2023, month: 8, day: 2), coffee: 15),
            .init(date: makeDate(year: 2023, month: 8, day: 3), coffee: 8),
            .init(date: makeDate(year: 2023, month: 8, day: 4), coffee: 18),
            .init(date: makeDate(year: 2023, month: 8, day: 5), coffee: 14),
            // Add more dates as needed
        ]
    }
}

struct CoffeeData: Identifiable {
    let id = UUID()
    let date: Date
    let coffee: Int
    
    static func makeDate(year: Int = 2024, month: Int = 8, day: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        return Calendar.current.date(from: dateComponents) ?? Date()
    }
    
    static func mockData() -> [CoffeeData] {
        return [
            .init(date: makeDate(day: 1), coffee: 12),
            .init(date: makeDate(day: 4), coffee: 15),
            .init(date: makeDate(day: 7), coffee: 11),
            .init(date: makeDate(day: 9), coffee: 9),
            .init(date: makeDate(day: 14), coffee: 17),
        ]
    }
}


struct ChartView: View {
    @Environment(\.calendar) var calendar
    @State private var coffeeData = CoffeeData.mockData()
    @State private var overallData = OverallData.mockData()
    @State private var chartSelection: Date?
    
    private var areaBackground: Gradient {
        return Gradient(colors: [Color.accentColor, Color.accentColor.opacity(0.1)])
    }
    
    var body: some View {
        Chart(overallData) {
            LineMark(
                x: .value("Day", $0.date, unit: .day),
                y: .value("Amount", $0.coffee)
            )
            .symbol(.circle)
            .interpolationMethod(.catmullRom)
            
            if let chartSelection {
                RuleMark(x: .value("Day", chartSelection, unit: .month))
                    .foregroundStyle(.gray.opacity(0.5))
                    .annotation(
                        position: .top,
                        overflowResolution: .init(x: .fit, y: .disabled)
                    ) {
                        ZStack {
                            Text("\(getCoffee(for: chartSelection)) coffees")
                        }
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 4)
                                .foregroundStyle(Color.accentColor.opacity(0.2))
                        }
                    }
            }
            
            AreaMark(
                x: .value("Month", $0.date, unit: .month),
                y: .value("Amount", $0.coffee)
            )
            .interpolationMethod(.catmullRom)
            .foregroundStyle(areaBackground)
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .day, count: 1)) { _ in
                AxisValueLabel(format: .dateTime.day(.twoDigits), centered: true)
            }
        }
        .chartYScale(domain: 0 ... 30)
        .frame(height: 300)
        .padding()
        .chartXSelection(value: $chartSelection)
    }
    
    func getCoffee(for date: Date) -> Int {
        let selectedMonth = calendar.component(.month, from: date)
        let selectedYear = calendar.component(.year, from: date)
        
        return coffeeData.first {
            calendar.component(.month, from: $0.date) == selectedMonth &&
            calendar.component(.year, from: $0.date) == selectedYear
        }?.coffee ?? 0
    }
}

#Preview {
    ChartView()
}
