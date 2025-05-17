import SwiftUI

struct Poet: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let bio: String
    let works: [String]
    let birthYear: Int
    let deathYear: Int
    let birthPlace: String
    let type: PoetType
    
    static let samplePoets: [Poet] = [
        Poet(
            name: "Hafez\n(حافظ شیرازی)",
            imageName: "Hafez",
            bio: "خواجه شمس‌الدین محمد بن بهاءالدین محمد حافظ شیرازی، معروف به لسان‌الغیب، ترجمان الاسرار، لسان‌العرفا و ناظم‌الاولیا، شاعر بزرگ سدهٔ هشتم ایران و یکی از سخنوران نامی جهان است.",
            works: ["غزلیات", "قصاید", "مثنویات", "رباعیات"],
            birthYear: 726,
            deathYear: 792,
            birthPlace: "شیراز",
            type: .hafez
        ),
        Poet(
            name: "Saadi\n(سعدی شیرازی)",
            imageName: "Saadi",
            bio: "ابومحمد مُصلِح بن عَبدُالله مشهور به سعدی شیرازی و مشرف‌الدین، شاعر و نویسندهٔ پارسی‌گوی ایرانی است. اهل ادب به او لقب استادِ سخن، پادشاهِ سخن، شیخِ اجلّ و حتی به طور مطلق، استاد داده‌اند.",
            works: ["بوستان", "گلستان", "غزلیات", "قصاید"],
            birthYear: 606,
            deathYear: 690,
            birthPlace: "شیراز",
            type: .saadi
        ),
        Poet(
            name: "BabaTaher\n(بابا طاهر عریان)",
            imageName: "BabaTaher",
            bio: "باباطاهر عریان همدانی معروف به باباطاهر عریان، عارف، شاعر و دوبیتی‌سرای اواخر سدهٔ چهارم و اواسط سدهٔ پنجم هجری ایران و معاصر طغرل بیک سلجوقی بوده‌است.",
            works: ["دوبیتی‌ها", "کلمات قصار"],
            birthYear: 1000,
            deathYear: 1055,
            birthPlace: "همدان",
            type: .babaTaher
        ),
        Poet(
            name: "Molana\n(مولانا جلال الدین بلخی)",
            imageName: "Molana",
            bio: "جلال‌الدین محمد بلخی معروف به مولوی، مولانا و رومی، شاعر بزرگ قرن هفتم هجری قمری است. ایشان از مشهورترین شاعران ایرانی پارسی‌گوی است. مولوی از مشهورترین شاعران ایرانی و پارسی‌گوی است.",
            works: ["مثنوی معنوی", "دیوان شمس", "فیه ما فیه", "مجالس سبعه"],
            birthYear: 604,
            deathYear: 672,
            birthPlace: "بلخ",
            type: .molana
        )
    ]
} 