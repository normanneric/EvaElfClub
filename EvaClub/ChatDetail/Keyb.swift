//
//  Keyb.swift
//  EvaClub
//
//  Created by D K on 29.10.2024.
//

import SwiftUI

struct GrowingTextInputView: View {
  init(text: Binding<String?>, placeholder: String?) {
    self._text = text
    self.placeholder = placeholder
  }

  @Binding var text: String?
  @State var focused: Bool = false
  @State var contentHeight: CGFloat = 0

  let placeholder: String?
  let minHeight: CGFloat = 39
  let maxHeight: CGFloat = 150

  var countedHeight: CGFloat {
    min(max(minHeight, contentHeight), maxHeight)
  }

  var body: some View {
    ZStack(alignment: .topLeading) {
      Color.white
      ZStack(alignment: .topLeading) {
        placeholderView
        TextViewWrapper(text: $text, focused: $focused, contentHeight: $contentHeight)
      }.padding(.horizontal, 4)
    }.frame(height: countedHeight)
  }

  var placeholderView: some View {
    ViewBuilder.buildIf(
      showPlaceholder ?
        placeholder.map {
          Text($0)
            .foregroundColor(.gray)
            .font(.system(size: 16))
            .padding(.vertical, 8)
            .padding(.horizontal, 4)
        } : nil
    )
  }

  var showPlaceholder: Bool {
    !focused && text.orEmpty.isEmpty == true
  }
}

struct TextViewWrapper: UIViewRepresentable {

  init(text: Binding<String?>, focused: Binding<Bool>, contentHeight: Binding<CGFloat>) {
    self._text = text
    self._focused = focused
    self._contentHeight = contentHeight
  }

  @Binding var text: String?
  @Binding var focused: Bool
  @Binding var contentHeight: CGFloat

  // MARK: - UIViewRepresentable

  func makeUIView(context: Context) -> UITextView {
    let textView = UITextView()
    textView.delegate = context.coordinator
    textView.font = .systemFont(ofSize: 16)
      textView.textColor = .black
    textView.backgroundColor = .clear
    textView.autocorrectionType = .no
    return textView
  }

  func makeCoordinator() -> Coordinator {
    Coordinator(text: $text, focused: $focused, contentHeight: $contentHeight)
  }

  func updateUIView(_ uiView: UITextView, context: Context) {
    uiView.text = text
  }

  class Coordinator: NSObject, UITextViewDelegate {

    init(text: Binding<String?>, focused: Binding<Bool>, contentHeight: Binding<CGFloat>) {
      self._text = text
      self._focused = focused
      self._contentHeight = contentHeight
    }

    @Binding private var text: String?
    @Binding private var focused: Bool
    @Binding private var contentHeight: CGFloat

    // MARK: - UITextViewDelegate

    func textViewDidChange(_ textView: UITextView) {
      text = textView.text
      contentHeight = textView.contentSize.height
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
      focused = true
    }

    func textViewDidEndEditing(_ textView: UITextView) {
      focused = false
      contentHeight = text == nil ? 0 : textView.contentSize.height
    }
  }
}

extension Optional where Wrapped == String {
  var orEmpty: String {
    self ?? ""
  }
}


extension Color {
  static var background: Color { .init("background") }
  static var inputBorder: Color { .init("inputBorder") }
  static var messageBackground: Color { .init("messageBackground") }
}
