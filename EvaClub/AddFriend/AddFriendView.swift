//
//  AddFriendView.swift
//  EvaClub
//
//  Created by D K on 24.10.2024.
//

import SwiftUI
import AVKit
import AVFoundation

struct AddFriendView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var qrDelegate = QRScannerDelegate()
    @StateObject private var vm = ScanerViewModel()
    @Environment(\.openURL) private var openURL
    
    @State private var isScanning: Bool = false
    @State private var session: AVCaptureSession = .init()
    @State private var cameraPermission: Permission = .idle
    @State private var qrOutput: AVCaptureMetadataOutput = .init()
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    @State private var scannedCode: String = ""
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var isImageShown = false
    @State var wrongAttempt: Bool = false
    
    @State var isAlertShown = false
    
    @State var isInfoShown = false
    
    var completion: (Bool) -> ()
    
    var body: some View {
        NavigationStack {
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

                        
                        Text("NEW \nFRIEND")
                            .foregroundStyle(.white)
                            .font(.system(size: 34, weight: .black))
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                        Button {
                            isInfoShown.toggle()
                        } label: {
                            Image("buttonInfo")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 38, height: 35)
                        }
                        .alert("Info", isPresented: $isInfoShown) {
                            Button {
                                 
                            } label: {
                                Text("OK")
                            }
                        } message: {
                            Text("To create a new connection, scan the QR code on your interlocutor's bracelet.")
                        }

                    }
                    .padding(.horizontal, 30)
                    
                    if cameraPermission == .idle {
                        Text("Please provide access to the camera. This will allow you to scan the QR code to create a new connection.")
                            .foregroundColor(.gray)
                            .font(.system(size: 22))
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        Button(action: openSettings) {
                            Label("Open settings?", systemImage: "gear")
                                .foregroundColor(.white)
                        }
                        
                    } else {
                        GeometryReader {
                            let size = $0.size
                            let sqareWidth = min(size.width, 300)
                            
                            ZStack {
                                CameraView(frameSize: CGSize(width: sqareWidth, height: sqareWidth), session: $session, orientation: $orientation)
                                    .cornerRadius(4)
                                    .scaleEffect(0.97)
                                
                                ForEach(0...4, id: \.self) { index in
                                    let rotation = Double(index) * 90
                                    
                                    RoundedRectangle(cornerRadius: 2, style: .circular)
                                        .trim(from: 0.61, to: 0.64)
                                        .stroke(Color.buttonOrangeLight, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                                        .rotationEffect(.init(degrees: rotation))
                                }
                            }
                            .frame(width: sqareWidth, height: sqareWidth)
                            .overlay(alignment: .top, content: {
                                Rectangle()
                                    .fill(Color.buttonOrangeLight)
                                    .frame(height: 2.5)
                                    .shadow(color: .black.opacity(0.8), radius: 8, x: 0, y: isScanning ? 15 : -15)
                                    .offset(y: isScanning ? sqareWidth : 0)
                            })
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .padding(.horizontal, 45)
                       
                        .onAppear(perform: checkCameraPermission)
                        .onDisappear {
                            session.stopRunning()
                        }
                        .onChange(of: qrDelegate.scannedCode) { newValue in
                            if UserDefaults.standard.bool(forKey: "friend") {
                                session.stopRunning()
                                deActivateScannerAnimation()
                                qrDelegate.scannedCode = nil
                                isAlertShown = true
                            } else {
                                if let code = newValue, code.contains("EvaClub") {
                                    scannedCode = code
                                    session.stopRunning()
                                    deActivateScannerAnimation()
                                    qrDelegate.scannedCode = nil
                                    isImageShown.toggle()
                                    dismiss()
                                    completion(isImageShown)
                                }
                            }
                          
                        }
                        .onChange(of: session.isRunning) { newValue in
                            if newValue {
                                orientation = UIDevice.current.orientation
                            }
                        }
                        .alert("Not Valid", isPresented: $isAlertShown) {
                            Button {
                                checkCameraPermission()
                            } label: {
                                Text("OK")
                            }
                        } message: {
                            Text("QR code is not valid")
                        }

                        
                        Spacer()
                        
                        Button {
                            if scannedCode.isEmpty {
                                vm.toggleFlashlight()
                            } else {
                                if !session.isRunning && cameraPermission == .approved {
                                    reactivateCamera()
                                    activateScannerAnimation()
                                    scannedCode = ""
                                }
                            }
                        } label:  {
                            Image("buttonFlash")
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                        .shadow(color: vm.isOn ? .white : .clear, radius: 5)
                    }
                    
                    Spacer()
                }
            }
        }
        .onAppear(perform: checkCameraPermission)
    }
    
    private func openSettings() {
        openURL(URL(string: UIApplication.openSettingsURLString)!)
    }
    
    
    func reactivateCamera() {
        DispatchQueue.global(qos: .background).async {
            session.startRunning()
        }
    }
    
    func activateScannerAnimation() {
        withAnimation(.easeInOut(duration: 0.85).delay(0.1).repeatForever(autoreverses: true)) {
            isScanning = true
        }
    }
    
    func deActivateScannerAnimation() {
        withAnimation(.easeInOut(duration: 0.85)) {
            isScanning = false
        }
    }
    
    func checkCameraPermission() {
        Task {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                cameraPermission = .approved
                if session.inputs.isEmpty {
                    setupCamera()
                } else {
                    reactivateCamera()
                }
            case .notDetermined:
                if await AVCaptureDevice.requestAccess(for: .video) {
                    cameraPermission = .approved
                    setupCamera()
                } else {
                    cameraPermission = .denied
                    presentError("Please Provide Access to Camera for scanning codes")
                }
            case .denied, .restricted:
                cameraPermission = .denied
                presentError("Please Provide Access to Camera for scanning codes")
            default: break
            }
        }
    }
    
    func setupCamera() {
        do {
            guard let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back).devices.first else {
                presentError("UNKNOWN DEVICE ERROR")
                return
            }
            let input = try AVCaptureDeviceInput(device: device)
            guard session.canAddInput(input), session.canAddOutput(qrOutput) else {
                presentError("UNKNOWN INPUT/OUTPUT ERROR")
                return
            }
            
            session.beginConfiguration()
            session.addInput(input)
            session.addOutput(qrOutput)
            qrOutput.metadataObjectTypes = [.qr]
            qrOutput.setMetadataObjectsDelegate(qrDelegate, queue: .main)
            session.commitConfiguration()
            DispatchQueue.global(qos: .background).async {
                session.startRunning()
            }
            activateScannerAnimation()
        } catch {
            presentError(error.localizedDescription)
        }
    }
    
    func presentError(_ message: String) {
        errorMessage = message
        showError.toggle()
    }
}

