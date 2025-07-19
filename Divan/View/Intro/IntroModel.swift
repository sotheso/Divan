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
    case page3 = "bookmark.circle.fill"
    case page4 = "ellipsis.message.fill"
    case page5 = "checkmark.seal.fill"
    
    var title: String {
        switch self {
        case .page1:
            "به دیوان خوش آمدید"
        case .page2:
            "دیوان اشعار آفلاین"
        case .page3:
            "شعرهای جذاب"
        case .page4:
            "نظر شاعران رو بپرسید"
        case .page5:
            "شروع کنید"
        }
    }
    
    var subTitel: String {
        switch self {
        case .page1:
            "لذت آشنایی با شعر و ادبیات ایران زمین را با اپ دیوان تجربه کنید"
        case .page2:
            "دسترسی به هزاران بیت شعر از دیوان شاعران معروف ایران زمین در یک اپلیکیشن بدون نیاز به اینترنت"
        case .page3:
            "شعر های مورد علاقه‌ی خود را ذخیره و با دوستان خود به اشتراک بگذارید"
        case .page4:
            "قابلیت فال گرفتن از تمام اشعار عرفا و شاعران بجسته و همچنین یادآوری روزانه"
        case.page5:
            "همین حالا به جمع شعرخوانان دیوان بپیوندید"
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
        case .page5:
            4
        }
    }
    
    var nextPage: IntroModel {
        let index = Int(self.index) + 1
        if index < 5 {
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
