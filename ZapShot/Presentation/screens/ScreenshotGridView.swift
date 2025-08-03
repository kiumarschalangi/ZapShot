//
//  ScreenshotGridView.swift
//  ZapShot
//
//  Created by kiumars  chaharlangi on 7/30/25.
//


import SwiftUI
import PhotosUI

struct ScreenshotGridView: View {
    @StateObject private var viewModel = ScreenshotListViewModel()

    let columns = [GridItem(.adaptive(minimum: 100), spacing: 8)]

    var body: some View {
        NavigationView {
            VStack {
                Text("Total Space: \(String(format: "%.2f", viewModel.totalSizeInMB)) MB")
                    .font(.system(size: 14, weight: .bold, design: .monospaced))
                    .padding()

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(viewModel.screenshots.indices, id: \.self) { index in
                            NavigationLink(
                                destination: ScreenshotViewerView(
                                    screenshots: viewModel.screenshots,
                                    currentIndex: index,
                                    onDelete: {
                                               viewModel.loadScreenshots()
                                           }
                                )
                            ) {
                                ScreenshotThumbnail(asset: viewModel.screenshots[index].asset)
                            }
                        }

                    }
                    .padding(.horizontal, 8)
                }
            }
            .navigationTitle("ZapShot")
            
        }.alert("Photo Access Denied", isPresented: $viewModel.permissionDenied) {
            Button("Settings") {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("ZapShot needs permission to access your screenshots. You can enable it in Settings.")
        }
    }
}


#Preview {
    ScreenshotGridView()
}
