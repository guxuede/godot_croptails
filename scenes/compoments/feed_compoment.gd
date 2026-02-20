class_name FeedCompoment
extends Area2D

signal food_recevied(area:Area2D)



func _on_area_entered(area: Area2D) -> void:
	print("food_recevied")
	food_recevied.emit(area)
