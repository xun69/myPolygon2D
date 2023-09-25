@tool
extends MarginContainer

var obj:Node # 当前正在编辑的节点

# 图形类型下拉列表
@onready var shap_type_opt:OptionButton = %ShapTypeOpt
# 选项卡
@onready var tab = %Tab

# 矩形 - 参数
@onready var rect_width_spin := %RectWidthSpin
@onready var rect_height_spin := %RectHeightSpin
## 正多边形 - 参数
@onready var regular_edges_spin = %RegularEdgesSpin
@onready var regular_radius_spin = %RegularRadiusSpin
@onready var regular_start_angle_spin = %RegularStartAngleSpin
# 圆形 - 参数
@onready var circle_radius_spin = $ui/Tab/Circle/CircleRadiusSpin
# 扇形 - 参数
@onready var sector_start_angle_spin = %SectorStartAngleSpin
@onready var sector_end_angle_spin = %SectorEndAngleSpin
@onready var sector_radius_spin = %SectorRadiusSpin
# 星形 - 参数
@onready var star_start_angle_spin = %StarStartAngleSpin
@onready var star_edges_spin = %StarEdgesSpin
@onready var star_radius_1_spin = %StarRadius1Spin
@onready var star_radius_2_spin = %StarRadius2Spin


# 所有可用的图形类型
var shap_types = ["矩形","正多边形","圆形","扇形","星形"]


# =================================== 虚函数 ===================================
func _ready():
	# 隐藏选项卡
	tab.tabs_visible = false
	shap_type_opt.clear()
	# 加载图形类型下拉列表
	for type in shap_types:
		shap_type_opt.add_item(type)
	shap_type_opt.select(0)


# =================================== 信号处理 ===================================
# 应用按钮 - 点击
func _on_apply_btn_pressed():
	var points:PackedVector2Array
	match shap_type_opt.get_item_text(shap_type_opt.selected):
		"矩形":
			points = ShapePoints.rect(Vector2(rect_width_spin.value,rect_height_spin.value))
		"正多边形":
			points = ShapePoints.regular_polygon(
				regular_start_angle_spin.value,
				regular_edges_spin.value,
				regular_radius_spin.value
			)
		"圆形":
			points = ShapePoints.circle(circle_radius_spin.value)
		"扇形":
			points = ShapePoints.sector(
				sector_start_angle_spin.value,
				sector_end_angle_spin.value,
				sector_radius_spin.value
			)
		"星形":
			points = ShapePoints.star(
				star_start_angle_spin.value,
				star_edges_spin.value,
				star_radius_1_spin.value,
				star_radius_2_spin.value
			)
	match obj.get_class():
		"Polygon2D","CollisionPolygon2D":
			obj.polygon = points
		"Line2D":
			points.append(points[0])
			obj.points = points
	

# 选择图形类型
func _on_shap_type_opt_item_selected(index):
	tab.current_tab = index # 切换选项卡




