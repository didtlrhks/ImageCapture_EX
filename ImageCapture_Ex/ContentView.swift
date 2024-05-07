
import SwiftUI



struct ContentView: View {
     var exampleView = ExampleView()
    
    var body: some View {
        VStack {
            exampleView
                .padding()
            
            Button("Share Snapshot") {
                let image = exampleView.snapshot()
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
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true) // 변경된 부분
        }
    }
}
//캡쳐기능 추가하기


func shareImage(_ image: UIImage) { // 이미지 공유부분
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
    @State private var inputText = ""
    
    
    var body: some View {
           VStack {
               Image(systemName: "globe")
                   .imageScale(.large)
                   .foregroundColor(.blue)
                   .padding()

               Text("Hello, World!")
                   .font(.title)
                   .foregroundColor(.primary)

               TextField("Enter something...", text: $inputText)  // 텍스트 필드 추가
                   .textFieldStyle(RoundedBorderTextFieldStyle())  // 텍스트 필드 스타일 지정
                   .padding()

           }
           .padding()
           .background(Color.gray.opacity(0.2))
           .cornerRadius(10)
       }
   }
