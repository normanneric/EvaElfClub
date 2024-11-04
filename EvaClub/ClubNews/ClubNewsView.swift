//
//  ClubNewsView.swift
//  EvaClub
//
//  Created by D K on 24.10.2024.
//

import SwiftUI

struct ClubNewsView: View {
    
    @State var news: [News] = []
    @State var isQRShown = false
    @State var isMenuShown = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("bg")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Text("CLUB SERVICE")
                            .foregroundStyle(.white)
                            .font(.system(size: 34, weight: .black))
                        
                        Spacer()
                    }
                    .padding(.horizontal, 30)
                    
                    
                    HStack(spacing: 20) {
                        Button {
                            isQRShown.toggle()
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 28)
                                    .fill(LinearGradient(colors: [.buttonOrangeDark, .buttonOrangeLight], startPoint: .leading, endPoint: .trailing))
                                    .opacity(0.8)
                                VStack {
                                    Image("qrIcon")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .colorInvert()
                                    
                                    Text("QR")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 28, weight: .black))
                                }
                               
                            }
                            
                        }
                        .frame(width: 150, height: 150)
                        
                        Button {
                            isMenuShown.toggle()
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 28)
                                    .fill(LinearGradient(colors: [.buttonOrangeDark, .buttonOrangeLight], startPoint: .trailing, endPoint: .leading))
                                    .opacity(0.8)
                                VStack {
                                    Image("drinkIcon")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .colorInvert()
                                    
                                    Text("MENU")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 28, weight: .black))
                                }
                                
                            }
                        }
                        .frame(width: 150, height: 150)
                    }
                    .padding(.top, 30)
                    .padding(.bottom, 30)
                    
                    ScrollView {
                        VStack {
                            ForEach(news, id: \.image) { news in
                                if let url = URL(string: news.image) {
                                    AsyncImage(url: url) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: size().width - 60, height: 350)
                                            .clipped()
                                            .cornerRadius(40)
                                    } placeholder: {
                                        ZStack {
                                            Rectangle()
                                                .frame(width: size().width - 60, height: 350)
                                                .foregroundColor(.darkGray)
                                                .cornerRadius(40)
                                            ProgressView()
                                                .controlSize(.large)
                                                .frame(width: size().width - 60, height: 350)
                                        }
                                        
                                    }
                                    .overlay {
                                        VStack {
                                            Spacer()
                                            
                                            VStack(alignment: .leading) {
                                                Text(news.title)
                                                    .foregroundStyle(.white)
                                                    .font(.system(size: 22, weight: .black))
                                                
                                                Text(news.body)
                                                    .foregroundStyle(.white)
                                                    .font(.system(size: 14, weight: .light))
                                            }
                                            .padding(.horizontal)
                                            .padding(.vertical)
                                            .padding(.bottom)
                                            .background {
                                                Rectangle()
                                                    .foregroundColor(.darkGray.opacity(0.7))
                                                    .cornerRadius(40)
                                                    .padding(.bottom)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.bottom, 200)
                    }
                    .padding(.bottom, 70)
                    .scrollIndicators(.hidden)
                }
            }
        }
        .onAppear {
            NetworkManager.shared.fetchNews { data in
                if let news = data {
                    self.news = news
                }
            }
        }
        .fullScreenCover(isPresented: $isQRShown, content: {
            QRView()
        })
        .fullScreenCover(isPresented: $isMenuShown, content: {
            MenuView() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    StorageManager.shared.deleteCart()
                }
            }
        })

    }
}

#Preview {
    ClubNewsView()
}
