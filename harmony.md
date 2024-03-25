## react-native-clippath

[expo demo](https://snack.expo.dev/@fgang/react-native-clippathview-demo)
#### 源库 web 原理
> 组件通过使用 svg path data 绘制形状，并通过 svg clip path 属性实现裁切展示。

#### 问题点
- data path 数据在 harmony 实际绘制是用的px；viewBox 没有单位在 harmony 转为 vp；


#### 鸿蒙化设计 
- [Shape](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-drawing-components-shape-0000001428061768-V3)
- [Path](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-drawing-components-path-0000001477981225-V3)
- [Line](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-drawing-components-line-0000001478181437-V3)
- [通用属性 clip](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-universal-attributes-sharp-clipping-0000001477981173-V3)

> 通过 ArcTs 基础组件 Shape + Path 绘制形状，通过通用属性 clip 实现裁切。



#### 属性
| 属性                 | 描述                                | 类型             | 默认值      | 平台            | 鸿蒙化说明 |
|----------------------|-------------------------------------|------------------|-------------|-----------------|------------|
| svgKey               | 唯一key                             | String           | -           | IOS/Android/Web | 同源库一致 |
| d                    | 形状由一系列命令定义（svg path data） | string           | -           | IOS/Android/Web | 同源库一致 |
| viewBox              | 定义用户空间中的位置和维度          | Array<Number>(4) | [0,0,-1,-1] |                 |            |
| align                | preserveAspectRatio 属性的 align    | string           |             |                 |            |
| aspect               |                                     |                  |             |                 |            |
| fillRule             |                                     |                  |             |                 |            |
| strokeWidth          |                                     |                  |             |                 |            |
| strokeCap            |                                     |                  |             |                 |            |
| strokeJoin           |                                     |                  |             |                 |            |
| strokeMiter          |                                     |                  |             |                 |            |
| strokeStart          |                                     |                  |             |                 |            |
| strokeEnd            |                                     |                  |             |                 |            |
| translateZ           |                                     |                  |             |                 |            |
| transX               |                                     |                  |             |                 |            |
| transY               |                                     |                  |             |                 |            |
| transPercentageValue |                                     |                  |             |                 |            |
| rot                  |                                     |                  |             |                 |            |
| rotOx                |                                     |                  |             |                 |            |
| rotOy                |                                     |                  |             |                 |            |
| rotPercentageValue   | 设置旋转中心点是否使用百分比        |                  |             |                 |            |
| sc                   |                                     |                  |             |                 |            |
| scX                  |                                     |                  |             |                 |            |
| scY                  |                                     |                  |             |                 |            |
| scO                  |                                     |                  |             |                 |            |
| scOx                 |                                     |                  |             |                 |            |
| scOy                 |                                     |                  |             |                 |            |
| scPercentageValue    | 设置缩放中心点是否使用百分比        |                  |             |                 |            |
