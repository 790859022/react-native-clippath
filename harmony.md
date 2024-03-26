## react-native-clippath

[expo demo](https://snack.expo.dev/@fgang/react-native-clippathview-demo)
#### 源库 web 原理
> 组件通过使用 svg path data 绘制形状，并通过 svg clip path 属性实现裁切展示。

#### 问题点
- data path 数据在 harmony 实际绘制是用的px；viewBox 没有单位在 harmony 转为 vp；


#### 鸿蒙化设计 
- [Shape](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-drawing-components-shape-0000001428061768-V3)
- [Path](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-drawing-components-path-0000001477981225-V3)
- [通用属性 clip](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-universal-attributes-sharp-clipping-0000001477981173-V3)

> 通过 ArcTs 基础组件 Shape + Path 绘制形状，通过通用属性 clip 实现裁切。


#### 说明表
| 属性                 | 描述                                                                                                      | 类型              | 默认值      | 鸿蒙属性                                |
|----------------------|---------------------------------------------------------------------------------------------------------|-------------------|-------------|-----------------------------------------|
| svgKey               | 唯一key                                                                                                   | string            | -           | Shape().key()                           |
| d                    | 形状由一系列命令定义（svg path data）                                                                       | string            | -           | Path({ commands: d })                   |
| viewBox              | 定义用户空间中的位置和维度                                                                                | Array<Number>(4)  | [0,0,-1,-1] | Shape().viewPort()                      |
| align                | preserveAspectRatio 属性的 align                                                                          | string            | xMidYMid    | 无                                      |
| aspect               | preserveAspectRatio 属性的 meetOrSlice                                                                    | meet/slice/none   | meet        | 无                                      |
| fillRule             | 路径内部填充规则                                                                                          | nonzero/evenodd   | nonzero     | 无                                      |
| strokeWidth          | 路径描边宽度                                                                                              | number            | 1           | Shape().strokeWidth()                   |
| strokeCap            | 开放路径两端的形状                                                                                        | butt/round/square | butt        | Shape().strokeLineCap()                 |
| strokeJoin           | 路径转角处使用的形状                                                                                      | bevel/miter/round | miter       | Shape().strokeLineJoin()                |
| strokeMiter          | strokeJoin值是miter，设置夹角延伸                                                                          | number            | 4           | Shape().strokeMiterLimit()              |
| strokeStart          | IOS CAShapeLayer 描线开始的地方占总路径的百分比。默认值是0。                                                | number            | 0           | 无                                      |
| strokeEnd            | IOS CAShapeLayer 表示绘制结束的地方站总路径的百分比。默认值是1，如果小于等于strokeStart 则绘制不出任何内容。 | number            | 1           | 无                                      |
| translateZ           | 设置定位层级，相当于index                                                                                  | number            | 0           | Shape().zIndex()                        |
| transX               | 在二维平面上水平方向移动元素                                                                              | number            | 0           | Shape().translate({ x: 0 })             |
| transY               | 在二维平面上垂直方向移动元素                                                                              | number            | 0           | Shape().translate({ y: 0 })             |
| transPercentageValue | transX、transY 使用百分比                                                                                  | boolean           | false       | 无                                      |
| rot                  | 元素围绕一个定点旋转                                                                                      | number            | 0,0(左上角) | Shape().rotate({ angle: 0})             |
| rotOx                | 旋转中心点水平位置                                                                                        | number            | 0           | Shape().rotate({ centerX: 0})           |
| rotOy                | 旋转中心点垂直位置                                                                                        | number            | 0           | Shape().rotate({ centerY: 0})           |
| rotPercentageValue   | rotOx、rotOy 使用百分比                                                                                    | boolean           | false       | 无                                      |
| sc                   | 放大或缩小元素                                                                                            | number            | 1           | Shape().scale({x: 1, y: 1 })            |
| scX                  | 水平缩放                                                                                                  | number            | 1           | Shape().scale({x: 1})                   |
| scY                  | 垂直缩放                                                                                                  | number            | 1           | Shape().scale({y: 1})                   |
| scO                  | 缩放中心点位置                                                                                            | number            | 0,0(左上角)        | Shape().scale({centerX: 0, centerY: 0}) |
| scOx                 | 缩放中心点水平位置                                                                                        | number            | 0           | Shape().scale({centerX: 0})             |
| scOy                 | 缩放中心点垂直位置                                                                                        | number            | 0           | Shape().scale({centerY: 0})             |
| scPercentageValue    | scO、scOx、scOy使用百分比                                                                                   | boolean           | false       | 无                                      |
