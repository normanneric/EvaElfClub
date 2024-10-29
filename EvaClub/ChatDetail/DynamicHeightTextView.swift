//
//  SwiftUIView.swift
//  EvaClub
//
//  Created by D K on 29.10.2024.
//

import SwiftUI

struct DynamicHeightTextView: UIViewRepresentable {
    @Binding var text: String
    var minHeight: CGFloat
    var maxHeight: CGFloat
    @Binding var textViewHeight: CGFloat
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = .black
        textView.delegate = context.coordinator
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        recalculateHeight(view: uiView)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    private func recalculateHeight(view: UITextView) {
        let newSize = view.sizeThatFits(CGSize(width: view.frame.width, height: CGFloat.greatestFiniteMagnitude))
        DispatchQueue.main.async {
            self.textViewHeight = min(max(newSize.height, minHeight), maxHeight)
        }
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: DynamicHeightTextView
        
        init(_ parent: DynamicHeightTextView) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
            parent.recalculateHeight(view: textView)
        }
    }
}
