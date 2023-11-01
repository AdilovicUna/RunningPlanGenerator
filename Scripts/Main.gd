extends Node2D

var planLabel = load("res://Scripts/PlanLabel.gd").new()

# the length of the run in kilometers
const FINAL_DISTANCE: int = 5
# each round increase runUntil by this amount
const INCREASE_FOR_RUNUNTIL: int = 1
# run until this distance with the starting speed
const FIRST_STOP: float = 2.5
# each round increase speed by this amount
const INCREASE_FOR_SPEED: float = 0.2
# maximum speed used for sprint at the end
const MAX_SPEED: float = 12.0


"""
TO DO:  store these vars in a file
        and each time read/write to them
"""
# starting speed from the last run
var previousStartingSpeed: float = 8.0
# distance of the sprint at the end in km from the last run
var endSprint: float = 0.3
# every other time we need to increase previousStartingSpeed
# this variable indicates if that happened before the last run
var previouslyIncreased: bool = false

func generatePlan():
    var newStartingSpeed: float =  previousStartingSpeed + ( INCREASE_FOR_SPEED * int(previouslyIncreased))
    run(0, FIRST_STOP, newStartingSpeed)
    
    previousStartingSpeed = newStartingSpeed
    endSprint += 0.05
    previouslyIncreased = not previouslyIncreased
      
func run(runFrom, runUntil, speed, planLabelText = ""):
    if (runUntil == FINAL_DISTANCE):
        planLabelText = addToText(runFrom, runUntil, speed, planLabelText)
        planLabel.changeText(planLabelText)
        return
    
    planLabelText = addToText(runFrom, runUntil, speed, planLabelText)
    """
    TO DO:  cover with tests
    """
    var nextRunUntil = calculateNextRunUntil(runUntil)
    var nextSpeed = speed + INCREASE_FOR_SPEED if nextRunUntil < FINAL_DISTANCE else MAX_SPEED
    
    run(runUntil, nextRunUntil, nextSpeed, planLabelText)

func addToText(runFrom, runUntil, speed, planLabelText):
    planLabelText += "Run from %0.2f to %0.2f with speed %0.1f \n" % [runFrom, runUntil, speed]
    print(planLabelText)
    return planLabelText
    
"""
TO DO:  cover with tests`
"""
func calculateNextRunUntil(currentRunUntil):
    # always increase by the same amount
    # except that last endSprint km need to be run with max speed
    
    if (currentRunUntil + endSprint == FINAL_DISTANCE):
        return FINAL_DISTANCE
        
    var nextRunUntil = currentRunUntil + INCREASE_FOR_RUNUNTIL
    if (nextRunUntil + endSprint > FINAL_DISTANCE):
        nextRunUntil = FINAL_DISTANCE - endSprint 

    return nextRunUntil


