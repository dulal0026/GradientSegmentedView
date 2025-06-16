//
//  SegmentedViewModel.swift
//  GradientSegmentedView
//
//  Created by Dulal Hossain on 17/6/25.
//

class SegmentedViewModel {
    var items: [String] = []
    var selectedIndex: Int = 0
    
    init(items: [String], selectedIndex: Int = 0) {
        self.items = items
        self.selectedIndex = selectedIndex
    }
}