#Preview {
    AddFriendView(){_ in }
}

struct CameraView: UIViewRepresentable {
    var frameSize: CGSize
    @Binding var session: AVCaptureSession
    @Binding var orientation: UIDeviceOrientation
    func makeUIView(context: Context) -> UIView {
        let view = UIViewType(frame: CGRect(origin: .zero, size: frameSize))
        view.backgroundColor = .clear
        
        let cameraLayer = AVCaptureVideoPreviewLayer(session: session)
        cameraLayer.frame = .init(origin: .zero, size: frameSize)
        cameraLayer.videoGravity = .resizeAspectFill
        cameraLayer.masksToBounds = true
        view.layer.addSublayer(cameraLayer)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        if let layer = uiView.layer.sublayers?.first(where: { layer in
            layer is AVCaptureVideoPreviewLayer
        }) as? AVCaptureVideoPreviewLayer {
            switch orientation {
            case .portrait: layer.setAffineTransform(.init(rotationAngle: 0))
            case .landscapeLeft: layer.setAffineTransform(.init(rotationAngle: -.pi / 2))
            case .landscapeRight: layer.setAffineTransform(.init(rotationAngle: .pi / 2))
            case .portraitUpsideDown: layer.setAffineTransform(.init(rotationAngle: .pi))
            default: break
            }
        }
    }
}

enum Permission: String {
    case idle = "Not Determined"
    case approved = "Access Granted"
    case denied = "Access Denied"
}

class ScanerViewModel: ObservableObject {
    
    @Published var isOn = false
    
    func toggleFlashlight() {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                
                if isOn {
                    device.torchMode = .off
                } else {
                    device.torchMode = .on
                }
                
                device.unlockForConfiguration()
                isOn.toggle()
            } catch {
                print("\(error.localizedDescription)")
            }
        } else {
            print("error")
        }
    }
    
}

class QRScannerDelegate: NSObject, ObservableObject, AVCaptureMetadataOutputObjectsDelegate {
    @Published var scannedCode: String?
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metaObject = metadataObjects.first {
            guard let readableObject = metaObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let Code = readableObject.stringValue else { return }
            scannedCode = Code
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    }
}

struct QRImageView: View {
    
    @Environment(\.dismiss) var dismiss
    var imageString: String
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    if let url = URL(string: imageString) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: size().width, height: size().height)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
            }
            
        }
        .overlay {
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                        
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding(.top, 9)
            .padding(.leading)
        }
        
    }
}
