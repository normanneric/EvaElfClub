//
//  SigninView.swift
//  EvaClub
//
//  Created by D K on 24.10.2024.
//

import SwiftUI

struct SigninView: View {
    
    
    @Environment(\.dismiss) var dismiss
    
    @State var email = ""
    @State var name = ""
    @State var password = ""
    @State var passwordConfirm = ""
    
    @ObservedObject var viewModel: AuthViewModel
    
    @State private var isNotificationShown = false
    @State private var switched = true
    @State private var isAlerted = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .foregroundColor(.darkGray)
                    .ignoresSafeArea()
                    
                VStack {
                    
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                        Image("buttonXmark")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 40)
                        }
                        
                        Spacer()
                    }
                    
                    Text("REGISTRATION")
                        .foregroundStyle(.white)
                        .font(.system(size: 34, weight: .black))
                    
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
                    
                    TextField("", text: $name, prompt: Text("Name:").foregroundColor(.black.opacity(0.8)))
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
                    
                    SecureField("", text: $passwordConfirm, prompt: Text("Confirm password:").foregroundColor(.black.opacity(0.8)))
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
                    
                    Spacer()
                    
                    Button {
                        if isValid {
                            Task {
                                try await viewModel.createUser(withEmail: email, password: password, name: name)
                            }
                            withAnimation {
                                isAlerted.toggle()
                            }
                        } else {
                            withAnimation {
                                isAlerted.toggle()
                            }
                            isNotificationShown.toggle()
                        }
                    } label: {
                        Rectangle()
                            .fill(LinearGradient(colors: [.buttonOrangeDark, .buttonOrangeLight], startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(36)
                            .frame(height: 80)
                            .overlay {
                                Text("SIGN UP")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 28, weight: .black))
                            }
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 20)
                    
                    
                    Button {
                        dismiss()
                    } label: {
                        Rectangle()
                            .fill(LinearGradient(colors: [.buttonGrayLight, .buttonGrayDark], startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(36)
                            .frame(height: 60)
                            .opacity(0.5)
                            .overlay {
                                Text("ALREADY HAVE AN ACCOUNT?")
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
        .overlay {
            if isAlerted {
                ZStack {
                    Rectangle()
                        .ignoresSafeArea()
                        .foregroundColor(.white.opacity(0.1))
                    
                    if switched {
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
                                    Text("Incorrect data or user with this email already exists. \n\n\nPlease note that the password must be longer than 8 characters, and the login must contain @ and domain.")
                                        .foregroundStyle(.black)
                                        .font(.system(size: 14, weight: .semibold, design: .monospaced))
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal)
                                    
                                    Button {
                                        withAnimation {
                                            isAlerted = false
                                            switched = true
                                            
                                            email = ""
                                            password = ""
                                            name = ""
                                            passwordConfirm = ""
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
                        switched = false
                    }
                }
            }
        }
    }
}

#Preview {
    SigninView(viewModel: AuthViewModel())
}


extension SigninView: AuthViewModelProtocol {
    var isValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && !name.isEmpty
        && password.count > 5
        && passwordConfirm == password
    }
}
