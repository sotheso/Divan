import Foundation
import SQLite3

class DatabaseManager {
    static let shared = DatabaseManager()
    var database: OpaquePointer?
    
    private init() {
        self.database = openDatabase()
    }
    
    private func openDatabase() -> OpaquePointer? {
        let fileURL = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("HafezDB.sqlite")
        
        var db: OpaquePointer?
        
        if sqlite3_open(fileURL.path, &db) == SQLITE_OK {
            print("Successfully opened database at \(fileURL.path)")
            return db
        } else {
            print("Unable to open database")
            return nil
        }
    }
    
    func run(_ query: String, completion: @escaping (SQLiteResultSet) -> Void) {
        var statement: OpaquePointer?
        print("در حال اجرای کوئری: \(query)")
        
        if sqlite3_prepare_v2(database, query, -1, &statement, nil) == SQLITE_OK {
            print("کوئری با موفقیت آماده شد")
            let resultSet = SQLiteResultSet(statement: statement)
            completion(resultSet)
        } else {
            print("خطا در اجرای کوئری")
            if let errorMessage = String(validatingUTF8: sqlite3_errmsg(database)) {
                print("پیغام خطا: \(errorMessage)")
            }
        }
        
        sqlite3_finalize(statement)
    }
}

class SQLiteResultSet {
    private var statement: OpaquePointer?
    
    init(statement: OpaquePointer?) {
        self.statement = statement
    }
    
    func next() -> [Any]? {
        guard sqlite3_step(statement) == SQLITE_ROW else {
            return nil
        }
        
        var row = [Any]()
        let columnCount = sqlite3_column_count(statement)
        
        for i in 0..<columnCount {
            let type = sqlite3_column_type(statement, i)
            
            switch type {
            case SQLITE_TEXT:
                if let cString = sqlite3_column_text(statement, i) {
                    row.append(String(cString: cString))
                }
            case SQLITE_INTEGER:
                row.append(sqlite3_column_int64(statement, i))
            case SQLITE_FLOAT:
                row.append(sqlite3_column_double(statement, i))
            case SQLITE_NULL:
                row.append(NSNull())
            default:
                row.append(NSNull())
            }
        }
        
        return row
    }
} 