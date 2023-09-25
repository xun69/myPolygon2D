# ========================================================
# 名称：ShapePoints
# 类型：静态函数库
# 简介：用于生成常见几何图形的顶点数据（PackedVector2Array）
#      可用于_draw和Line2D、Polygon2D等进行绘制和显示
# 作者：巽星石
# Godot版本：4.1-stable (official)
# 创建时间：2023-07-08 20:45:22
# 最后修改时间：2023年7月17日17:28:20
# ========================================================
class_name ShapePoints

# 返回矩形的顶点
static func rect(size:Vector2,offset:Vector2 = Vector2.ZERO) -> PackedVector2Array:
	var points:PackedVector2Array = [
		offset,
		offset + Vector2.RIGHT * size.x,
		offset + size,
		offset + Vector2.DOWN * size.y,
		offset]
	return points

# 返回正多边形顶点
static func regular_polygon(start_angle:int,edges:int,r:float,offset:Vector2 = Vector2.ZERO):
	var points:PackedVector2Array
	var vec  = Vector2.RIGHT.rotated(deg_to_rad(start_angle)) * r
	for i in range(edges):
		points.append(vec.rotated(2* PI/edges * i) + offset)
	return points

# 返回圆顶点
static func circle(r:float,offset:Vector2 = Vector2.ZERO):
	var points = regular_polygon(0,2 * PI * r,r,offset)
	points.append(points[0])
	return points

# 返回扇形顶点
# 注意start_angle和end_angle都是角度
static func sector(start_angle:int,end_angle:int,r:float):
	var points:PackedVector2Array
	
	points.append(Vector2.ZERO)
	points.append_array(arc(start_angle,end_angle,r))
	points.append(Vector2.ZERO)
	return points

# 弧形
# 注意start_angle和end_angle都是角度
static func arc(start_angle:int,end_angle:int,r:float,offset:Vector2 = Vector2.ZERO):
	var points:PackedVector2Array
	var angle = deg_to_rad(end_angle - start_angle)
	var edges:float = ceilf(angle * r) # 要绘制的点的个数 = θ * r
	var vec  = Vector2.RIGHT.rotated(deg_to_rad(start_angle)) * r
	for i in range(edges+1):
		points.append(vec.rotated(angle/edges * i) + offset)
	return points



# 星形
static func star(start_angle:int,edges:int,r:float,r2:float = 0,offset:Vector2 = Vector2.ZERO):
	if r2 == 0:
		r2 = r/2.0
	var points:PackedVector2Array
	# 外部半径
	var vec  = Vector2.RIGHT.rotated(deg_to_rad(start_angle)) * r
	# 内部半径
	var vec2  = Vector2.RIGHT.rotated(deg_to_rad(start_angle + 180/edges)) * r2
	for i in range(edges):
		points.append(vec.rotated(2 * PI/edges * i) + offset)
		points.append(vec2.rotated(2 * PI/edges * i) + offset)
	return points

# 返回圆角矩形的顶点
# 注意：以(0,0)为几何中心
static func round_rect(size:Vector2,r1:float,r2:float,r3:float,r4:float,offset:Vector2 = Vector2.ZERO) -> PackedVector2Array:
	var points:PackedVector2Array
	points.append_array(arc(180,270,r1,Vector2(r1,r1) + offset))
	points.append_array(arc(270,360,r2,Vector2(size.x - r2,r2) + offset))
	points.append_array(arc(0,90,r3,Vector2(size.x - r3,size.y -r3) + offset))
	points.append_array(arc(90,180,r4,Vector2(r4,size.y - r4) + offset))
	points.append(Vector2(0,r1)+offset)
	return points

# 返回倒角矩形的顶点
# 注意：以(0,0)为几何中心
static func chamfer_rect(size:Vector2,a:float,b:float,c:float,d:float,offset:Vector2 = Vector2.ZERO) -> PackedVector2Array:
	var points:PackedVector2Array = [
		Vector2(0,a) + offset,Vector2(a,0) + offset,
		Vector2(size.x-b,0) + offset,Vector2(size.x,b) + offset,
		Vector2(size.x,size.y-c) + offset,Vector2(size.x-c,size.y) + offset,
		Vector2(d,size.y) + offset,Vector2(0,size.y-d) + offset
	]
	points.append(points[0]) # 闭合
	return points

