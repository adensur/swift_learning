//
//  main.swift
//  dnd_game
//
//  Created by Maksim Gaiduk on 08/08/2023.
//

import Foundation

protocol EntityProtocol {
    func attack() -> Int
    mutating func receiveDamage(damage: Int) -> Bool
    var hp: Int {
        get
    }
    func getFullName() -> String
}

struct Entity: EntityProtocol {
    let attackMin: Int
    let attackMax: Int
    var hp: Int
    let name: String
    let surname: String
    init(attackMin: Int, attackMax: Int, hp: Int, name: String, surname: String) {
        self.attackMin = attackMin
        self.attackMax = attackMax
        self.hp = hp
        self.name = name
        self.surname = surname
    }
    
    func getFullName() -> String {
        return name + surname
    }
    
    func rollDice(from: Int, to: Int) -> Int {
        let diceRoll = Int.random(in: from...to)
        print("\(name) \(surname) is rolling \(from)d\(to)! Result: \(diceRoll)")
        return diceRoll
    }
    
    func attack() -> Int {
        return rollDice(from: attackMin, to: attackMax)
    }
    
    mutating func receiveDamage(damage: Int) -> Bool {
        hp -= damage
        if hp <= 0 {
            print("\(name) received \(damage) damage and has died.")
            return true
        }
        print("\(name) received \(damage) damage. Remaining hp: \(hp)")
        return false
    }
}

struct Orc: EntityProtocol {
    var extraData: Int = 20
    mutating func receiveDamage(damage: Int) -> Bool {
        extraData -= 1
        if extraData < 0 {
            return true
        }
        return entity.receiveDamage(damage: damage)
    }
    
    var hp: Int {
        return entity.hp
    }
    
    func getFullName() -> String {
        return entity.getFullName()
    }
    
    var entity: Entity
    init() {
        self.entity = Entity(attackMin: 1, attackMax: 6, hp: 20, name: "Orc", surname: "orkovish")
    }
    
    func attack() -> Int {
        var dmg = entity.attack()
        // roll for critical dmg
        let diceRoll = entity.rollDice(from: 1, to: 8)
        
        if diceRoll == 8 {
            dmg *= 2
            print("\(entity.name) has landed a critical hit! Dmage is doubled to \(dmg)")
        }
        return dmg
    }
}

struct Elf: EntityProtocol {
    func attack() -> Int {
        return entity.attack()
    }
    
    var hp: Int {
        return entity.hp
    }
    func getFullName() -> String {
        return entity.getFullName()
    }
    
    var entity: Entity
    init() {
        self.entity = Entity(attackMin: 1, attackMax: 8, hp: 15, name: "Elf", surname: "chompski")
    }
    mutating func receiveDamage(damage: Int) -> Bool {
        let evadeRoll = entity.rollDice(from: 1, to: 6)
        if evadeRoll == 1 {
            print("\(entity.name) has evaded the attack!")
            return false
        }
        return entity.receiveDamage(damage: damage)
    }
}


//print("Enter you name : ", terminator: "")
//if let input = readLine() {
//    print("Hello \(input)!")
//}
func playLoop(player: some EntityProtocol, enemy: some EntityProtocol) {
    var player = player
    var enemy = enemy
    print(MemoryLayout.size(ofValue: player))
    print(MemoryLayout.size(ofValue: enemy))
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
                break
            }
            print("")
        }
    }
}

let player = Elf()
let enemy = Orc()
print(MemoryLayout.size(ofValue: Entity(attackMin: 3, attackMax: 5, hp: 100, name: "asd", surname: "bcd")))
print(MemoryLayout.size(ofValue: player))
print(MemoryLayout.size(ofValue: enemy))
playLoop(player: player, enemy: enemy)
playLoop(player: enemy, enemy: player)

print("Final player hp: \(player.hp)")
