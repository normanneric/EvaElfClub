//
//  TermsOfUseView.swift
//  EvaClub
//
//  Created by D K on 29.10.2024.
//

import SwiftUI

struct TermsOfUseView: View {
    
    @State var isON = false
    
    var completion: () -> ()
    var dismiss: () -> ()
    
    var body: some View {
        ZStack {
            VStack {
                
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                }
                .padding(.top, 50)
                .padding(.leading, 20)
                
                ScrollView {
                    VStack {
                        Text(DataManager.shared.terms)
                            .foregroundStyle(.white)
                            
                        HStack {
                            Toggle("I accept the terms of use", isOn: $isON)
                                .foregroundStyle(.white)
                            Spacer()
                        }
                        
                        Button {
                           completion()
                        } label: {
                            Rectangle()
                                .fill(LinearGradient(colors: [.buttonOrangeDark, .buttonOrangeLight], startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(36)
                                .frame(height: 80)
                                .overlay {
                                    Text("Start Chat")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 28, weight: .black))
                                }
                        }
                        .padding(.horizontal, 25)
                        .padding(.top, 20)
                        .disabled(!isON)
                        .opacity(isON ? 1 : 0.5)
                    }
                    
                }
                .padding()
                .padding(.vertical, 10)
            }
        }
        .background(.ultraThinMaterial)
        .frame(width: size().width, height: size().height)
    }
}

#Preview {
    TermsOfUseView() {
        
    } dismiss: {
        
    }
}
