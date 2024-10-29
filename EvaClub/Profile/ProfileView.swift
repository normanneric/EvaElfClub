//
//  ProfileView.swift
//  EvaClub
//
//  Created by D K on 24.10.2024.
//

import SwiftUI
import PhotosUI


struct ProfileView: View {
    
    @State var isSettingsShown = false
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State var pickerItem: PhotosPickerItem?
    @State var userPhoto: Data?
    @State var name = ""
    @State var age = ""
    @State var height = ""
    @State var hobby = ""
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                //MARK: - BACKGROUND
                Image("bg")
                    .resizable()
                    .ignoresSafeArea()
                
                //MARK: - NAV BAR
                VStack {
                    HStack {
                        
                        Spacer()
                        
                        Button {
                            isSettingsShown.toggle()
                        } label: {
                            ZStack {
                                Circle()
                                    .foregroundColor(.buttonOrangeLight)
                                    .frame(width: 50, height: 50)
                                
                                Image(systemName: "gearshape.fill")
                                    .font(.system(size: 26))
                                    .foregroundColor(.white)
                                
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                    
                    ScrollView {
                        //MARK: - USER IMAGE
                        Circle()
                            .frame(width: 240, height: 240)
                            .foregroundColor(.buttonOrangeLight)
                            .overlay {
                                if userPhoto == nil {
                                    ZStack {
                                        Circle()
                                            .frame(width: 220, height: 220)
                                        
                                        Image("userPlaceholder")
                                            .resizable()
                                    }
                                } else {
                                    if let userPhoto,
                                       let uiImage = UIImage(data: userPhoto) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 230, height: 230)
                                            .clipShape(Circle())
                                    }
                                }
                            }
                            .onChange(of: pickerItem) { newValue in
                                Task {
                                    if let data = try? await newValue?.loadTransferable(type: Data.self) {
                                        userPhoto = data
                                        StorageManager.shared.updateImage(userPhoto)
                                    }
                                }
                                
                                
                            }
                            .overlay {
                                VStack {
                                    Spacer()
                                    HStack {
                                        Spacer()
                                        
                                        PhotosPicker(
                                            selection: $pickerItem,
                                            matching: .images,
                                            photoLibrary: .shared()) {
                                                Text("+")
                                            }
                                            .foregroundColor(.white)
                                            .font(.system(size: 42))
                                    }
                                }
                            }
                        
                        //MARK: - USER DATA
                        if authViewModel.currentuser != nil {
                            Rectangle()
                                .frame(width: size().width - 40, height: 70)
                                .foregroundColor(.white)
                                .cornerRadius(36)
                                .overlay {
                                    VStack(alignment: .leading) {
                                        Text("\(authViewModel.currentuser?.email ?? "")")
                                            .foregroundColor(.black)
                                            .font(.system(size: 18, weight: .bold))
                                    }
                                }
                                .padding(.top)
                        }
                        
                        TextField("", text: $name, prompt: Text("NAME:").foregroundColor(.gray))
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
                            .onChange(of: name) { newValue in
                                StorageManager.shared.updateName(newValue)
                            }
                        
                        TextField("", text: $age, prompt: Text("AGE:").foregroundColor(.gray))
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
                            .onChange(of: age) { newValue in
                                StorageManager.shared.updateAge(newValue)
                            }
                        
                        TextField("", text: $height, prompt: Text("HEIGHT:").foregroundColor(.gray))
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
                            .onChange(of: height) { newValue in
                                StorageManager.shared.updateHeight(newValue)
                            }
                        
                        TextField("", text: $hobby, prompt: Text("HOBBIES:").foregroundColor(.gray))
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
                            .onChange(of: hobby) { newValue in
                                StorageManager.shared.updateHobby(newValue)
                            }
                            .padding(.bottom, 150)
                    }
                    .scrollIndicators(.hidden)
                }
            }
        }
        .fullScreenCover(isPresented: $isSettingsShown) {
            SettingsView()
                .environmentObject(authViewModel)
        }
        .onAppear {
            name = authViewModel.currentuser?.name ?? ""
            if let user = StorageManager.shared.persons.first {
                name = user.name
                age = user.age
                height = user.height
                hobby = user.hobby
                
                userPhoto = user.image
            }
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthViewModel())
}
