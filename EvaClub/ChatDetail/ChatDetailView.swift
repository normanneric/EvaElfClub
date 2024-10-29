import SwiftUI

struct ChatDetailView: View {
    @State var message: String? = ""
    @Environment(\.dismiss) var dismiss
    @State private var messages: [Message] = []
    @State private var textFieldHeight: CGFloat = 40
    @State private var keyboardHeight: CGFloat = 0
    
    @State var terms = true

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
                            Image(systemName: "xmark")
                                .font(.system(size: 24, weight: .black, design: .rounded))
                                .foregroundColor(.white)
                        }
                        .padding(.trailing, 40)
                        
                        VStack(alignment: .leading) {
                            Text("SARAH")
                                .foregroundStyle(.white)
                                .font(.system(size: 34, weight: .black))
                            
                            Text("7 days ago")
                                .foregroundStyle(.white)
                                .font(.system(size: 12, weight: .light))
                        }
                        
                        Spacer()
                        
                        Circle()
                            .foregroundColor(.buttonOrangeLight)
                            .frame(width: 80, height: 80)
                            .overlay {
                                Image("girl")
                                    .resizable()
                                    .frame(width: 75, height: 75)
                                    .clipShape(Circle())
                            }
                    }
                    .padding(.horizontal, 30)
                    
                    ScrollViewReader { scrollViewProxy in
                        ScrollView {
                            VStack(spacing: 10) {
                                ForEach(messages) { msg in
                                    MessageBubble(message: msg)
                                }
                            }
                            .padding()
                            .onChange(of: messages) { _ in
                                if let lastMessage = messages.last {
                                    scrollViewProxy.scrollTo(lastMessage.id, anchor: .bottom)
                                }
                            }
                        }
                    }
                }
                

                //MARK: - TEXTEDITOR
                VStack {
                    Spacer()
                    
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width, height: textFieldHeight + 60)
                        .foregroundColor(.darkGray)
                        .opacity(0.7)
                        .overlay {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.white)
                                    .cornerRadius(36)
                                
                                HStack {
                                    GrowingTextInputView(text: $message, placeholder: "Message")
                                        .background(Color.gray.opacity(0.1))
                                        .cornerRadius(10)
                                        .onChange(of: message) { newValue in
                                            switch calculateNumberOfLines(for: message ?? "", font: .systemFont(ofSize: 17), width: size().width - 140) {
                                            case 0: textFieldHeight = 40
                                            case 1: textFieldHeight = 40
                                            case 2: textFieldHeight = 80
                                            case 3: textFieldHeight = 100
                                            case 4: textFieldHeight = 140
                                            case 5...100: textFieldHeight = 140
                                            default: textFieldHeight = 40
                                            }
                                          
                                        }
                                        .frame(width: size().width - 140)

                                    Spacer()
                                    
                                    Button {
                                        withAnimation {
                                            sendMessage()
                                        }
                                    } label: {
                                        Image("buttonSend")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                    }
                                    
                                }
                                .padding(.horizontal)
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical)
                        }
                }
                .padding(.bottom, keyboardHeight)
                .animation(.easeOut(duration: 0.3), value: keyboardHeight)
                .ignoresSafeArea()
            }
            .onAppear(perform: setupKeyboardNotifications)
        }
        .onAppear {
            terms = UserDefaults.standard.bool(forKey: "terms")
        }
        .overlay {
            if !terms {
                TermsOfUseView {
                    terms = true
                    UserDefaults.standard.setValue(true, forKey: "terms")
                } dismiss: {
                    dismiss()
                }
            }
           

        }
        .onAppear {
            if let firstMessage = StorageManager.shared.messages.first {
                for mes in Array(firstMessage.messages) {
                    let newMessage = Message(text: mes, isUser: true)
                    self.messages.append(newMessage)
                }
            }
        }
        .onDisappear {
            var list: [String] = []
            for i in messages {
                list.append(i.text)
            }
            StorageManager.shared.updateMessages(list: list)
        }
    }
    
    func calculateNumberOfLines(for text: String, font: UIFont, width: CGFloat) -> Int {
           let label = UILabel()
           label.numberOfLines = 0
           label.text = text
           label.font = font
           label.preferredMaxLayoutWidth = width
           
           let size = label.sizeThatFits(CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
           let lineHeight = font.lineHeight
    
           return Int(size.height / lineHeight)
       }

    private func sendMessage() {
        if let mes = message {
            guard !mes.isEmpty else { return }
            let testMessage = Message(text: mes, isUser: true)
            messages.append(testMessage)
            message = ""
            textFieldHeight = 40
        }
    }

    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
            if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                keyboardHeight = keyboardFrame.height
            }
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
            keyboardHeight = 0
        }
    }
}

#Preview {
    ChatDetailView()
}

struct Message: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let isUser: Bool
}

struct MessageBubble: View {
    let message: Message

    var body: some View {
        HStack {
            if message.isUser {
                Spacer()
            }
            
            Text(message.text)
                .foregroundColor(.white)
                .padding(10)
                .background(message.isUser ? Color.gray : Color.gray.opacity(0.2))
                .cornerRadius(15)
                .overlay(
                    Triangle()
                        .fill(message.isUser ? Color.gray : Color.gray.opacity(0.2))
                        .frame(width: 10, height: 10)
                        .rotationEffect(Angle(degrees: message.isUser ? 65 : -15))
                        .offset(x: message.isUser ? 0 : 0, y: 2),
                    alignment: message.isUser ? .bottomTrailing : .bottomLeading
                )
                .foregroundColor(message.isUser ? .white : .black)
            
            if !message.isUser {
                Spacer()
            }
        }
        .padding(message.isUser ? .leading : .trailing, 60)
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}
