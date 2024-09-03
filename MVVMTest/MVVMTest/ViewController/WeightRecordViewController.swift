//
//  WeightRecordViewViewController.swift
//  MVVMTest
//
//  Created by wonyoul heo on 9/2/24.
//

import UIKit
import SwiftUI

class WeightRecordViewController: UIViewController {
    
    private let inBodyVM: InBodyChartViewModel
    private var hostingController: UIHostingController<InBodyChartView>?
    
    init(inBodyVM: InBodyChartViewModel) {
        self.inBodyVM = inBodyVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
           
    }
    
    
    func setupUI() {
        view.backgroundColor = UIColor(named: "ColorPrimary")
        
        // MARK: chartView (SwiftUI) 삽입
        let chartView = InBodyChartView(viewModel: inBodyVM)
        hostingController = UIHostingController(rootView: chartView)
        hostingController?.view.backgroundColor = .clear
        
        
        
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        contentView.addSubview(hostingController!.view)
        hostingController?.view.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([
            
            hostingController!.view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            hostingController!.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            hostingController!.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            hostingController!.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        // ScrollView 제약 조건 설정 (UI 요소들이 모두 contentView에 추가된 후 설정)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
        
    }
    
    
}
