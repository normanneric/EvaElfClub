//
//  DataManager.swift
//  EvaClub
//
//  Created by D K on 28.10.2024.
//

import Foundation
class DataManager {
    
    static let shared = DataManager()
    
    private init(){}
    
    func createInitialData() {
        if !UserDefaults.standard.bool(forKey: "init") {
            UserDefaults.standard.setValue(true, forKey: "init")
            UserDefaults.standard.setValue(true, forKey: "onboarding")      
            UserDefaults.standard.setValue(false, forKey: "friend")
            UserDefaults.standard.setValue(false, forKey: "terms")
            StorageManager.shared.createPerson()
            StorageManager.shared.createMessages()
        }
    }
    
    var terms = """
Eva Elf Club Chat – Terms of Use

Welcome to the Eva Club Chat! To create a respectful, positive, and safe space for all users, please carefully review and abide by the following Terms of Use. By using the chat feature, you agree to these rules and acknowledge that any violation may result in temporary or permanent suspension of your account.

1. Respectful Communication
No Harassment or Bullying: Harassment, intimidation, or any form of bullying is strictly prohibited. This includes unwanted messages, spamming, or any behavior that makes others feel uncomfortable or unsafe.
No Insults or Derogatory Language: Offensive language, name-calling, slurs, or derogatory remarks based on race, ethnicity, gender, nationality, religion, sexual orientation, or disability will not be tolerated.
2. Privacy and Consent
Respect Others’ Privacy: Do not share another user's personal information (such as contact details, location, or other private information) without their explicit consent.
Respect Boundaries: Always respect other users' boundaries. If someone expresses disinterest or requests you to stop messaging, comply immediately.
No Unauthorized Content Sharing: Sharing or requesting any private, intimate, or non-consensual images or videos is strictly prohibited.
3. Prohibited Content
No Explicit or Inappropriate Content: Do not share sexually explicit, pornographic, violent, or otherwise inappropriate content. This applies to both text and media messages.
No Offensive Material: Avoid sharing content that could offend or upset other users, including but not limited to, hate speech, vulgar language, or violent media.
No Illegal or Unlawful Content: Do not use the chat to discuss or promote illegal activities, substances, or behaviors that violate local, national, or international laws.
4. Safety and Security
No Impersonation or False Information: Users are prohibited from impersonating others, including other users, celebrities, or Eva Elf Club staff. Avoid providing false information or misrepresenting your identity.
No Scams or Fraudulent Activities: Attempting to scam, defraud, or deceive other users for any purpose, including financial gain, is strictly prohibited.
No Spam or Promotional Messages: Do not send spam, advertisements, or any promotional content without permission. This includes unsolicited links, commercial offers, or attempts to redirect users to external sites.
5. Reporting and Moderation
Report Inappropriate Behavior: If you experience or witness any behavior that violates these terms, please report it to Eva Elf Club’s support team. We rely on our community to help keep the chat safe for everyone.
Moderation and Enforcement: Eva Elf Club reserves the right to monitor chat activity to enforce these Terms of Use. Any breach may result in warnings, temporary suspensions, or permanent bans, depending on the severity of the offense.
6. Liability and Disclaimers
User Responsibility: Users are responsible for their own interactions and assume all risks when using the chat feature. Eva Elf Club is not liable for the actions or content shared by other users but will take prompt action to address reported violations.
Disclaimer of Endorsement: Eva Club does not endorse or guarantee the accuracy of any user-provided information or content shared in the chat.
"""
}
