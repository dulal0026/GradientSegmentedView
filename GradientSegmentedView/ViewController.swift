//
//  ViewController.swift
//  GradientSegmentedView
//
//  Created by Dulal Hossain on 17/6/25.
//

import UIKit

class ViewController: UIViewController {

    var segmentedControl: SegmentedView = {
        let sView: SegmentedView = SegmentedView(frame: .zero)
        sView.translatesAutoresizingMaskIntoConstraints = false
        return sView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.view.addSubview(segmentedControl)
        
        segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 44).isActive = true
        segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        
        segmentedControl.viewModel = .init(items: ["Daily", "Weekly", "Monthly"])
    }

}

