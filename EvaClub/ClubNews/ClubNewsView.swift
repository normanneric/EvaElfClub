//
//  ClubNewsView.swift
//  EvaClub
//
//  Created by D K on 24.10.2024.
//

import SwiftUI

struct ClubNewsView: View {
    
    @State var news: [News] = []
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("bg")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Text("CLUB NEWS")
                            .foregroundStyle(.white)
                            .font(.system(size: 34, weight: .black))
                        
                        Spacer()
                    }
                    .padding(.horizontal, 30)
                    
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
    }
}

#Preview {
    ClubNewsView()
}
