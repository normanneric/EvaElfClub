//
//  PassView.swift
//  EvaClub
//
//  Created by D K on 25.10.2024.
//

import SwiftUI
import LocalAuthentication


struct PassView: View {
    
    @State var password = ""
    var completion: () -> ()
    
    var body: some View {
        ZStack {
            VStack {
                TextField("", text: $password, prompt: Text("0000"))
                    .foregroundColor(.black)
                    .padding()
                    .background {
                        Rectangle()
                            .frame(width: size().width - 40, height: 80)
                            .foregroundColor(.white)
                            .cornerRadius(24)
                    }
                    .padding()
                    .padding(.top, 15)
              
                
                VStack(spacing: 30) {
                    //1 2 3
                    HStack(spacing: 30) {
                        Button {
                            password.append("1")
                        } label: {
                            ZStack {
                                Circle()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.buttonOrangeLight)
                                
                                Text("1")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 32, weight: .black))
                            }
                            
                        }
                        
                        Button {
                            password.append("2")
                        } label: {
                            ZStack {
                                Circle()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.buttonOrangeLight)
                                
                                Text("2")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 32, weight: .black))
                            }
                            
                        }
                        
                        Button {
                            password.append("3")
                        } label: {
                            ZStack {
                                Circle()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.buttonOrangeLight)
                                
                                Text("3")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 32, weight: .black))
                            }
                            
                        }
                    }
                    
                    //4 5 6
                    
                    HStack(spacing: 30) {
                        Button {
                            password.append("4")
                        } label: {
                            ZStack {
                                Circle()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.buttonOrangeLight)
                                
                                Text("4")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 32, weight: .black))
                            }
                            
                        }
                        
                        Button {
                            password.append("5")
                        } label: {
                            ZStack {
                                Circle()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.buttonOrangeLight)
                                
                                Text("5")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 32, weight: .black))
                            }
                            
                        }
                        
                        Button {
                            password.append("6")
                        } label: {
                            ZStack {
                                Circle()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.buttonOrangeLight)
                                
                                Text("6")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 32, weight: .black))
                            }
                            
                        }
                    }
                    
                    // 7 8 9
                    
                    HStack(spacing: 30) {
                        Button {
                            password.append("7")
                        } label: {
                            ZStack {
                                Circle()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.buttonOrangeLight)
                                
                                Text("7")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 32, weight: .black))
                            }
                            
                        }
                        
                        Button {
                            password.append("8")
                        } label: {
                            ZStack {
                                Circle()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.buttonOrangeLight)
                                
                                Text("8")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 32, weight: .black))
                            }
                            
                        }
                        
                        Button {
                            password.append("9")
                        } label: {
                            ZStack {
                                Circle()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.buttonOrangeLight)
                                
                                Text("9")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 32, weight: .black))
                            }
                            
                        }
                    }
                    
                    // 0
                    
                    HStack(spacing: 30) {
                        if UserDefaults.standard.bool(forKey: "faceid") {
                            Button {
                                authenticateWithFaceID()
                            } label: {
                                ZStack {
                                    Circle()
                                        .frame(width: 80, height: 80)
                                        .foregroundColor(.buttonOrangeLight)
                                    
                                    Image(systemName: "faceid")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 32, weight: .black))
                                }
                            }
                        } else {
                            Button {
                                authenticateWithFaceID()
                            } label: {
                                ZStack {
                                    Circle()
                                        .frame(width: 80, height: 80)
                                        .foregroundColor(.clear)
                                }
                            }
                        }
                       
                        
                        Button {
                            password.append("0")
                        } label: {
                            ZStack {
                                Circle()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.buttonOrangeLight)
                                
                                Text("0")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 32, weight: .black))
                            }
                            
                        }
                        
                        Button {
                            if !password.isEmpty {
                                password.removeLast()
                            }
                        } label: {
                            ZStack {
                                Circle()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.buttonOrangeLight)
                                
                                Image(systemName: "chevron.left")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 32, weight: .black))
                            }
                            
                        }
                    }
                    
                    Button {
                        if password == UserDefaults.standard.string(forKey: "code") {
                            completion()
                        }
                    } label: {
                        Rectangle()
                            .fill(LinearGradient(colors: [.buttonOrangeDark, .buttonOrangeLight], startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(36)
                            .frame(height: 80)
                            .overlay {
                                Text("Enter")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 28, weight: .black))
                            }
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 10)
                    
                }
                .padding(.top, 25)
                
                Spacer()
            }
        }
        .background {
            Rectangle()
                .foregroundColor(.darkGray)
                .ignoresSafeArea()
        }
        .onAppear {
            if UserDefaults.standard.bool(forKey: "faceid") {
                authenticateWithFaceID()
            }
        }
    }
    
    
    private func authenticateWithFaceID() {
            guard UserDefaults.standard.bool(forKey: "faceid") else { return }
            
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Access requires authentication") { success, authenticationError in
                    DispatchQueue.main.async {
                        if success {
                            print("FaceID")
                            completion()
                        } else {
                            print("Bad FaceID")
                        }
                    }
                }
            } else {
                print("No FaceID")
            }
        }
}

#Preview {
    PassView(){}
}
