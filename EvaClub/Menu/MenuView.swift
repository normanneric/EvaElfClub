//
//  MenuView.swift
//  EvaClub
//
//  Created by D K on 03.11.2024.
//

import SwiftUI

class MenuElement: Codable {
    let name: String
    let description: String
    let price: String
    let image_prompt: String
    
    init(name: String, description: String, price: String, image_prompt: String) {
        self.name = name
        self.description = description
        self.price = price
        self.image_prompt = image_prompt
    }
}

class CartViewModel: ObservableObject {
    @Published var cart: RealmCart?
    
    func getCart() {
        guard let cart = StorageManager.shared.carts.first else { return }
        self.cart = cart
    }
    
    func addProduct(element: RealmCartElement) {
        let product = MenuElement(name: element.name ?? "", description: element.description, price: String(element.price ?? 0), image_prompt: "")
        StorageManager.shared.addToCart(item: product)
        getCart()
    }
    
    func removeProduct(element: RealmCartElement) {
        StorageManager.shared.removeElement(element: element)
        getCart()
    }
}

struct MenuView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var menu: [MenuElement] = []
    @StateObject private var viewModel = CartViewModel()
    @State var isAlertShown = false
    private static let topId = "topIdHere"
    @State var isOrderAlertShown = false
    var completion: () -> ()
    
    var body: some View {
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
                
                ScrollViewReader { proxy in
                    ScrollView {
                        
                        if let cart = viewModel.cart, !cart.elements.isEmpty {
                            Text("CART")
                                .foregroundStyle(.white)
                                .font(.system(size: 34, weight: .black))
                                .id(Self.topId)
                            VStack {
                                ForEach(cart.elements, id: \.id) { element in
                                    HStack {
                                        Text(element.name ?? "")
                                            .foregroundStyle(.white)
                                            .font(.system(size: 18, weight: .black))
                                            .multilineTextAlignment(.leading)

                                        Spacer()
                                        
                                        HStack {
                                            Button {
                                                viewModel.removeProduct(element: element)
                                            } label: {
                                                Rectangle()
                                                    .foregroundColor(.white)
                                                    .frame(width: 25, height: 25)
                                                    .cornerRadius(7)
                                                    .overlay {
                                                        Image(systemName: "minus")
                                                            .foregroundColor(.black)
                                                            .bold()
                                                    }
                                            }
                                            
                                            Text("\(element.quantity ?? 0)")
                                                .foregroundColor(.white)
                                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                                .multilineTextAlignment(.center)
                                                .frame(width: 20)
                                            
                                            Button {
                                                viewModel.addProduct(element: element)
                                            } label: {
                                                Rectangle()
                                                    .foregroundColor(.white)
                                                    .frame(width: 25, height: 25)
                                                    .cornerRadius(7)
                                                    .overlay {
                                                        Image(systemName: "plus")
                                                            .foregroundColor(.black)
                                                            .bold()
                                                    }
                                            }
                                        }
                                        
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            .padding()
                            .background {
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.buttonOrangeLight)
                                        .frame(width: size().width - 35)
                                        .cornerRadius(36)
                                    
                                    Rectangle()
                                        .foregroundColor(.darkGray)
                                        .frame(width: size().width - 40)
                                        .cornerRadius(36)
                                        .padding(.vertical, 2)
                                }
                            }
                            
                      
                            
                            Rectangle()
                                .fill(LinearGradient(colors: [.buttonOrangeDark, .buttonOrangeLight], startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(36)
                                .frame(height: 60)
                                .opacity(0.5)
                                .overlay {
                                    HStack {
                                        Text("TOTAL:")
                                            .foregroundStyle(.white)
                                            .font(.system(size: 28, weight: .black))
                                        
                                        Spacer()
                                        
                                        if let cart = viewModel.cart, let value = cart.totalValue {
                                            Text(String(format: "%.2f", value))
                                                .foregroundStyle(.white)
                                                .font(.system(size: 28, weight: .black))
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                                .padding(.horizontal)
                            
                            Button {
                                UserDefaults.standard.setValue("\(Int.random(in: 10...99)) \(Int.random(in: 10...99)) \(Int.random(in: 10...99))", forKey: "order")
                                isOrderAlertShown.toggle()
                            } label: {
                                Rectangle()
                                    .fill(LinearGradient(colors: [.buttonOrangeDark, .buttonOrangeLight], startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius(36)
                                    .frame(height: 60)
                                    .overlay {
                                            Text("MAKE ORDER")
                                                .foregroundStyle(.white)
                                                .font(.system(size: 28, weight: .black))
                                    }
                                    .padding(.horizontal)
                            }
                        }
                        
                        
                        Text("MENU")
                            .foregroundStyle(.white)
                            .font(.system(size: 34, weight: .black))
                        
                        ForEach(menu, id: \.name) { element in
                            Button {
                                isAlertShown.toggle()
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
                                            VStack(alignment: .leading) {
                                                HStack {
                                                    Image(element.image_prompt)
                                                        .resizable()
                                                        .frame(width: 80, height: 80)
                                                        .clipShape(Circle())
                                                    
                                                    VStack(alignment: .leading) {
                                                        Text(element.name)
                                                            .foregroundStyle(.white)
                                                            .font(.system(size: 18, weight: .black))
                                                            .multilineTextAlignment(.leading)
                                                        Text(element.description)
                                                            .foregroundStyle(.gray)
                                                            .font(.system(size: 8, weight: .light))
                                                            .multilineTextAlignment(.leading)
                                                    }
                                                    .padding(.leading)
                                                    
                                                    Spacer()
                                                    
                                                    Text(element.price)
                                                        .foregroundStyle(.white)
                                                        .font(.system(size: 24, weight: .black))
                                                        .multilineTextAlignment(.center)
                                                        .frame(width: 35)
                                                }
                                                .padding(.horizontal)
                                            }
                                            
                                        }
                                }
                            }
                            .alert("Product added", isPresented: $isAlertShown) {
                                Button {
                                    withAnimation {
                                        StorageManager.shared.addToCart(item: element)
                                        viewModel.getCart()
                                        isAlertShown.toggle()
                                    }
                                  
                                } label: {
                                    Text("Continue")
                                }
                                
                                Button {                               
                                    withAnimation {
                                        StorageManager.shared.addToCart(item: element)
                                        viewModel.getCart()
                                        isAlertShown.toggle()
                                        proxy.scrollTo(Self.topId, anchor: .top)
                                    }
                                } label: {
                                    Text("Return")
                                }
                            } message: {
                                Text("Continue shopping or return to cart?")
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }
            }
            
            
        }
        .alert("Order placed", isPresented: $isOrderAlertShown) {
            Button {
                
                dismiss()
                completion()
            } label: {
                Text("OK")
            }
        } message: {
            Text("Order number: \(UserDefaults.standard.string(forKey: "order") ?? ""). You can see the active order in the section with the QR code. Don't forget to show it to the manager for an additional discount.")
        }
        .onAppear {
            menu = parseMenu() ?? []
            viewModel.getCart()
        }
    }
    
    
    func parseMenu() -> [MenuElement]? {
        guard let url = Bundle.main.url(forResource: "menu", withExtension: "json") else {
            print("not found")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let menuItems = try JSONDecoder().decode([MenuElement].self, from: data)
            return menuItems
        } catch {
            print("Error parsing JSON: \(error)")
            return nil
        }
    }
}

#Preview {
    MenuView(){}
}
