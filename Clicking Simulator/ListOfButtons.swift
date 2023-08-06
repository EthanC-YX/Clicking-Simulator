//
//  ListOfButtons.swift
//  Clicking Simulator
//
//  Created by Ethan Chow on 5/8/23.
//

import Foundation

struct ListOfButtons: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String = ""
    var amountOfClickIncrease = 0
    var cost = 0
    var autoClick = 0
}
