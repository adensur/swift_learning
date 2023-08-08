//
//  main.swift
//  dnd_game
//
//  Created by Maksim Gaiduk on 08/08/2023.
//

import Foundation

class Entity {
    let attackMin: Int
    let attackMax: Int
    var hp: Int
    let name: String
    init(attackMin: Int, attackMax: Int, hp: Int, name: String) {
        self.attackMin = attackMin
        self.attackMax = attackMax
        self.hp = hp
        self.name = name
    }
    
    func rollDice(from: Int, to: Int) -> Int {
        let diceRoll = Int.random(in: from...to)
        print("\(name) is rolling \(from)d\(to)! Result: \(diceRoll)")
        return diceRoll
    }
    
    func attack() -> Int {
        return rollDice(from: attackMin, to: attackMax)
    }
    
    func receiveDamage(damage: Int) -> Bool {
        hp -= damage
        if hp <= 0 {
            print("\(name) received \(damage) damage and has died.")
            return true
        }
        print("\(name) received \(damage) damage. Remaining hp: \(hp)")
        return false
    }
}

class Orc: Entity {
    init() {
        super.init(attackMin: 1, attackMax: 6, hp: 20, name: "Orc")
    }
    
    override func attack() -> Int {
        var dmg = super.attack()
        // roll for critical dmg
        let diceRoll = rollDice(from: 1, to: 8)
        
        if diceRoll == 8 {
            dmg *= 2
            print("\(name) has landed a critical hit! Dmage is doubled to \(dmg)")
        }
        return dmg
    }
}

class Elf: Entity {
    init() {
        super.init(attackMin: 1, attackMax: 8, hp: 15, name: "Elf")
    }
    override func receiveDamage(damage: Int) -> Bool {
        let evadeRoll = rollDice(from: 1, to: 6)
        if evadeRoll == 1 {
            print("\(name) has evaded the attack!")
            return false
        }
        return super.receiveDamage(damage: damage)
    }
}


//print("Enter you name : ", terminator: "")
//if let input = readLine() {
//    print("Hello \(input)!")
//}

let player = Elf()
let enemy = Orc()
// main play loop
while true {
    // print out current state of the battle
    print("A battle is happening! Your hp: \(player.hp), enemy hp: \(enemy.hp)")
    // give a player a choice - run or fight
    print("Will you fight (1) or run (2)?")
    var input = ""
    while true {
        input = readLine()!
        switch input {
        case "1":
            print("1 selected")
        case "2":
            print("2 selected")
        default:
            print("Please select 1 or 2")
            continue
        }
        break
    }
    if input == "2" {
        print("You ran away. No loot for you today!")
        break
    } else if input == "1" {
        // player turn
        let playerAttack = player.attack()
        let isEnemyDead = enemy.receiveDamage(damage: playerAttack)
        if isEnemyDead {
            print("You have won! All the loot is yours!")
            break
        }
        // enemy turn
        let enemyAttack = enemy.attack()
        let isPlayerDead = player.receiveDamage(damage: enemyAttack)
        if isPlayerDead {
            print("You have died!")
        }
        print("")
    }
}


