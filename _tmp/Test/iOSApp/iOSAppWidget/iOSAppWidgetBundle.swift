//
//  iOSAppWidgetBundle.swift
//  iOSAppWidget
//
//  Created by Connor on 25/11/22.
//

import WidgetKit
import SwiftUI

@main
struct iOSAppWidgetBundle: WidgetBundle {
    var body: some Widget {
        iOSAppWidget()
        iOSAppWidgetLiveActivity()
    }
}
