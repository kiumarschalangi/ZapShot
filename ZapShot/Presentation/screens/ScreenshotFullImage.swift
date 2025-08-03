//
//  ScreenshotFullImage.swift
//  ZapShot
//
//  Created by kiumars  chaharlangi on 7/30/25.
//


import SwiftUI
import Photos

struct ScreenshotFullImage: View {
    let asset: PHAsset
    @State private var image: UIImage?

    var body: some View {
        Group {
            if let img = image {
                Image(uiImage: img)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .onAppear {
            loadImage()
        }
    }

    private func loadImage() {
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isSynchronous = false

        manager.requestImage(for: asset,
                             targetSize: UIScreen.main.bounds.size,
                             contentMode: .aspectFit,
                             options: options) { result, _ in
            self.image = result
        }
    }
}