# 返回胶囊形的顶点
static func capsule(size:Vector2,offset:Vector2 = Vector2.ZERO) -> PackedVector2Array:
	var points:PackedVector2Array = []
	var r:float = min(size.x,size.y)/2.0
	if size.x>size.y: # 横向
		points.append_array(arc(90,270,r,Vector2(r,r) + offset))
		points.append_array(arc(-90,90,r,Vector2(size.x-r,r) + offset))
	else: # 纵向
		points.append_array(arc(180,360,r,Vector2(r,r) + offset))
		points.append_array(arc(0,180,r,Vector2(r,size.y-r) + offset))
	points.append(points[0]) # 闭合
	return points
	
# 返回梭形的顶点
# 注意：以(0,0)为几何中心
static func spindle(size:Vector2,offset:Vector2 = Vector2.ZERO) -> PackedVector2Array:
	var points:PackedVector2Array = []
	var dx:float = size.x/2.0
	var dy:float = size.y/2.0
	
	var d_max = max(dx,dy)
	var d_min = min(dx,dy)
	
	var r = (pow(d_max,2.0) + pow(d_min,2.0))/(2.0 * d_min) # 圆弧半径
	var angle = rad_to_deg(asin(d_max/r))
	
	if dx<dy:
		points.append_array(arc(180-angle,180+angle,r,Vector2(r,dy)))
		points.append(Vector2(dx,0))
		points.append_array(arc(-angle,angle,r,Vector2(-r+2*dx+1,dy)))
		points.append(points[0]) # 闭合
	else:
		points.append_array(arc(270-angle,270+angle,r,Vector2(dx,r)))
		points.append(Vector2(size.x,dy))
		points.append_array(arc(90-angle,90+angle,r,Vector2(dx,-r+2*dy+1)))
		points.append(points[0]) # 闭合
	return points
# =================================== 特殊图形 ===================================
# 太极
static func taiji(r:float,offset:Vector2 = Vector2.ZERO) -> Dictionary:
	var dict = {
		pan = circle(r,offset), # 底部圆盘
		yin = [], # 阴鱼
		yang = [], # 阳鱼
		yin_eye = circle(r/10,Vector2(0,-r/2)+ offset), # 阴鱼眼
		yang_eye = circle(r/10,Vector2(0,r/2)+ offset), # 阳鱼眼
	}
	# 阴鱼
	dict["yin"].append_array(arc(90,270,r,offset))
	dict["yin"].append_array(arc(-90,90,r/2,Vector2(0,-r/2)+offset))
	var ac = arc(90,270,r/2,Vector2(0,r/2)+offset)
	ac.reverse()
	dict["yin"].append_array(ac)
	# 阳鱼
	dict["yang"].append_array(arc(-90,90,r,offset))
	dict["yang"].append_array(arc(90,270,r/2,Vector2(0,r/2)+offset))
	var ac2 = arc(-90,90,r/2,Vector2(0,-r/2)+offset)
	ac2.reverse()
	dict["yang"].append_array(ac2)
	return dict

# 螺旋线
static func helix(start_angle:int,start_r:float,end_r:float,
			step:int =1,offset:Vector2 = Vector2.ZERO) -> PackedVector2Array:
	var points:PackedVector2Array
	var steps = end_r - start_r
	for i in range(steps):
		points.append(Vector2.RIGHT.rotated(deg_to_rad(start_angle + step * i)) * (start_r+i) + offset)
	return points


# =================================== 花边图形 ===================================
enum{
	AXIS_X = 1,
	AXIS_Y = 2,
}

