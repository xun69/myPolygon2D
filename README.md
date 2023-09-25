# myPolygon2D
Godot4. x plugin for quickly creating geometric shapes for Polygon2D nodes

Godot4.x插件，用于快速创建Polygon2D节点的几何形状

When you add a Polygon2D node and select it, you will see a custom area on the right side of the 2D workspace where you can select basic shapes and set parameters. After clicking Apply, parameterized shapes will be created for the current Polygon2D node.

当你添加一个Polygon2D节点并选中它的时候，会在2D工作区右侧看到一个自定义的区域，你可以在上面选择基本的基本的形状，以及设定参数，点击应用后，就会为当前Polygon2D节点创建参数化的几何图形。

![image](https://github.com/xun69/myPolygon2D/assets/23306801/ca7ae0a2-0594-4ce7-bf81-d476a3fe9eb9)

## Based on the ShapePoints class

ShapePoints is a GDScript static function library for extracting common 2D geometric vertices. You can find the source code in "addons/myPolygon2D/classes/ShapePoints.gd".

ShapePoints是一个求取常见2D几何图形顶点的GDScript静态函数库，你可以在 “addons/myPolygon2D/class/ShapePoints.gd” 找到源码。

## Some cases

By combining multiple Polygon2D nodes, you can easily create some complex geometric shapes.

通过组合多个`Polygon2D`节点，你可以轻松创建一些复杂的几何图形。

![image](https://github.com/xun69/myPolygon2D/assets/23306801/e1641ef7-9be5-49cd-b738-bb54fd8f72b4)

## Use as a custom node

Based on ShapePoints, I have also created some custom nodes to extend Polygon2D, which can be parameterized directly in the viewer panel for more real-time and flexible settings.
Can you view my other project 'CustomiNodes'


基于ShapePoints，我还创建了一些自定义节点，扩展Polygon2D，可以直接参数化的在检视器面板进行设定，更加实时和灵活。

可以查看我另一个项目“CustomNodes”
