//
//  RecordedAudio.swift
//  PitchPerfect
//
//  Created by Jeffrey Pape on 15-9-28.
//  Copyright © 2015 Jeffrey Pape. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    var filePathUrl: NSURL!
    var title: String!
    
    override init() {
        filePathUrl = NSURL(fileURLWithPath: "")
        title = ""
    }
    
    init(filePathUrl: NSURL, title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}