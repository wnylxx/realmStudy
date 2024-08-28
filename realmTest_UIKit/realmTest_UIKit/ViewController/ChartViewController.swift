//
//  ChartViewController.swift
//  realmTest_UIKit
//
//  Created by wonyoul heo on 8/28/24.
//

import UIKit
import SwiftUI

class ChartViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // SwiftUI 뷰 생성
        let inbodyChartView = InbodyChartView()
        
        // SwiftUI 뷰를 UIHostingController로 래핑
        let hostingController = UIHostingController(rootView: inbodyChartView)
        
        // UIHostingController의 view를 ChartViewController의 view에 추가
        addChild(hostingController)
        view.addSubview(hostingController.view)
        
        // SwiftUI 뷰의 오토레이아웃 설정
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        hostingController.didMove(toParent: self)
    }
}
