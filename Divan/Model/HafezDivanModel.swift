import Foundation
import SQLite3

class HafezDivanModel {
    private var db: OpaquePointer?
    
    init() {
        connectToDatabase()
    }
    
    private func connectToDatabase() {
        // مسیر دقیق فایل دیتابیس را چاپ می‌کنیم
        if let dbPath = Bundle.main.path(forResource: "DivanDB", ofType: "db") {
            print("مسیر دیتابیس: \(dbPath)")
            
            // اتصال به دیتابیس
            if sqlite3_open(dbPath, &db) == SQLITE_OK {
                print("اتصال به دیتابیس موفق بود")
            } else {
                let errorMessage = String(cString: sqlite3_errmsg(db)!)
                print("خطا در اتصال به دیتابیس: \(errorMessage)")
            }
        } else {
            print("خطا: فایل دیتابیس پیدا نشد!")
        }
    }
    
    // مثال یک تابع برای خواندن داده‌ها
    func readData() -> [String] {
        var results: [String] = []
        let queryString = "SELECT title FROM HafezQazal"
        var statement: OpaquePointer?
        
        print("شروع خواندن داده‌ها از دیتابیس")
        
        if sqlite3_prepare_v2(db, queryString, -1, &statement, nil) == SQLITE_OK {
            print("کوئری با موفقیت آماده شد")
            
            while sqlite3_step(statement) == SQLITE_ROW {
                if let text = sqlite3_column_text(statement, 0) {
                    let title = String(cString: text)
                    results.append(title)
                }
            }
            
            print("تعداد رکوردهای خوانده شده: \(results.count)")
        } else {
            let errorMessage = String(cString: sqlite3_errmsg(db)!)
            print("خطا در اجرای کوئری: \(errorMessage)")
        }
        
        sqlite3_finalize(statement)
        return results
    }
    
    deinit {
        sqlite3_close(db)
    }
} 
