extends Button

var main = load("res://Scripts/Main.gd").new()

func _on_GeneratePlanButton_pressed():
    main.generatePlan()
    # we can't generate plan more than once per run
    hide()

 
