//
//  MainView.swift
//  EvaClub
//
//  Created by D K on 24.10.2024.
//

import SwiftUI

struct MainView: View {
    
    @State var isShown = false
    @State var isAddFriendShown = false
    
    @State var isFriendsShown = true
    @State var isChatShown = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("bg")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Text("CHATS")
                            .foregroundStyle(.white)
                            .font(.system(size: 34, weight: .black))
                        
                        Spacer()
                        
                        Button {
                            isShown.toggle()
                        } label: {
                            Image("buttonPlus")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                        }
                    }
                    .padding(.horizontal, 30)
                    
                    if isFriendsShown {
                        ScrollView {
                            VStack {
                                Button {
                                    isChatShown.toggle()
                                } label: {
                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(.buttonOrangeLight)
                                            .frame(width: size().width - 35, height: 105)
                                            .cornerRadius(36)
                                        
                                        Rectangle()
                                            .foregroundColor(.darkGray)
                                            .frame(width: size().width - 40, height: 100)
                                          
                                            .cornerRadius(36)
                                            .overlay {
                                                HStack {
                                                    Image("girl")
                                                        .resizable()
                                                        .frame(width: 80, height: 80)
                                                        .clipShape(Circle())
                                                    VStack(alignment: .leading) {
                                                        Text("Sarah")
                                                                .foregroundStyle(.white)
                                                                .font(.system(size: 26, weight: .black))
                                                        Text("7 days ago")
                                                            .foregroundStyle(.gray)
                                                            .font(.system(size: 12, weight: .black))
                                                    }
                                                    .padding(.leading)
                                                    
                                                    Spacer()
                                                          
                                                        Image(systemName: "checkmark.message")
                                                            .foregroundStyle(.white)
                                                            .font(.system(size: 26, weight: .thin))
                                                }
                                                .padding(.horizontal)
                                            }
                                    }
                                }
//                              
//                                Button {
//                                     
//                                } label: {
//                                    ZStack {
//                                        Rectangle()
//                                            .foregroundColor(.buttonOrangeLight)
//                                            .frame(width: size().width - 35, height: 105)
//                                            .cornerRadius(36)
//                                        
//                                        Rectangle()
//                                            .foregroundColor(.darkGray)
//                                            .frame(width: size().width - 40, height: 100)
//                                          
//                                            .cornerRadius(36)
//                                            .overlay {
//                                                HStack {
//                                                    Image("g11")
//                                                        .resizable()
//                                                        .frame(width: 80, height: 80)
//                                                        .clipShape(Circle())
//                                                    VStack(alignment: .leading) {
//                                                        Text("Karoline")
//                                                                .foregroundStyle(.white)
//                                                                .font(.system(size: 26, weight: .black))
//                                                        Text("5 min ago")
//                                                            .foregroundStyle(.gray)
//                                                            .font(.system(size: 12, weight: .black))
//                                                    }
//                                                    .padding(.leading)
//                                                    
//                                                    Spacer()
//                                                          
//                                                        Image(systemName: "checkmark.message")
//                                                            .foregroundStyle(.white)
//                                                            .font(.system(size: 26, weight: .thin))
//                                                }
//                                                .padding(.horizontal)
//                                            }
//                                    }
//                                }
//                                
//                                Button {
//                                    isChatShown.toggle()
//                                } label: {
//                                    ZStack {
//                                        Rectangle()
//                                            .foregroundColor(.buttonOrangeLight)
//                                            .frame(width: size().width - 35, height: 105)
//                                            .cornerRadius(36)
//                                        
//                                        Rectangle()
//                                            .foregroundColor(.darkGray)
//                                            .frame(width: size().width - 40, height: 100)
//                                          
//                                            .cornerRadius(36)
//                                            .overlay {
//                                                HStack {
//                                                    Image("g44")
//                                                        .resizable()
//                                                        .frame(width: 80, height: 80)
//                                                        .clipShape(Circle())
//                                                    VStack(alignment: .leading) {
//                                                        Text("Charlote")
//                                                                .foregroundStyle(.white)
//                                                                .font(.system(size: 26, weight: .black))
//                                                        Text("15 min ago")
//                                                            .foregroundStyle(.gray)
//                                                            .font(.system(size: 12, weight: .black))
//                                                    }
//                                                    .padding(.leading)
//                                                    
//                                                    Spacer()
//                                                          
//                                                        Image(systemName: "checkmark.message")
//                                                            .foregroundStyle(.white)
//                                                            .font(.system(size: 26, weight: .thin))
//                                                }
//                                                .padding(.horizontal)
//                                            }
//                                    }
//                                }
//                                
//                                Button {
//                                    isChatShown.toggle()
//                                } label: {
//                                    ZStack {
//                                        Rectangle()
//                                            .foregroundColor(.buttonOrangeLight)
//                                            .frame(width: size().width - 35, height: 105)
//                                            .cornerRadius(36)
//                                        
//                                        Rectangle()
//                                            .foregroundColor(.darkGray)
//                                            .frame(width: size().width - 40, height: 100)
//                                          
//                                            .cornerRadius(36)
//                                            .overlay {
//                                                HStack {
//                                                    Image("g33")
//                                                        .resizable()
//                                                        .frame(width: 80, height: 80)
//                                                        .clipShape(Circle())
//                                                    VStack(alignment: .leading) {
//                                                        Text("Kim")
//                                                                .foregroundStyle(.white)
//                                                                .font(.system(size: 26, weight: .black))
//                                                        Text("30 min ago")
//                                                            .foregroundStyle(.gray)
//                                                            .font(.system(size: 12, weight: .black))
//                                                    }
//                                                    .padding(.leading)
//                                                    
//                                                    Spacer()
//                                                          
//                                                        Image(systemName: "checkmark.message")
//                                                            .foregroundStyle(.white)
//                                                            .font(.system(size: 26, weight: .thin))
//                                                }
//                                                .padding(.horizontal)
//                                            }
//                                    }
//                                }
//                                
//                                Button {
//                                    isChatShown.toggle()
//                                } label: {
//                                    ZStack {
//                                        Rectangle()
//                                            .foregroundColor(.buttonOrangeLight)
//                                            .frame(width: size().width - 35, height: 105)
//                                            .cornerRadius(36)
//                                        
//                                        Rectangle()
//                                            .foregroundColor(.darkGray)
//                                            .frame(width: size().width - 40, height: 100)
//                                          
//                                            .cornerRadius(36)
//                                            .overlay {
//                                                HStack {
//                                                    Image("g22")
//                                                        .resizable()
//                                                        .frame(width: 80, height: 80)
//                                                        .clipShape(Circle())
//                                                    VStack(alignment: .leading) {
//                                                        Text("Megan")
//                                                                .foregroundStyle(.white)
//                                                                .font(.system(size: 26, weight: .black))
//                                                        Text("1 day ago")
//                                                            .foregroundStyle(.gray)
//                                                            .font(.system(size: 12, weight: .black))
//                                                    }
//                                                    .padding(.leading)
//                                                    
//                                                    Spacer()
//                                                          
//                                                        Image(systemName: "checkmark.message")
//                                                            .foregroundStyle(.white)
//                                                            .font(.system(size: 26, weight: .thin))
//                                                }
//                                                .padding(.horizontal)
//                                            }
//                                    }
//                                }
                            }
                        }
                    } else {
                        ScrollView {
                            VStack(spacing: 80) {
                                Text("You don't have any contacts yet.")
                                
                                Image(systemName: "person.3")
                                    .font(.system(size: 64 , weight: .thin))
                                
                                Text("Meet, chat and add new contacts in Eva Elf Club!")
                                
                                
                                Button {
                                    isShown.toggle()
                                } label: {
                                    Rectangle()
                                        .fill(LinearGradient(colors: [.buttonOrangeDark, .buttonOrangeLight], startPoint: .leading, endPoint: .trailing))
                                        .cornerRadius(36)
                                        .frame(width: 150 , height: 50)
                                        .overlay {
                                            Text("ADD")
                                                .foregroundStyle(.white)
                                                .font(.system(size: 28, weight: .black))
                                        }
                                }
                                .padding(.horizontal, 25)
                                .padding(.top, 20)
                            }
                            .font(.system(size: 32, weight: .thin))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 35)
                    }
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $isShown) {
            AddFriendView() { status in
                isAddFriendShown.toggle()
            }
        }
        .fullScreenCover(isPresented: $isAddFriendShown) {
            AddFriendDetailView() {
                isFriendsShown = UserDefaults.standard.bool(forKey: "friend")
            }
        }
        .onAppear {
            isFriendsShown = UserDefaults.standard.bool(forKey: "friend")
        }
        .fullScreenCover(isPresented: $isChatShown) {
            ChatDetailView()
        }
    }
}

#Preview {
    MainView()
}
