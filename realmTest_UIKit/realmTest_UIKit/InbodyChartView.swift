//
//  InbodyChartView.swift
//  realmTest_UIKit
//
//  Created by wonyoul heo on 8/28/24.
//

import SwiftUI
import RealmSwift
import Charts

struct InbodyChartView: View {
    var realmManager = RealmManager()
    @Environment(\.calendar) var calendar
    @State private var inBodyData: [InBody] = []
    @State private var chartSelection: Date?
    
    var body: some View {
        VStack {
            Button(action: {
                loadData() // 버튼 클릭 시 데이터 로드
            }) {
                Text("Load Data")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            
            Chart(inBodyData) {
                LineMark(x: .value("Day", $0.date, unit: .day),
                         y: .value("Weight", $0.weight))
                .symbol(.circle)
                .interpolationMethod(.catmullRom)
                
                if let chartSelection {
                    RuleMark(x: .value("Day", chartSelection, unit: .day))
                        .foregroundStyle(.gray.opacity(0.5))
                        .annotation(position: .top) {
                            ZStack {
                                Text("\(getWeight(for: chartSelection)) KG")
                                    .padding(8)
                                    .background(RoundedRectangle(cornerRadius: 4)
                                        .fill(Color.accentColor.opacity(0.2))
                                    )
                            }
                        }
                }
            }
            .chartXAxis {
                AxisMarks(values: .stride(by: .day, count: 1)) { value in
                    if value.as(Date.self) != nil {
                        AxisValueLabel(format: .dateTime.day(.twoDigits), centered: true)
                    }
                }
            }
            .chartYScale(domain: yAxisDomain())
            .frame(height: 300)
            .padding()
            .onAppear {
                loadData()
            }
            .chartXSelection(value: $chartSelection)
        }
    }
    
    private func loadData() {
        // Realm 데이터 로드
        inBodyData = realmManager.getInBodyData()
        print("Loaded data: \(inBodyData)") // 데이터 로드 확인
    }
    
    private func getWeight(for date: Date) -> Int {
        // 데이터에서 선택된 날짜의 체중을 가져오는 함수
        return Int(inBodyData.first(where: {
            calendar.isDate($0.date, inSameDayAs: date)
        })?.weight ?? 0)
    }
    
    private func yAxisDomain() -> ClosedRange<Double> {
        let weights = inBodyData.map { Double($0.weight) }
        let minWeight = weights.min() ?? 30.0
        let maxWeight = weights.max() ?? 100.0
        
        // 최소값과 최대값에 -15, +15를 적용
        let minDomain = minWeight - 15.0
        let maxDomain = maxWeight + 15.0
        
        // 반환하는 범위가 0보다 낮아지지 않도록 처리
        let adjustedMinDomain = minDomain < 0 ? 0 : minDomain
        let adjustedMaxDomain = maxDomain > 120 ? 120 : maxDomain
        
        return adjustedMinDomain...adjustedMaxDomain
    }
}

#Preview {
    InbodyChartView()
}
