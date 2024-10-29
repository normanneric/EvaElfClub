//
//  WelcomeView.swift
//  EvaClub
//
//  Created by D K on 24.10.2024.
//

import SwiftUI

struct WelcomeView: View {
    
    @State private var currentIndex = 0
    var completion: () -> Void
    @State private var offsetX: CGFloat = UIScreen.main.bounds.width
    @State private var selection = 0
    
    var onBoarding: [String] = [
    """
Welcome to Eva Elf Club!

Get ready to make every night unforgettable. At Eva Elf Club, connect with amazing people, make friends, and share unforgettable memories—all with just a scan.
""",
    """
Step 1: Get Your Bracelet

Upon entry, you’ll receive a bracelet with a unique QR code. This is your key to connecting with others and staying in touch long after the night ends!
""",
"""
Step 2: Scan to Connect
    
Use the app’s built-in scanner to connect with friends around you. Simply scan their code or let them scan yours to instantly add each other to your network.
""",
"""
Step 3: Keep the Party Going
        
Once connected, keep the conversation going! Chat with new friends, plan meetups, or share experiences—all from the Eva Elf Club app.
""",
"""
Ready to start?
            
Let’s go! Your new Eva Elf Club friends are just a scan away.
            
Let’s make memories together!
"""
    ]
    
    var body: some View {
        ZStack {
            Image("bgWelcome")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Image("char")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 330, height: 670)
                    
                }
            }
            
            
        }
        .overlay {
            VStack {
                VStack {
                    
                }.frame(height: size().height / 3)
                Spacer()
                
                TabView(selection: $selection){
                    ForEach(0..<onBoarding.count, id: \.self) { index in
                        Rectangle()
                            .foregroundColor(.darkGray.opacity(0.7))
                            .frame(width: size().width - 40, height: 450)
                            .background(.ultraThinMaterial)
                            .cornerRadius(36)
                            .opacity(0.8)
                            .overlay {
                                VStack {
                                    Text(onBoarding[index])
                                        .foregroundColor(.white)
                                        .frame(width: size().width - 80)
                                        .font(.system(size: 26, weight: .thin))
                                    Spacer()
                                    
                                    Button {
                                        if selection == onBoarding.count - 1 {
                                            completion()
                                        } else {
                                            withAnimation {
                                                selection += 1
                                            }
                                        }
                                        
                                    } label: {
                                        Text(selection == onBoarding.count - 1 ? "START" : "NEXT")
                                            .foregroundStyle(.white)
                                            .font(.system(size: 18, weight: .black))
                                            .padding(.horizontal, 20)
                                            .padding(.vertical, 10)
                                            .background {
                                                Rectangle()
                                                    .fill(LinearGradient(colors: [.buttonOrangeDark, .buttonOrangeLight], startPoint: .leading, endPoint: .trailing))
                                                    .cornerRadius(36)
                                            }
                                    }
                                }
                                .padding(.vertical, 40)
                            }
                    }
                }
                .tabViewStyle(.page)
                
            }
            .overlay {
                
                
            }
            
        }
    }
}

#Preview {
    WelcomeView(){}
}
