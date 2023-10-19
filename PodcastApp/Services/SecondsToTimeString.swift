//
//  File.swift
//  PodcastApp
//
//  Created by Vanopr on 08.10.2023.
//

import Foundation
struct SecondsToTime {
 static func secondsToTime(seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let remainingSeconds = seconds % 60
        let formattedHours = String(format: "%02d", hours)
        let formattedMinutes = String(format: "%02d", minutes)
        let formattedSeconds = String(format: "%02d", remainingSeconds)
        let time = "\(formattedHours):\(formattedMinutes):\(formattedSeconds)"
        return time
    }
}
