class_name StatModifier

var formula: Callable
var priority: int
var source: Object

static func new_mod(formula: Callable, priority: int = 0, source: Object = null) -> StatModifier:
	var modifier: StatModifier = StatModifier.new()
	modifier.formula = formula
	modifier.priority = priority
	modifier.source = source
	return modifier
