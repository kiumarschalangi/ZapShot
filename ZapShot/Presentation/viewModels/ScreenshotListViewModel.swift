//
//  ScreenshotListViewModel.swift
//  ZapShot
//
//  Created by kiumars  chaharlangi on 7/30/25.
//


import Foundation
import Photos
import SwiftUI

class ScreenshotListViewModel: ObservableObject {
    @Published var screenshots: [Screenshot] = []
    @Published var totalSizeInMB: Double = 0.0
    @Published var permissionDenied: Bool = false

    
    private let repository: ScreenshotRepository

    init(repository: ScreenshotRepository = PhotoLibraryScreenshotRepository()) {
        self.repository = repository
        requestPhotoPermissionAndLoad()
    }

    private func requestPhotoPermissionAndLoad() {
        PHPhotoLibrary.requestAuthorization { status in
               DispatchQueue.main.async {
                   if status == .authorized || status == .limited {
                       self.loadScreenshots()
                   } else {
                       self.permissionDenied = true
                   }
               }
           }
    }

    func loadScreenshots() {
        repository.fetchScreenshots { [weak self] screenshots in
            DispatchQueue.main.async {
                self?.screenshots = screenshots
            }
        }

        repository.getTotalScreenshotSize { [weak self] totalBytes in
            DispatchQueue.main.async {
                self?.totalSizeInMB = Double(totalBytes) / 1_048_576.0 // bytes to MB
            }
        }
    }
}
