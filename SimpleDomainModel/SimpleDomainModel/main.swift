//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
    return "I have been tested"
}

open class TestMe {
    open func Please() -> String {
        return "I have been tested"
    }
}

////////////////////////////////////
// Money
//
public struct Money {
    public var amount : Int
    public var currency : String
    
    let typeArray = ["USD", "GBP", "EUR", "CAN"]
    let conversionRate = ["CAN": 1.25, "EUR": 1.5, "GBP": 0.5, "USD": 1]
    
    public func convert(_ to: String) -> Money {
        var amount = self.amount
        if (!typeArray.contains(to)) {
            print("invalid money type")
        } else {
            amount = Int(Double(self.amount) / conversionRate[self.currency]!)
            return Money(amount: Int(Double(amount) * conversionRate[to]!), currency: to)
        }
        return self
    }

    func add(_ to: Money) -> Money {
        var localSelf = Money(amount: self.amount, currency: self.currency)
        let localTo = to
        if self.currency != localTo.currency {
            localSelf = localSelf.convert(localTo.currency)
        }
        return Money(amount: localSelf.amount + localTo.amount, currency: localTo.currency)
    }
        
    func subtract(_ from: Money) -> Money {
        var localSelf = Money(amount: self.amount, currency: self.currency)
        let localfrom = from
        if self.currency != localfrom.currency {
            localSelf = localSelf.convert(localfrom.currency)
        }
        return Money(amount: localfrom.amount - localSelf.amount, currency: localfrom.currency)
    }
}

//public enum Type {
//    case CAD
//    case EUR
//    case GBP
//    case USD
//}

////////////////////////////////////
// Job
//
open class Job {
    fileprivate var title : String
    fileprivate var type : JobType
    
    public enum JobType {
        case Hourly(Double)
        case Salary(Int)
    }
    
    public init(title : String, type : JobType) {
        self.title = title
        self.type = type
    }
    
    /*open func calculateIncome(_ hours: Int) -> Int {
        if(self.type =) {
            
            } else {
            return type;
            }
        }
    
    open func raise(_ amt : Double) {
 
    }*/
}

//////////////////////////////////////
//// Person
////
//open class Person {
//    open var firstName : String = ""
//    open var lastName : String = ""
//    open var age : Int = 0
//    
//    fileprivate var _job : Job? = nil
//    open var job : Job? {
//        get { }
//        set(value) {
//        }
//    }
//    
//    fileprivate var _spouse : Person? = nil
//    open var spouse : Person? {
//        get { }
//        set(value) {
//        }
//    }
//    
//    public init(firstName : String, lastName: String, age : Int) {
//        self.firstName = firstName
//        self.lastName = lastName
//        self.age = age
//    }
//    
//    open func toString() -> String {
//    }
//}
//
//////////////////////////////////////
//// Family
////
//open class Family {
//    fileprivate var members : [Person] = []
//    
//    public init(spouse1: Person, spouse2: Person) {
//    }
//    
//    open func haveChild(_ child: Person) -> Bool {
//    }
//    
//    open func householdIncome() -> Int {
//    }
//}
