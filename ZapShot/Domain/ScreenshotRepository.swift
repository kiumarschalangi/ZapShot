//
//  ScreenshotRepository.swift
//  ZapShot
//
//  Created by kiumars  chaharlangi on 7/30/25.
//


protocol ScreenshotRepository {
    func fetchScreenshots(completion: @escaping ([Screenshot]) -> Void)
    func getTotalScreenshotSize(completion: @escaping (Int) -> Void)
}