# 返回与实际矩形不相关的重复半圆边数据
static func repeat_circle(length:float,r:float,space:float = 0,axis:int = AXIS_X,concave:bool = false,reverse:bool = false) -> PackedVector2Array:
	var points:PackedVector2Array
	match axis:
		AXIS_X: # 水平方向
			var yu = fmod(length,(2.0 * r + space))  # 余数
			if !concave: # 凸出
				points.append(Vector2.ZERO)
				for i in floorf(length/(2.0 * r + space)):
					points.append_array(arc(180,360,r,Vector2(2 * r + space,0) * i + Vector2(r + yu/2.0,0)))
				points.append(Vector2(length,0))
			else: # 凹进去
				points.append(Vector2.ZERO)
				for i in floorf(length/(2.0 * r + space)):
					var ac = arc(0,180,r,Vector2(2 * r + space,0) * i + Vector2(r + yu/2.0,0))
					ac.reverse()
					points.append_array(ac)
				points.append(Vector2(length,0))
	if reverse:
		points.reverse()
	return points 
 
enum{
	SIDE_UP = 1,
	SIDE_RIGHT = 2,
	SIDE_BOTTOM = 3,
	SIDE_LEFT = 4
}

# 返回边线重复半圆的矩形的边
static func repeat_circle_edge(size:Vector2,r:float,space:float = 0,side:int = SIDE_UP,concave:bool = false) -> PackedVector2Array:
	var points:PackedVector2Array
	match side:
		SIDE_UP:
			points.append_array(repeat_circle(size.x,r,space,AXIS_X,concave))
		SIDE_RIGHT:
			var yu = fmod(size.y,(2.0 * r + space))  # 余数
			
			points.append(Vector2(size.x,0))
			for i in floorf(size.y/(2.0 * r + space)):
				var ac = arc(-90,90,r,Vector2(0,2 * r + space) * i + Vector2(size.x,r + yu/2.0))
				points.append_array(ac)
			
			points.append(size)
		SIDE_LEFT:
			var yu = fmod(size.y,(2.0 * r + space))  # 余数
			
			
			points.append(Vector2(0,size.y))
			for i in range(floorf(size.y/(2.0 * r + space)),0,-1):
				var ac = arc(90,270,r,Vector2(0,2 * r + space) * i + Vector2(0,yu/2.0 - r))
				#ac.reverse()
				points.append_array(ac)
			points.append(Vector2.ZERO)

		SIDE_BOTTOM:
			points.append_array(repeat_circle(size.x,r,space,AXIS_X,concave,true))
	return points

# 返回边线重复半圆的矩形的边
static func repeat_circle_edge_rect(size:Vector2,r:float,space:float = 0,concave:bool = false) -> PackedVector2Array:
	var points:PackedVector2Array
	points.append_array(repeat_circle_edge(size,r,space,SIDE_UP,concave))
	points.append_array(repeat_circle_edge(size,r,space,SIDE_RIGHT,concave))
	points.append_array(repeat_circle_edge(size,r,space,SIDE_BOTTOM,concave))
	points.append_array(repeat_circle_edge(size,r,space,SIDE_LEFT,concave))
	
	return points

# 返回指定点为中心，给定长度的两条互相垂直线段，可以用于绘制十字坐标线
static func line_cross(position:Vector2,length:float,start_angle:int = 0) -> Array:
	var start_rad = deg_to_rad(start_angle)
	# 水平线段俩端点
	var h_line = [
			Vector2.LEFT.rotated(start_rad) * length/2.0 + position,
			Vector2.RIGHT.rotated(start_rad) * length/2.0 + position,
		]
	# 水平线段俩端点
	var v_line = [
			Vector2.UP.rotated(start_rad) * length/2.0 + position,
			Vector2.DOWN.rotated(start_rad) * length/2.0 + position,
		]
	return [h_line,v_line]

