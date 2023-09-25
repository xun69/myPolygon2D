# ========================================================
# 名称：
# 类型：节点插件
# 简介：扩展Polygon2D功能的插件，提供快速的参数化的图形
# 作者：巽星石
# Godot版本：4.1-stable (official)
# 创建时间：2023-07-08 16:55:19
# 最后修改时间：2023-07-08 16:55:19
# ========================================================
@tool
extends EditorPlugin

var UI = preload("res://addons/myPolygon2D/ui.tscn")
var control = UI.instantiate()
const right_side = EditorPlugin.CONTAINER_CANVAS_EDITOR_SIDE_RIGHT

var surrpot_class = ["Polygon2D","CollisionPolygon2D","Line2D"]
var is_showing = false

# =================================== 核心 ===================================
func _handles(object): # 想使用edit()必须先有handles()并且返回true
	return object.get_class() in surrpot_class

# 当正在编辑节点或资源时
func _edit(object):
	control.obj = object
	if object.get_class() in surrpot_class:
		if !is_showing:
			add_control_to_container(right_side,control)
			is_showing = true
	else:
		control.obj = null
		remove_control_from_container(right_side,control)
		is_showing = false
	print(control.obj)
	
func _exit_tree():
	if control:
		control.queue_free()
