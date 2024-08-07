//
//  main.swift
//  SRResultFilesProcess
//
//  Created by Bratislav Ljubisic on 01.07.24.
//

import Foundation
import Files

print("Hello, World!")
processFiles()

func processFiles() {
    do {
        let folder = try Folder.home.subfolder(at: "SpeechResults")
        let resultApple = try folder.createFile(named: "resultApple.csv")
        let resultWhisper = try folder.createFile(named: "resultWhisper.csv")
        folder.subfolders.recursive.forEach { fld in
            fld.files.enumerated().forEach { (index, file) in
                do {
                    let data = try file.read()
                    if file.name.contains("apple") {
                        let rApple = try JSONDecoder().decode(Results.self, from: data)
                        let resultLine = "\(fld.name), \(rApple.reference.joined(separator: " ")), \(rApple.transcription.joined(separator: " ")), \(rApple.wordErrorRate)\n"
                        try resultApple.append(resultLine, encoding: .utf8)
                    } else if file.name.contains("whisper") {
                        let rWhisper = try JSONDecoder().decode(Results.self, from: data)
                        let resultLine = "\(fld.name), \(rWhisper.reference.joined(separator: " ")), \(rWhisper.transcription.joined(separator: " ")), \(rWhisper.wordErrorRate)\n"
                        try resultWhisper.append(resultLine, encoding: .utf8)
                    }
                } catch {
                    print(error)
                }
            }
        }
    } catch {
        print (error)
    }
}
