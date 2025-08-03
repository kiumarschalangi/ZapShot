//
//  ScreenshotThumbnail.swift
//  ZapShot
//
//  Created by kiumars  chaharlangi on 7/30/25.
//


import SwiftUI
import Photos

struct ScreenshotThumbnail: View {
    let asset: PHAsset
    @State private var image: UIImage? = nil

    var body: some View {
        Group {
            if let img = image {
                Image(uiImage: img)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipped()
                    .cornerRadius(6)
            } else {
                Color.gray.frame(width: 100, height: 100)
            }
        }
        .onAppear {
            loadImage()
        }
    }

    private func loadImage() {
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.isSynchronous = false
        options.deliveryMode = .opportunistic

        manager.requestImage(for: asset,
                             targetSize: CGSize(width: 150, height: 150),
                             contentMode: .aspectFill,
                             options: options) { result, _ in
            if let result = result {
                self.image = result
            }
        }
    }
}
