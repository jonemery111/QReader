//
//  ContentView.swift
//  QReader
//
//  Created by Jon Emery on 11/19/24.
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var title = ""
    @State private var url = ""
    
    let contect = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationView {
            Form() {
                TextField("Title", text: $title)
                    .padding()
                    .textContentType(.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                
                TextField("URL", text: $url)
                    .padding()
                    .textContentType(.URL)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Image(uiImage: generateQRCode(string: url))
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 200 , height:  200)
                    
            }
            .navigationTitle("QReader")
        }
        
    }
    func generateQRCode(string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgimg = contect.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

#Preview {
    ContentView()
}
