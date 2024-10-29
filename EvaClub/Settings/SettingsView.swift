//
//  SettingsView.swift
//  EvaClub
//
//  Created by D K on 24.10.2024.
//

import SwiftUI
import MessageUI
import StoreKit
import LocalAuthentication


struct SettingsView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var isAlertShown = false
    @State var isSuggestionShown = false
    @State var isErrorShown = false
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var isDeleteAlertShown = false
    
    @State var isPasswordShown = false
    
    @State var password = ""
    @State var isFaceIDEnabled = false
    @State var isCodeAlertShown = false
    
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
                        
                    }
                    .padding(.horizontal, 30)
                    
                    ScrollView {
                        Button {
                            if MFMailComposeViewController.canSendMail() {
                                isErrorShown.toggle()
                            } else {
                                isAlertShown.toggle()
                            }
                        } label: {
                            Rectangle()
                                .frame(width: size().width - 80, height: 70)
                                .foregroundColor(.gray)
                                .cornerRadius(36)
                                .overlay {
                                    Text("FEEDBACK")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 22, weight: .black))
                                }
                                .padding(.top)
                        }
                        .sheet(isPresented: $isErrorShown) {
                            MailComposeView(isShowing: $isErrorShown, subject: "Error message", recipientEmail: "pinaroymacii@icloud.com", textBody: "")
                        }
                        
                        Button {
                            openPrivacyPolicy()
                        } label: {
                            Rectangle()
                                .frame(width: size().width - 80, height: 70)
                                .foregroundColor(.gray)
                                .cornerRadius(36)
                                .overlay {
                                    Text("PRIVACY POLICY")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 22, weight: .black))
                                }
                                .padding(.top)
                        }
                        
                        
                        
                        Button {
                            requestAppReview()
                        } label: {
                            Rectangle()
                                .frame(width: size().width - 80, height: 70)
                                .foregroundColor(.gray)
                                .cornerRadius(36)
                                .overlay {
                                    Text("RATE THE APP")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 22, weight: .black))
                                }
                                .padding(.top)
                        }
                        
                        
                        if UserDefaults.standard.string(forKey: "code") != nil {
                            Button {
                                isCodeAlertShown.toggle()
                            } label: {
                                Rectangle()
                                    .fill(LinearGradient(colors: [.buttonOrangeDark, .buttonOrangeLight], startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius(36)
                                    .frame(height: 80)
                                    .overlay {
                                        Text("DISABLE PASSCODE")
                                            .foregroundStyle(.white)
                                            .font(.system(size: 28, weight: .black))
                                    }
                            }
                            .padding(.horizontal, 25)
                            .padding(.top, 10)
                            .alert("Are you sure?", isPresented: $isCodeAlertShown) {
                                Button {
                                    UserDefaults.standard.setValue(nil, forKey: "code")
                                    UserDefaults.standard.setValue(nil, forKey: "faceid")
                                } label: {
                                    Text("Yes")
                                }
                                
                                Button {
                                    
                                } label: {
                                    Text("No")
                                }
                            }
                        } else {
                            Button {
                                withAnimation {
                                    isPasswordShown.toggle()
                                }
                            } label: {
                                Rectangle()
                                    .frame(width: size().width - 80, height: 70)
                                    .foregroundColor(.gray)
                                    .cornerRadius(36)
                                    .overlay {
                                        Text("SET PASSCODE")
                                            .foregroundStyle(.white)
                                            .font(.system(size: 22, weight: .black))
                                    }
                                    .padding(.top)
                            }
                        }
                        
                        
                        
                        Button {
                            authViewModel.signOut()
                        } label: {
                            Rectangle()
                                .fill(LinearGradient(colors: [.buttonOrangeDark, .buttonOrangeLight], startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(36)
                                .frame(width: size().width - 80, height: 70)
                                .overlay {
                                    Text("SIGN OUT")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 28, weight: .black))
                                }
                        }
                        .padding(.horizontal, 25)
                        .padding(.top, 100)
                        
                        if authViewModel.currentuser != nil {
                            Button {
                                isDeleteAlertShown.toggle()
                            } label: {
                                Rectangle()
                                    .fill(LinearGradient(colors: [.buttonGrayLight, .buttonGrayDark], startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius(36)
                                    .frame(height: 60)
                                    .opacity(0.5)
                                    .overlay {
                                        Text("DELETE ACCOUNT")
                                            .foregroundStyle(.white)
                                            .font(.system(size: 14, weight: .black))
                                            .opacity(0.8)
                                    }
                            }
                            .padding(.horizontal, 90)
                            .padding(.top, 20)
                        }
                    }
                }
            }
        }
        .alert("Are you sure you want to delete your account?", isPresented: $isDeleteAlertShown) {
            Button {
                authViewModel.deleteUserAccount { result in
                    switch result {
                    case .success():
                        print("Account deleted successfully.")
                        authViewModel.userSession = nil
                        authViewModel.currentuser = nil
                    case .failure(let error):
                        print("ERROR DELELETING: \(error.localizedDescription)")
                    }
                }
            } label: {
                Text("Yes")
            }
            
            Button {
                isDeleteAlertShown.toggle()
            } label: {
                Text("No")
            }
        } message: {
            Text("To access your reserves you will need to create a new account.")
        }
        .alert("Unable to send email", isPresented: $isAlertShown) {
            Button {
                isAlertShown.toggle()
            } label: {
                Text("Ok")
            }
        } message: {
            Text("Your device does not have a mail client configured. Please configure your mail or contact support on our website.")
        }
        
        .overlay {
            if isPasswordShown {
                ZStack {
                    VStack {
                        HStack {
                            Button {
                                withAnimation {
                                    isPasswordShown.toggle()
                                }
                            } label: {
                                Image("buttonPlus")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 10)
                                    .rotationEffect(.degrees(45))
                            }
                            
                            Spacer()
                            
                        }
                        .overlay {
                            Text("Set a password code")
                                .foregroundStyle(.white)
                                .font(.system(size: 26, weight: .black))
                        }
                        .padding(.leading)
                        .padding(.top, 65)

                        
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
                        
                        Toggle(isOn: $isFaceIDEnabled, label: {
                            Text("Enable FaceID")
                                .foregroundStyle(.white)
                        })
                        .padding(.horizontal, 30)
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
                                Button {
                                    
                                } label: {
                                    ZStack {
                                        Circle()
                                            .frame(width: 80, height: 80)
                                        .foregroundColor(.clear)                                                                       }
                                    
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
                                if !password.isEmpty {
                                    UserDefaults.standard.setValue(password, forKey: "code")
                                    UserDefaults.standard.setValue(isFaceIDEnabled, forKey: "faceid")
                                    
                                    withAnimation {
                                        isPasswordShown.toggle()
                                    }
                                }
                                
                            } label: {
                                Rectangle()
                                    .fill(LinearGradient(colors: [.buttonOrangeDark, .buttonOrangeLight], startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius(36)
                                    .frame(height: 80)
                                    .overlay {
                                        Text("SET PASSCODE")
                                            .foregroundStyle(.white)
                                            .font(.system(size: 28, weight: .black))
                                    }
                            }
                            .padding(.horizontal, 25)
                            .padding(.top, 10)
                            .disabled(password.isEmpty)
                            .opacity(password.isEmpty ? 0.5 : 1)
                        }
                        .padding(.top, 25)
                        
                        Spacer()
                    }
                }
                .frame(width: size().width, height: size().height)
                .background(.ultraThinMaterial)
            }
        }
    }
    
    func requestAppReview() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
    
    func openPrivacyPolicy() {
        if let url = URL(string: "https://sites.google.com/view/evaelfclub/privacy-policy") {
            UIApplication.shared.open(url)
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(AuthViewModel())
}


struct MailComposeView: UIViewControllerRepresentable {
    @Binding var isShowing: Bool
    let subject: String
    let recipientEmail: String
    let textBody: String
    var onComplete: ((MFMailComposeResult, Error?) -> Void)?
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mailComposer = MFMailComposeViewController()
        mailComposer.setSubject(subject)
        mailComposer.setToRecipients([recipientEmail])
        mailComposer.setMessageBody(textBody, isHTML: false)
        mailComposer.mailComposeDelegate = context.coordinator
        return mailComposer
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        let parent: MailComposeView
        
        init(_ parent: MailComposeView) {
            self.parent = parent
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            parent.isShowing = false
            parent.onComplete?(result, error)
        }
    }
}
