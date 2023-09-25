# ========================================================
## 快速生成节点实例的函数库,
## 会对生成的实例做一些默认设定，并将一些必须属性以参数形式传入
##
## 名称：NodeCreater
## [br]类型：静态函数库
## [br]作者：巽星石
## [br]Godot版本：4.1-stable (official)
## [br]---------------------------------------------------
## [br]创建时间：2023-07-08 20:52:18
## [br]最后修改时间：2023-07-08 20:52:18
## 
## @tutorial(课程标题): 网址
# ========================================================
class_name NodeCreater


# =================================== 节点辅助生成函数 ===================================
## 创建并返回一个VBoxContainer实例。
static func VBox(node_name:String,min_size:Vector2 = Vector2(100,10)):
	var box = VBoxContainer.new()
	box.custom_minimum_size = min_size
	box.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	return box

## 创建并返回一个Label实例。
## 示例代码:
## [codeblock]
## var lab = NodeCreater.label("lab1","分组标题") # 创建并返回一个名为lab1，text为分组标题的Label实例
## [/codeblock]
## 或者，可以直接：
## [codeblock]
## xx.add_child(NodeCreater.label("lab1","分组标题")) # 直接添加创建的实例
## [/codeblock]
static func label(node_name:String,text:String) -> Label:
	var lab = Label.new()
	lab.name = node_name
	lab.text = text
	return lab

## 创建并返回一个Button实例。
static func button(node_name:String,text:String,pressed:Callable) -> Button:
	var btn = Button.new()
	btn.text = text
	btn.pressed.connect(pressed)
	return btn
