//
//  SlotBrain.swift
//  SlotMachine
//
//  Created by Andreas Seeger @MBPR on 11.10.14.
//  Copyright (c) 2014 ASSeeger. All rights reserved.
//

import Foundation

class SlotBrain {
    
    class func unpackSlotColumnsIntoSlotRows (slots: [[Slot]]) -> [[Slot]] {
        
        var slotRow0 : [Slot] = []
        var slotRow1 : [Slot] = []
        var slotRow2 : [Slot] = []
        
        for slotArray in slots {
            
            for var index = 0; index < slotArray.count; index++ {
                
                let slot = slotArray[index]
                
                if index == 0 {
                    slotRow0.append(slot)
                } else if index == 1 {
                    slotRow1.append(slot)
                } else if index == 2 {
                    slotRow2.append(slot)
                }
            }
        }
        
        let slotInRows = [slotRow0, slotRow1, slotRow2]
        
        return slotInRows
        
    }
    
    class func computeWinnings (slots:[[Slot]]) -> Int {

        var slotsInRows = unpackSlotColumnsIntoSlotRows(slots)
        
        var winnings = 0
        
        var flushWinCount = 0
        var straightWinCount = 0
        var threeOfAKindCount = 0
        
        for slotRow in slotsInRows {
            
            if checkFlush(slotRow) == true {
                println("Flush")
                flushWinCount += 1
                winnings += 1
            }
            
            if checkThreeOfAKind(slotRow) == true {
                println("Three of a kind")
                threeOfAKindCount += 1
                winnings += 3
            }
            
            if checkThreeInARow(slotRow) == true {
                println("Three in a row")
                straightWinCount += 1
                winnings += 1
            }
        }
        
        if flushWinCount == 3 {
            println("Roayl Flush")
            winnings += 15
        }
        
        if threeOfAKindCount == 3 {
            println("Threes all around")
            winnings += 50
        }
        
        if straightWinCount == 3 {
            println("Heureka")
            winnings += 1000
        }
        
        return winnings
    }
    
    class func checkFlush (slotRow:[Slot]) -> Bool {

        let slot0 = slotRow[0]
        let slot1 = slotRow[1]
        let slot2 = slotRow[2]
        
        if slot0.isRed == true && slot1.isRed == true && slot2.isRed == true {
            return true
        }
        else if slot0.isRed == false && slot1.isRed == false && slot2.isRed == false {
            return true
        }
        else {
            return false
        }
    }
    
    class func checkThreeOfAKind (slotRow: [Slot]) ->Bool {
        
        let slot0 = slotRow[0]
        let slot1 = slotRow[1]
        let slot2 = slotRow[2]
        
        if slot0.value == slot1.value && slot1.value == slot2.value {
            return true
        } else {
            return false
        }
    }
    
    class func checkThreeInARow (slotRow: [Slot]) -> Bool {
        let slot0 = slotRow[0]
        let slot1 = slotRow[1]
        let slot2 = slotRow[2]
        
        if slot2.value == slot1.value + 1 && slot1.value == slot0.value + 1 {
            return true // ascending row
        }
        else if slot0.value == slot1.value - 1 && slot1.value == slot2.value - 1 {
            return true // descending row
        }
        else {
            return false
        }
    }
    
}
