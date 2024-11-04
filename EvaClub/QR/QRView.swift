//
//  QRView.swift
//  EvaClub
//
//  Created by D K on 03.11.2024.
//

import SwiftUI
import CoreImage.CIFilterBuiltins


struct QRView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var isAlertShown = false
    @State private var qrImage: UIImage = UIImage()
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        ZStack {
            Image("bg")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image("buttonPlus")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .rotationEffect(.degrees(45))
                    }
                    
                    Spacer()
                    
                    Button {
                        isAlertShown.toggle()
                    } label: {
                        Image("buttonInfo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 38, height: 35)
                    }
                }
                .padding(.horizontal, 30)
                
                Text("QR")
                    .foregroundStyle(.white)
                    .font(.system(size: 34, weight: .black))
                    .offset(y: -40)
                
                RoundedRectangle(cornerRadius: 36)
                    .frame(width: 350, height: 350)
                    .foregroundColor(.white)
                    .overlay {
                        Image(uiImage: qrImage)
                            .interpolation(.none)
                            .resizable()
                            .frame(width: 290, height: 290)
                    }
                
                Text("Individual code:".uppercased())
                    .foregroundStyle(.gray)
                    .font(.system(size: 22, weight: .light))
                    .frame(width: size().width - 40, alignment: .leading)
                    .padding(.top)
                
                Text("511 723 048".uppercased())
                    .foregroundStyle(.white)
                    .font(.system(size: 32, weight: .black))
                    .frame(width: size().width - 40, alignment: .leading)
                    .padding(.top, 1)
                
                Text("Active order:".uppercased())
                    .foregroundStyle(.gray)
                    .font(.system(size: 22, weight: .light))
                    .frame(width: size().width - 40, alignment: .leading)
                    .padding(.top)
                
                Text("\(UserDefaults.standard.string(forKey: "order") ?? "")".uppercased())
                    .foregroundStyle(.white)
                    .font(.system(size: 32, weight: .black))
                    .frame(width: size().width - 40, alignment: .leading)
                    .padding(.top, 1)
                
                Spacer()
            }
        }
        .alert("Loyalty program", isPresented: $isAlertShown) {
            Text("OK")
        } message: {
            Text("Show the QR code to the manager and get a 10 percent discount on the menu and other entertainment in the club.")
        }
        .onAppear {
            qrImage = generateQRCode(from: "511 723 048")
        }
    }
        
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data("http://evaElfClub.com/?sub1\(string)".utf8)

        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

#Preview {
    QRView()
}
