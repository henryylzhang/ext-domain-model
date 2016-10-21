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

protocol CustomStringConvertible {
    var description: String { get }
}

protocol Mathematics {
    func add(Money1: Money, Money2: Money) -> Money
    func subtract(Money1: Money, from: Money) -> Money
}

extension Double {
    var CAN: Money {
        return Money(amount: Int(self), currency: "CAN")
    }
    var EUR: Money {
        return Money(amount: Int(self), currency: "EUR")
    }
    var GBP: Money {
        return Money(amount: Int(self), currency: "GBP")
    }
    var USD: Money {
        return Money(amount: Int(self), currency: "USD")
    }
}

////////////////////////////////////
// Money
//
public struct Money: CustomStringConvertible {
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
    
    var description: String {
            return "\(self.currency)\(Double(self.amount))"
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
    
    open func calculateIncome(_ hours: Int) -> Int {
        let job = self.type
        switch job {
        case .Hourly(let rate):
            return Int(Double(hours) * rate)
        case .Salary(let rate):
            return rate
        }
    }
    
    open func raise(_ amt : Double) {
        let job = self.type
        switch job {
        case .Hourly(let rate):
            self.type = Job.JobType.Hourly(rate + amt)
        case .Salary(let rate):
            self.type = Job.JobType.Salary(rate + Int(amt))
        }
    }
    
    var description: String {
        let job = self.type
        switch job {
        case .Hourly(let rate):
            return "Job:\(self.title) Pay:\(rate) an hour"
        case .Salary(let rate):
            return "Job:\(self.title) Pay:\(rate) a year"
        }
    }
}

////////////////////////////////////
// Person
//
open class Person {
    open var firstName : String = ""
    open var lastName : String = ""
    open var age : Int = 0
    
    fileprivate var _job : Job? = nil
    open var job : Job? {
        get {
            return _job;
        }
        set(value) {
            if self.age >= 16 {
               _job = value
            }
        }
    }
    
    fileprivate var _spouse : Person? = nil
    open var spouse : Person? {
        get {
             return _spouse
        }
        set(value) {
            if self.age >= 18 {
                _spouse = value
            }
        }
    }
    
    public init(firstName : String, lastName: String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    open func toString() -> String { //need to fix this to use get methods
        return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(job) spouse:\(spouse)]"
    }
    
    var description: String {
        return self.toString()
    }
}

////////////////////////////////////
// Family
//
open class Family {
    fileprivate var members : [Person] = []
    
    public init(spouse1: Person, spouse2: Person) {
        if spouse1.spouse == nil && spouse2.spouse == nil {
            if spouse1.age >= 21 || spouse2.age >= 21 {
                spouse1.spouse = spouse2
                spouse2.spouse = spouse1
                members.append(spouse1)
                members.append(spouse2)
            }
        }
    }
    
    open func haveChild(_ child: Person) -> Bool {
        var ageChecker: Bool = false
        for member in members {
            if member.age >= 21 {
                ageChecker = true
            }
        }
        if ageChecker {
            members.append(child)
            return true
        } else {
            return false
        }
    }
    
    open func householdIncome() -> Int {
        var total: Int = 0 //should probably store somewhere
        for member in members {
            if let job = member.job?.type { //if let means only if this isn't nil
                switch job {
                case .Hourly(let rate):
                    total += Int(Double(2000) * rate)
                case .Salary(let rate):
                    total += rate
                }
            }
        }
        print(members)
        return total
    }
    
    var description: String {
        var family: String = "["
        for member in members {
            family += "Person: \(member.firstName) "
        }
        family += "]"
        return family
    }
}
