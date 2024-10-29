//
//  AddFriendDetailView.swift
//  EvaClub
//
//  Created by D K on 24.10.2024.
//

import SwiftUI

struct AddFriendDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    var completion: () -> ()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .foregroundColor(.darkGray)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack {
                        Circle()
                            .fill(LinearGradient(colors: [.buttonOrangeDark, .buttonOrangeLight], startPoint: .bottom, endPoint: .top))
                            .frame(width: 270, height: 270)
                            .overlay {
                                ZStack {
                                    Image("girl")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 260, height: 260)
                                        .clipShape(Circle())
                                }
                            }
                        
                        Rectangle()
                            .frame(width: size().width - 40, height: 70)
                            .foregroundColor(.white)
                            .cornerRadius(36)
                            .overlay {
                                Text("SARAH")
                                    .foregroundStyle(.black)
                                    .font(.system(size: 22, weight: .black))
                            }
                            .padding(.top)

                        
                        Rectangle()
                            .frame(width: size().width - 40, height: 70)
                            .foregroundColor(.white)
                            .cornerRadius(36)
                            .overlay {
                                Text("23 YEARS")
                                    .foregroundStyle(.black)
                                    .font(.system(size: 22, weight: .black))
                            }
                            .padding(.top)
                                                
                        Button {
                            UserDefaults.standard.set(true, forKey: "friend")
                            completion()
                            dismiss()
                        } label: {
                            Rectangle()
                                .fill(LinearGradient(colors: [.buttonOrangeDark, .buttonOrangeLight], startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(36)
                                .frame(height: 80)
                                .overlay {
                                    Text("CONNECT")
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
                                    Text("CANCEL")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 20, weight: .black))
                                        .opacity(0.8)
                                }
                        }
                        .padding(.horizontal, 90)
                        .padding(.top, 20)
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}

#Preview {
    AddFriendDetailView(){}
}
