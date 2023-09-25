# ========================================================
## 基于Rect2获取更多的边角点信息。
##
## 名称：mRect2
## [br]类型：自定义类
## [br]作者：巽星石
## [br]Godot版本：4.1-stable (official)
## [br]---------------------------------------------------
## [br]创建时间：2023-07-09 17:46:49
## [br]最后修改时间：2023-07-09 17:46:49
## 
## @tutorial(课程标题): 网址
# ========================================================
class_name mRect2

var _rect:Rect2

# =================================== 构造 ===================================
func _init(rect:Rect2):
	_rect = rect

# =================================== 方法 ===================================
## 矩形 - 左上角 - 坐标
func top_left() -> Vector2:
	return _rect.position

## 矩形 - 顶边中心 - 坐标
func top_center() -> Vector2:
	return _rect.position + Vector2.RIGHT * (_rect.size.x/2)

## 矩形 - 顶边中心 - 坐标
func top_right() -> Vector2:
	return _rect.position + Vector2.RIGHT * _rect.size.x


## 矩形 - 左边中心 - 坐标
func left_center() -> Vector2:
	return _rect.position + Vector2.DOWN * (_rect.size.y/2)

## 矩形 - 矩形中心 - 坐标
func center() -> Vector2:
	return _rect.get_center()

## 矩形 - 右边中心 - 坐标
func right_center() -> Vector2:
	return  _rect.get_center() + Vector2.RIGHT * (_rect.size.x/2)


## 矩形 - 左下角 - 坐标
func left_bottom() -> Vector2:
	return _rect.position + Vector2.DOWN * _rect.size.y

## 矩形 - 底边中心 - 坐标
func bottom_center() -> Vector2:
	return _rect.get_center()  + Vector2.DOWN * (_rect.size.y/2)

## 矩形 - 右下角 - 坐标
func right_bottom() -> Vector2:
	return  _rect.end

## 矩形 - 四个角坐标点 - 数组
## 可同于绘制矩形
func corners() -> PackedVector2Array:
	return [top_left(),top_right(),right_bottom(),left_bottom()]

## 返回矩形对应的9个点 - 数组
func points() -> PackedVector2Array:
	return [
		top_left(),top_center(),top_right(),
		left_center(), center(),right_center(),
		left_bottom(),bottom_center(),right_bottom()
	]
