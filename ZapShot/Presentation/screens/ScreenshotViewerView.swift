//
//  ScreenshotViewerView.swift
//  ZapShot
//
//  Created by kiumars chaharlangi on 7/30/25.
//

import SwiftUI
import Photos

struct ScreenshotViewerView: View {
    let screenshots: [Screenshot]
    @State var currentIndex: Int
    var onDelete: (() -> Void)? // ✅ callback to notify parent grid
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            TabView(selection: $currentIndex) {
                ForEach(0..<screenshots.count, id: \.self) { index in
                    ScreenshotFullImage(asset: screenshots[index].asset)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .edgesIgnoringSafeArea(.top)

            HStack(spacing: 30) {
                Button(action: deleteCurrent) {
                    Label("Delete", systemImage: "trash")
                        .font(.system(size: 18, weight: .bold, design: .monospaced))
                }
                .foregroundColor(.red)

                Button(action: favoriteCurrent) {
                    Label("Favorite", systemImage: "star.fill")
                        .font(.system(size: 18, weight: .bold, design: .monospaced))
                }
                .foregroundColor(.yellow)
            }
            .padding()
        }
        .background(Color.black.opacity(0.95))
    }

    private func deleteCurrent() {
        let asset = screenshots[currentIndex].asset

        PHPhotoLibrary.shared().performChanges {
            PHAssetChangeRequest.deleteAssets([asset] as NSArray)
        } completionHandler: { success, error in
            if success {
                DispatchQueue.main.async {
                    // ✅ Notify the grid to refresh
                    onDelete?()
                    // ✅ Optional: dismiss this view
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }

    private func favoriteCurrent() {
        let asset = screenshots[currentIndex].asset

        PHPhotoLibrary.shared().performChanges {
            let request = PHAssetChangeRequest(for: asset)
            request.isFavorite = true
        } completionHandler: { success, error in
            if success {
                print("Favorited")
            }
        }
    }
}
