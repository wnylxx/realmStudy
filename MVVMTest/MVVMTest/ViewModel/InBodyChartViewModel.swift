//
//  vd.swift
//  MVVMTest
//
//  Created by wonyoul heo on 9/3/24.
//

import Foundation
import Combine
import RealmSwift

class InBodyChartViewModel: ObservableObject {
    private let realm = RealmManager.shared.realm
    
    @Published var inBodyData: [InBody] = [] {
        didSet {
            print("inBody가 변경되었습니다.: \(inBodyData.count)")
        }
    }
    
    
    @Published var inbodyRecords: [InBody] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    var currentYear: Int
    var currentMonth: Int
    
    init() {
        let currentDate = Date()
        let calendar = Calendar.current
        self.currentYear = calendar.component(.year, from: currentDate)
        self.currentMonth = calendar.component(.month, from: currentDate)
        
        self.fetchAndLoadData()
    }
    
    
    
    func updateYearAndMonth(year: Int, month: Int) {
        self.currentYear = year
        self.currentMonth = month
        
        fetchAndLoadData()
    }
    
    
    func fetchAndLoadData() {
        
        fetchInBodyData(year: currentYear, month: currentMonth)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("\(error)")
                }
            }, receiveValue: { [weak self] data in
                self?.inBodyData = []
                self?.inBodyData = data
                print("Fetched data: \(data.count)") // 데이터를 확인합니다.
                print("Assigned data: \(self?.inBodyData.count ?? 0)") // 할당 후 데이터를 확인합니다.
                print("-----------------------------------")
            })
            .store(in: &cancellables)
    }
    
    
    private func fetchInBodyData(year: Int, month: Int) -> Future<[InBody], Error> {
        return Future { result in
            do {
                guard let realm = self.realm else {
                    result(.failure(realmError.realmInstanceUnavailable))
                    return
                }
                
                let calendar = Calendar.current
                let startDate = calendar.date(from: DateComponents(year: year, month: month, day: 1))!
                let range = calendar.range(of: .day, in: .month, for: startDate)!
                let endDate = calendar.date(from: DateComponents(year: year, month: month, day: range.count))!

                let data = realm.objects(InBody.self).filter("date >= %@ AND date <= %@", startDate, endDate)
                result(.success(Array(data)))
            } catch {
                result(.failure(realmError.dataFetchFailed))
            }
        }
    }
    
    enum realmError: Error {
        case realmInstanceUnavailable
        case dataFetchFailed
        case unknownError
    }
    
    
    
    
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "d일"
        return formatter.string(from: date)
    }
    
    
    
    func getWeight(for date: Date) -> Int {
        return Int(inBodyData.first(where: {
            Calendar.current.isDate($0.date, inSameDayAs: date)
        })?.weight ?? 0)
    }
    
    func getMuscleMass(for date: Date) -> Float {
        return Float(inBodyData.first(where: {
            Calendar.current.isDate($0.date, inSameDayAs: date)
        })?.muscleMass ?? 0)
    }
    
    func getBodyFat(for date: Date) -> Float {
        return Float(inBodyData.first(where: {
            Calendar.current.isDate($0.date, inSameDayAs: date)
        })?.bodyFat ?? 0)
    }
    
    
    func weightYAxisDomain() -> ClosedRange<Double> {
        let weights = inBodyData.map { Double($0.weight) }
        let minWeight = weights.min() ?? 30.0
        let maxWeight = weights.max() ?? 100.0
        
        // 위 아래 여백을 위한 조절
        let minDomain = minWeight - 10
        let maxDomain = maxWeight + 10
        
        // 최소 몸무게 = 0
        let adjustedMinDomain = minDomain < 0 ? 0 : minDomain
        
        return adjustedMinDomain...maxDomain
    }
    
    func muscleYAxisDomain() -> ClosedRange<Double> {
        let muscles = inBodyData.map { Double($0.muscleMass)}
        let minMuscle = muscles.min() ?? 10.0
        let maxMuscle = muscles.max() ?? 50
        
        let minDomain = minMuscle - 10
        let maxDomain = maxMuscle + 10
        
        let adjustedMinDomain = minDomain < 0 ? 0 : minDomain
        
        return adjustedMinDomain...maxDomain
    }
    
    func fatYAxisDomain() -> ClosedRange<Double> {
        let fats = inBodyData.map { Double($0.bodyFat)}
        let minFat = fats.min() ?? 5
        let maxFat = fats.max() ?? 40
        
        let minDomain = minFat - 5
        let maxDomain = maxFat + 5
        
        let adjustedMinDomain = minDomain < 0 ? 0 : minDomain
        
        return adjustedMinDomain...maxDomain
    }
    
    
    func xAxisDomain() -> ClosedRange<Date> {
        guard let firstDate = inBodyData.map({ $0.date }).min(),
              let lastDate = inBodyData.map({ $0.date }).max() else {
            let today = Date()
            return today...today
        }

        let calendar = Calendar.current
        let adjustedLastDate = calendar.date(byAdding: .day, value: 1, to: lastDate) ?? lastDate
        
        return firstDate...adjustedLastDate
    }
    
}
