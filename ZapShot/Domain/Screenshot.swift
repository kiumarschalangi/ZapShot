//
//  Screenshot.swift
//  ZapShot
//
//  Created by kiumars  chaharlangi on 7/30/25.
//

import Photos


struct Screenshot: Identifiable {
    let id: String
    let asset: PHAsset
    let sizeInBytes: Int
}
