//
//  LoginView.swift
//  EvaClub
//
//  Created by D K on 22.10.2024.
//

import SwiftUI

struct LoginView: View {
    
    @State var email = ""
    @State var password = ""
    
    @State var isAlertShown = false
    @State var switcher = true
    
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .foregroundColor(.darkGray)
                    .ignoresSafeArea()
                    
                VStack {
                    Image("logo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 250, height: 250)
                        .clipped()
                        .padding(.top, -30)
                       
                    
                    TextField("", text: $email, prompt: Text("E-mail:").foregroundColor(.black.opacity(0.8)))
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .padding()
                        .padding(.vertical, 5)
                        .foregroundColor(.black)
                        .tint(.black)
                        .background {
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(36)
                        }
                        .padding(.horizontal, 25)
                        .padding(.top, 20)
                    
                    SecureField("", text: $password, prompt: Text("Password:").foregroundColor(.black.opacity(0.8)))
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .padding()
                        .padding(.vertical, 5)
                        .foregroundColor(.black)
                        .tint(.black)
                        .background {
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(36)
                        }
                        .padding(.horizontal, 25)
                        .padding(.top, 20)
                    
                    
                    Button {
                        Task {
                            try await viewModel.signIn(email: email, password: password)
                        }
                        withAnimation {
                            isAlertShown.toggle()
                        }
                    } label: {
                        Rectangle()
                            .fill(LinearGradient(colors: [.buttonOrangeDark, .buttonOrangeLight], startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(36)
                            .frame(height: 80)
                            .overlay {
                                Text("LOG IN")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 28, weight: .black))
                            }
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 20)
                    
                    Button {
                        Task {
                            await viewModel.signInAnonymously()
                        }
                        withAnimation {
                            isAlertShown.toggle()
                        }
                    } label: {
                        Rectangle()
                            .fill(LinearGradient(colors: [.buttonOrangeDark, .buttonOrangeLight], startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(36)
                            .frame(height: 80)
                            .opacity(0.5)
                            .overlay {
                                Text("CONTINUE AS A GUEST")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 14, weight: .black))
                                    .opacity(0.8)
                            }
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 20)
                    
                    NavigationLink {
                        SigninView(viewModel: viewModel).navigationBarBackButtonHidden()
                    } label: {
                        Rectangle()
                            .fill(LinearGradient(colors: [.buttonGrayLight, .buttonGrayDark], startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(36)
                            .frame(height: 60)
                            .opacity(0.5)
                            .overlay {
                                Text("DON'T HAVE AN ACCOUNT YET? \nSIGN UP NOW")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 10, weight: .black))
                                    .opacity(0.8)
                            }
                    }
                    .padding(.horizontal, 90)
                    .padding(.top, 20)
                    
                    Spacer()
                }
            }
        }
        .tint(.white)
        .overlay {
            if isAlertShown {
                ZStack {
                    Rectangle()
                        .ignoresSafeArea()
                        .foregroundColor(.white.opacity(0.1))
                    
                    if switcher {
                        Rectangle()
                            .frame(width: 70, height: 70)
                            .foregroundColor(.white.opacity(0.9))
                            .blur(radius: 5)
                            .cornerRadius(24)
                            .shadow(color: .white.opacity(0.5), radius: 5)
                            .overlay {
                                ProgressView()
                                    .tint(.buttonOrangeDark)
                                    .controlSize(.large)
                            }
                    } else {
                        Rectangle()
                            .frame(width: 290, height: 250)
                            .foregroundColor(.white.opacity(0.9))
                            .blur(radius: 5)
                            .cornerRadius(24)
                            .shadow(color: .white.opacity(0.5), radius: 5)
                            .overlay {
                                VStack {
                                    Text("Incorrect email or password.")
                                        .foregroundStyle(.black)
                                        .font(.system(size: 24, weight: .semibold, design: .monospaced))
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal)
                                    
                                    Button {
                                        withAnimation {
                                            isAlertShown = false
                                            switcher = true
                                        }
                                    } label: {
                                       Image(systemName: "xmark")
                                            .frame(width: 40, height: 40)
                                            .foregroundColor(.black)
                                            .bold()
                                    }
                                    .padding(.top, 30)
                                }
                               
                            }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        switcher = false
                    }
                }
            }
        }
    }
}

#Preview {
    LoginView(viewModel: AuthViewModel())
}
