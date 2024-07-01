//
//  Results.swift
//  SRResultFilesProcess
//
//  Created by Bratislav Ljubisic on 01.07.24.
//

import Foundation

struct Results: Decodable {
    let transcription: [String]
    let reference: [String]
    let wordErrorRate: Double
    let timeForTranscription: Double
}
