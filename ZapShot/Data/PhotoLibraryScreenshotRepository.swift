//
//  PhotoLibraryScreenshotRepository.swift
//  ZapShot
//
//  Created by kiumars  chaharlangi on 7/30/25.
//

import Photos


class PhotoLibraryScreenshotRepository: ScreenshotRepository {
    func fetchScreenshots(completion: @escaping ([Screenshot]) -> Void) {
        var results = [Screenshot]()
        let fetchOptions = PHFetchOptions()
        let assets = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        assets.enumerateObjects { asset, _, _ in
            if asset.mediaSubtypes.contains(.photoScreenshot) {
                let size = Self.getAssetSize(asset: asset)
                let screenshot = Screenshot(id: asset.localIdentifier, asset: asset, sizeInBytes: size)
                results.append(screenshot)
            }
        }
        
        completion(results)
    }
    
    func getTotalScreenshotSize(completion: @escaping (Int) -> Void) {
        fetchScreenshots { screenshots in
            let totalSize = screenshots.reduce(0) { $0 + $1.sizeInBytes }
            completion(totalSize)
        }
    }

    private static func getAssetSize(asset: PHAsset) -> Int {
        let resources = PHAssetResource.assetResources(for: asset)
        return resources.first?.value(forKey: "fileSize") as? Int ?? 0
    }
}
