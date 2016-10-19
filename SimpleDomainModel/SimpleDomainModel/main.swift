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
    public var amount : Double
    public var currency : String
    let USDToGBP = 0.5
    let USDToEUR = 1.5
    let USDToCAN = 1.25
    let GBPToEUR = 3.0
    let GBPToCAN = 2.5
    let EURToCAN: Double = (5/6)
    
    let typeArray = ["USD", "GBP", "EUR", "CAN"]
    
    public mutating func convert(_ to: String) -> Money {
        if (!typeArray.contains(to)) {
            print("Invalid currency type")
        }
        else {
            if currency == "USD" { /*assuming no-one wants to convert USD to USD*/
                switch to {
                case "GBP":
                    self.amount *= USDToGBP
                    return Money(amount: self.amount, currency: "GBP")
                case "EUR":
                    self.amount *= USDToEUR
                    return Money(amount: self.amount, currency: "EUR")
                case "CAN":
                    self.amount *= USDToCAN
                    return Money(amount: self.amount, currency: "CAN")
                default:
                    break
                }
            } else if currency == "GBP" {
                switch to {
                case "USD":
                    self.amount /= USDToGBP
                    return Money(amount: self.amount, currency: "USD")
                case "EUR":
                    self.amount *= GBPToEUR
                    return Money(amount: self.amount, currency: "EUR")
                case "CAN":
                    self.amount *= GBPToCAN
                    return Money(amount: self.amount, currency: "CAN")
                default:
                    break
                }

            } else if currency == "EUR" {
                switch to {
                case "USD":
                    self.amount /= USDToEUR
                    return Money(amount: self.amount, currency: "USD")
                case "CAN":
                    self.amount *= EURToCAN
                    return Money(amount: self.amount, currency: "CAN")
                case "GBP":
                    self.amount /= GBPToEUR
                    return Money(amount: self.amount, currency: "GBP")
                default:
                    break
                }
            } else if currency == "CAN" {
                switch to {
                case "USD":
                    self.amount /= USDToCAN
                    return Money(amount: self.amount, currency: "GBP")
                case "EUR":
                    self.amount /= EURToCAN
                    return Money(amount: self.amount, currency: "EUR")
                case "GBP":
                    self.amount /= GBPToCAN
                    return Money(amount: self.amount, currency: "CAN")
                default:
                    break
                }
            }
        }
        return self
    }

    mutating func add(_ to: Money) -> Money {
        let localTo = to
        if self.currency != localTo.currency {
            self = self.convert(localTo.currency)
        }
        return Money(amount: self.amount + localTo.amount, currency: localTo.currency)
    }
        
    mutating func subtract(_ from: Money) -> Money {
        let localfrom = from
        if self.currency != localfrom.currency {
            self = self.convert(localfrom.currency)
        }
        return Money(amount: localfrom.amount - self.amount, currency: localfrom.currency)
    }
}

//public enum Type {
//    case CAD
//    case EUR
//    case GBP
//    case USD
//}

//////////////////////////////////////
//// Job
////
//open class Job {
//    fileprivate var title : String
//    fileprivate var type : JobType
//    
//    public enum JobType {
//        case Hourly(Double)
//        case Salary(Int)
//    }
//    
//    public init(title : String, type : JobType) {
//        self.title = title
//        self.type = type
//    }
//    
//    /*open func calculateIncome(_ hours: Int) -> Int {
//        if(self.type =) {
//            
//            } else {
//            return type;
//            }
//        }
//    
//    open func raise(_ amt : Double) {
// 
//    }*/
//}
//
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
