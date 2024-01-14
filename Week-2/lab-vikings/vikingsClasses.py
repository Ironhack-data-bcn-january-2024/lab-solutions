
import random

# Soldier


class Soldier:
    def __init__(self, health, strength):
        # attack method
        self.health = health 
        self.strength = strength
    
    def attack(self):
        return self.strength

    def receiveDamage(self, damage):
        # should remove the received damage from the health property
        self.health -= damage
        return
    

# Viking

class Viking(Soldier):
    def __init__(self, name, health, strength):
        super().__init__(health, strength)
        self.name = name

    def battleCry(self):
        return "Odin Owns You All!"

    def receiveDamage(self, damage):
        super().receiveDamage(damage)
        if self.health > 0:
            return f"{self.name} has received {damage} points of damage"
        else:
            return f"{self.name} has died in act of combat"

# Saxon

class Saxon(Soldier):
    def __init__(self, health, strength):
        super().__init__(health, strength)

    def receiveDamage(self, damage):
        super().receiveDamage(damage)
        if self.health > 0:
            return f"A Saxon has received {damage} points of damage"
        else:
            return f"A Saxon has died in combat"

# Davicente

class War():
    def __init__(self):
        self.vikingArmy = []
        self.saxonArmy = []

    def addViking(self, viking):
        self.vikingArmy.append(viking)
    
    def addSaxon(self, saxon):
        self.saxonArmy.append(saxon)
    
    def vikingAttack(self):
        sample = random.choice(self.saxonArmy)
        result_viking_attack = sample.receiveDamage(random.choice(self.vikingArmy).strength)
        if sample.health >= 0:
            self.saxonArmy.remove(sample)
        return result_viking_attack 
    
    def saxonAttack(self):
        sample_2 = random.choice(self.vikingArmy)
        result_saxon_attack = sample_2.receiveDamage(random.choice(self.saxonArmy).strength)
        if sample_2.health >= 0:
            self.vikingArmy.remove(sample_2)
        return result_saxon_attack 

    def showStatus(self):
        if len(self.saxonArmy) <= 0:
            return "Vikings have won the war of the century!"
        elif len(self.vikingArmy) <= 0:
            return "Saxons have fought for their lives and survive another day..."
        elif len(self.saxonArmy) > 0 and len(self.vikingArmy) > 0:
            return "Vikings and Saxons are still in the thick of battle."
    pass

#yop
class War2:

    def __init__(self):
        self.vikingArmy = []
        self.saxonArmy = []

    def addViking(self, Viking):
        self.vikingArmy.append(Viking)
    
    def addSaxon(self, Saxon):
        self.saxonArmy.append(Saxon)
    
    def vikingAttack(self):
        viking = random.choice(self.vikingArmy)
        saxon = random.choice(self.saxonArmy) 
        sax_dam = saxon.receiveDamage(viking.strength)
        if saxon.health <= 0:
            self.saxonArmy.pop()
        return sax_dam

    def saxonAttack(self):
        viking = random.choice(self.vikingArmy)
        saxon = random.choice(self.saxonArmy) 
        vik_dam = viking.receiveDamage(saxon.strength)
        if viking.health <= 0:
            self.vikingArmy.pop()
        return vik_dam

    def showStatus(self):
        if len(self.saxonArmy) <= 0:
            return "Vikings have won the war of the century!"
        elif len(self.vikingArmy) <= 0:
            return "Saxons have fought for their lives and survive another day..."
        elif len(self.saxonArmy) > 0 and len(self.vikingArmy) > 0:
            return "Vikings and Saxons are still in the thick of battle."

    pass


