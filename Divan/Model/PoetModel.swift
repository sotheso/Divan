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
            bio: """
            Khajeh Shams al-Din Muhammad ibn Baha al-Din Muhammad Hafez Shirazi, known as Lisan al-Ghayb, Tarjuman al-Asrar, Lisan al-Arefa, and Nazim al-Awliya, was a great poet of the 8th century Iran and one of the renowned orators worldwide.  
            خواجه شمس‌الدین محمد بن بهاءالدین محمد حافظ شیرازی، معروف به لسان‌الغیب، ترجمان الاسرار، لسان‌العرفا و ناظم‌الاولیا، شاعر بزرگ سدهٔ هشتم ایران و یکی از سخنوران نامی جهان است.
            """,
            works: ["غزلیات", "قصاید", "مثنویات", "رباعیات"],
            birthYear: 726,
            deathYear: 792,
            birthPlace: "Shiraz",
            type: .hafez
        ),
        Poet(
            name: "Saadi\n(سعدی شیرازی)",
            imageName: "Saadi",
            bio: """
            Abu Muhammad Mosleh ibn Abdullah, known as Saadi Shirazi and Mosharraf al-Din, was a Persian-speaking Iranian poet and writer. Literary figures have given him titles such as Master of Speech, King of Speech, and Sheikh al-Ajal.  
            ابومحمد مُصلِح بن عَبدُالله مشهور به سعدی شیرازی و مشرف‌الدین، شاعر و نویسندهٔ پارسی‌گوی ایرانی است. اهل ادب به او لقب استادِ سخن، پادشاهِ سخن، شیخِ اجلّ و حتی به طور مطلق، استاد داده‌اند.
            """,
            works: ["بوستان", "گلستان", "غزلیات", "قصاید"],
            birthYear: 606,
            deathYear: 690,
            birthPlace: "Shiraz",
            type: .saadi
        ),
        Poet(
            name: "BabaTaher\n(بابا طاهر عریان)",
            imageName: "BabaTaher",
            bio: """
            Babataher Arian Hamadani, known as Babataher Arian, was a mystic, poet, and do-bayti (two-couplet) composer from late 4th and mid-5th century AH Iran. He was a contemporary of Tughril Beg of the Seljuk dynasty.  
            باباطاهر عریان همدانی معروف به باباطاهر عریان، عارف، شاعر و دوبیتی‌سرای اواخر سدهٔ چهارم و اواسط سدهٔ پنجم هجری ایران و معاصر طغرل بیک سلجوقی بوده‌است.
            """,
            works: ["دوبیتی‌ها", "کلمات قصار"],
            birthYear: 1000,
            deathYear: 1055,
            birthPlace: "Hamedan",
            type: .babaTaher
        ),
        Poet(
            name: "Molana\n(مولانا جلال الدین بلخی)",
            imageName: "Molana",
            bio: """
            Jalaluddin Muhammad Balkhi, known as Molavi, Molana, and Rumi, was a great poet of the 7th century AH. He is one of the most famous Persian-speaking Iranian poets. Molavi is renowned for his significant contribution to Persian literature and poetry.  
            جلال‌الدین محمد بلخی معروف به مولوی، مولانا و رومی، شاعر بزرگ قرن هفتم هجری قمری است. ایشان از مشهورترین شاعران ایرانی پارسی‌گوی است. مولوی از مشهورترین شاعران ایرانی و پارسی‌گوی است.
            """,
            works: ["مثنوی معنوی", "دیوان شمس", "فیه ما فیه", "مجالس سبعه"],
            birthYear: 604,
            deathYear: 672,
            birthPlace: "Balkh",
            type: .molana
        )
    ]
} 
