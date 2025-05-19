//
//  IntroModel.swift
//  
//
//  Created by Sothesom on 09/10/1403.
//

import SwiftUI

enum IntroModel: String, CaseIterable{
    case page1 = "book.fill"
    case page2 = "text.book.closed.fill"
    case page3 = "person.2.fill"
    case page4 = "sparkles"
    
    var title: String {
        switch self {
        case .page1:
            "به دیوان خوش آمدید"
        case .page2:
            "کتابخانه هوشمند"
        case .page3:
            "جامعه کتابخوان"
        case .page4:
            "شروع کنید"
        }
    }
    
    var subTitel: String {
        switch self {
        case .page1:
            "بهترین تجربه کتابخوانی را با دیوان تجربه کنید"
        case .page2:
            "دسترسی به هزاران کتاب در یک اپلیکیشن"
        case .page3:
            "با دوستان خود کتاب‌های مورد علاقه را به اشتراک بگذارید"
        case .page4:
            "همین حالا به جمع کتابخوانان دیوان بپیوندید"
        }
    }
    
    var index: CGFloat {
        switch self {
        case .page1:
            0
        case .page2:
            1
        case .page3:
            2
        case .page4:
            3
        }
    }
    
    var nextPage: IntroModel {
        let index = Int(self.index) + 1
        if index < 4 {
            return IntroModel.allCases[index]
        }
        
        return self
    }
    
    var previousPage: IntroModel {
        let index = Int(self.index) - 1
        if index >= 0 {
            return IntroModel.allCases[index]
        }
        
        return self
    }
}
