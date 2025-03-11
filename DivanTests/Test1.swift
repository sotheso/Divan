//
//  Test1.swift
//  DivanTests
//
//  Created by Sothesom on 21/12/1403.
//

import XCTest
@testable import Divan

final class DivanModelTests: XCTestCase {
    var divanModel: DivanDBModel!
    
    override func setUp() {
        super.setUp()
        divanModel = DivanDBModel()
    }
    
    override func tearDown() {
        divanModel = nil
        super.tearDown()
    }
    
    // تست اتصال به دیتابیس
    func testDatabaseConnection() {
        XCTAssertTrue(divanModel.isDatabaseConnected(), "دیتابیس باید با موفقیت متصل شود")
    }
    
    // تست خواندن غزل‌ها
    func testReadGhazals() {
        let ghazals = divanModel.readData()
        XCTAssertFalse(ghazals.isEmpty, "لیست غزل‌ها نباید خالی باشد")
    }
    
    // تست جستجوی غزل‌ها
    func testSearchGhazals() {
        // جستجو با یک کلمه که احتمالاً در غزل‌ها وجود دارد
        let searchResults = divanModel.searchGhazals(containing: "دل")
        XCTAssertFalse(searchResults.isEmpty, "باید حداقل یک غزل با کلمه 'دل' پیدا شود")
        
        // جستجو با یک عبارت نامعتبر
        let emptyResults = divanModel.searchGhazals(containing: "xyz123")
        XCTAssertTrue(emptyResults.isEmpty, "جستجو با عبارت نامعتبر باید نتیجه خالی برگرداند")
    }
    
    // تست فرمت داده‌های برگشتی
    func testGhazalDataFormat() {
        let ghazals = divanModel.readData()
        for ghazal in ghazals {
            XCTAssertFalse(ghazal.isEmpty, "هیچ غزلی نباید خالی باشد")
        }
    }
}
