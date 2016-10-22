//
//  ExtTests.swift
//  SimpleDomainModel
//
//  Created by Henry Zhang on 10/21/16.
//  Copyright © 2016 Henry Zhang. All rights reserved.
//

import XCTest

import SimpleDomainModel

class CustomStringTests: XCTestCase {
    
    func testMoneyDescription() {
        let money = Money(amount: 100, currency: "GBP")
        XCTAssert(money.description == "GBP 100.0")
    }
    
    func testJobDescription() {
        let job = Job(title: "Janitor", type: Job.JobType.Salary(1000))
        XCTAssert(job.description == "Job:Janitor Pay:1000 a year")
    }
    
    func testPersonDescription() {
        let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)
        XCTAssert(ted.description == "[Person: firstName:Ted lastName:Neward age:45 job:nil spouse:nil]")
    }
    
    func testFamilyDescription() {
        let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)
        ted.job = Job(title: "Gues Lecturer", type: Job.JobType.Salary(1000))
        
        let charlotte = Person(firstName: "Charlotte", lastName: "Neward", age: 45)
        
        let family = Family(spouse1: ted, spouse2: charlotte)
        
        let mike = Person(firstName: "Mike", lastName: "Neward", age: 22)
        mike.job = Job(title: "Burger-Flipper", type: Job.JobType.Hourly(5.5))
        
        let matt = Person(firstName: "Matt", lastName: "Neward", age: 16)
        let _ = family.haveChild(mike)
        let _ = family.haveChild(matt)
        
        XCTAssert(family.description == "[Person: Ted Neward Person: Charlotte Neward Person: Mike Neward Person: Matt Neward ]")
    }
}

class MathematicsTests: XCTestCase {
    let tenUSD = Money(amount: 10, currency: "USD")
    let fifteenGBP = Money(amount: 15, currency: "GBP")
    
    func testPlusMoney() {
        let twenty = tenUSD + tenUSD
        XCTAssert(twenty.description == "USD 20.0")
    }
    func testMinusMoney() {
        let gbp = tenUSD + fifteenGBP
        XCTAssert(gbp.description == "GBP 20.0")
    }
}

class DoubleExtensionTests: XCTestCase {
    func testUSDDouble() {
        let usd = 22.USD
        XCTAssert(usd.description == "USD 22.0")
    }
    
    func testGBPDouble() {
        let gbp = 3.GBP
        XCTAssert(gbp.description == "GBP 3.0")
    }
}
