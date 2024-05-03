//
//  ContentView.swift
//  ImageCapture_Ex
//
//  Created by 양시관 on 5/3/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            ExampleView()
                .padding()
            
            Button("Share Snapshot") {
                let image = ExampleView().snapshot()
                shareImage(image)
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
    }
}




extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}


func shareImage(_ image: UIImage) {
    guard let window = UIApplication.shared.windows.first else { return }
    let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
    
    if let popoverController = activityVC.popoverPresentationController {
        popoverController.sourceView = window.rootViewController?.view
        popoverController.sourceRect = CGRect(x: window.bounds.midX, y: window.bounds.midY, width: 0, height: 0)
        popoverController.permittedArrowDirections = []
    }
    
    window.rootViewController?.present(activityVC, animated: true)
}



struct ExampleView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.blue)
                .padding()
            Text("Hello, World!")
                .font(.title)
                .foregroundColor(.primary)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}
