extends Projectile

func on_hit(other: Node2D):
	if other is Enemy:
		other.on_hit(damage)
		
		if not pass_through:
			queue_free()