# =================================== 网格矩形求取函数 ===================================
# 矩形网格 - 棋盘格矩形求取函数
static func checker_board_rects(size:Vector2,cell_size:Vector2) -> Array:
	var rects_yang:Array[Rect2]
	var rects_yin:Array[Rect2]
	for x in range(size.x):
		for y in range(size.y):
			var pos = Vector2(x,y) * cell_size
			if (x % 2 == 0 and y % 2 == 0) or (x % 2 == 1 and y % 2 == 1):
				rects_yang.append(Rect2(pos,cell_size))
			else:
				rects_yin.append(Rect2(pos,cell_size))
	return [rects_yang,rects_yin]

# =================================== 网格线和点求取函数 ===================================
# 方形 - 网格点求取函数
static func rect_grid_points(size:Vector2,cell_size:Vector2) ->PackedVector2Array:
	var points:PackedVector2Array
	for x in range(size.x + 1):
		for y in range(size.y + 1):
			points.append(Vector2(x,y) * cell_size)
	return points

# 三角 - 网格点求取函数
static func triangle_grid_points(size:Vector2,cell_size:Vector2) ->PackedVector2Array:
	var points:PackedVector2Array
	for y in range(size.y + 1):
		if y % 2 == 0: # 偶数行
			for x in range(size.x + 1):
				points.append(Vector2(x,y) * cell_size)
		else: # 奇数行
			for x in range(size.x):
				points.append(Vector2(x,y) * cell_size + Vector2(cell_size.x/2,0))
	return points

# 六边形 - 网格点求取函数
static func hex_grid_points(size:Vector2,cell_size:Vector2) ->PackedVector2Array:
	var points:PackedVector2Array
	for y in range(size.y + 1):
		if y % 2 == 0: # 偶数行
			for x in range(size.x):
				if (x+1)% 3 != 0:
					points.append(Vector2(x,y) * cell_size + Vector2(cell_size.x/2,0))
		else: # 奇数行
			for x in range(size.x + 1):
				if x % 3 != 1:
					points.append(Vector2(x,y) * cell_size)
	return points

# 方形 - 网格线求取函数
static func rect_grid_lines(size:Vector2,cell_size:Vector2) -> Dictionary:
	var lines = {
		v_lines = [], # 垂直的网格线
		h_lines = []  # 水平的网格线
	}
	var v_line1 = [Vector2.ZERO,Vector2.DOWN * cell_size.y * size.y]
	var h_line1 = [Vector2.ZERO,Vector2.RIGHT * cell_size.x * size.x]
	lines["v_lines"].append(v_line1)
	lines["h_lines"].append(h_line1)
	for x in range(1,size.x+1):
		var offset_x = Vector2(cell_size.x,0) * x
		lines["v_lines"].append([v_line1[0] + offset_x,v_line1[1] + offset_x])
	for y in range(1,size.y+1):
		var offset_y = Vector2(0,cell_size.y) * y
		lines["h_lines"].append([h_line1[0] + offset_y,h_line1[1] + offset_y])
	return lines

# =================================== 刻度线生成 ===================================


# 返回指定范围的弧形刻度线起始点坐标集合
# start_angle:起始角度
# end_angle:结束角度
# steps:切分次数
# r:半径
# length：刻度线长
static func arc_scale(start_angle:int,end_angle:int,steps:int,r:float,length:float) -> Array:
	var scales:Array = []
	var vec1 = (Vector2.RIGHT  * (r-length)).rotated(deg_to_rad(start_angle))
	var vec2 = (Vector2.RIGHT  * r).rotated(deg_to_rad(start_angle))
	var angle = deg_to_rad(end_angle - start_angle) # 夹角
	for i in range(steps+1):
		var line = [vec1.rotated((angle/steps) * i),vec2.rotated((angle/steps) * i)]
		scales.append(line)
	return scales

# 返回指定范围的直线刻度线起始点坐标集合
static func line_scale(ruler_width:float,steps:int,length:float):
	var scales:Array = []
	var vec1 = Vector2.ZERO
	var vec2 = Vector2.DOWN * length
	var space = ruler_width/steps  # 单位间隔
	for i in range(steps+1):
		var line = [vec1 + Vector2(space,0) * i,vec2 + Vector2(space,0) * i]
		scales.append(line)
	return scales
	

	
