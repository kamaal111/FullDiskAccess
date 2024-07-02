//
//  ContentView.swift
//  FullDiskAccess
//
//  Created by Kamaal M Farah on 02/07/2024.
//

import SwiftUI
import Security

struct ContentView: View {
    var body: some View {
        Button(action: play, label: {
            Text("Try again")
        })
        .onAppear(perform: play)
    }

    private func play() {
        let hostsURL = URL(filePath: "/etc/hosts")
        let currentHostFileContent: String
        do {
            currentHostFileContent = try String(contentsOf: hostsURL, encoding: .utf8)
        } catch {
            print("🐸🐸🐸 read file error", error)
            return
        }

        print(currentHostFileContent)

        let updatedHostFileContent = currentHostFileContent + """
        #
        # 🐸🐸🐸
        #
        """
        guard let updatedHostFileContentData = updatedHostFileContent.data(using: .utf8) else {
            print("🐸🐸🐸 could not make it data")
            return
        }

        if hostsURL.startAccessingSecurityScopedResource() {
            defer {
                hostsURL.stopAccessingSecurityScopedResource()
            }

            let isWritableFile = FileManager.default.isWritableFile(atPath: "/etc/hosts")
            print("🐸🐸🐸 isWritableFile", isWritableFile)
            
            do {
                try updatedHostFileContentData.write(to: hostsURL, options: [.atomic, .noFileProtection])
            } catch {
                print("🐸🐸🐸 write file error", error)
                return
            }
        }
    }
}

#Preview {
    ContentView()
}
