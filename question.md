## ArcTS 实现问题
- SVG preserveAspectRatio 属性目前不支持
    - 该属性解决 viewBox 和 svg 宽高比不一致，图像展示问题。
    - preserveAspectRatio: none 图像会根据svg的宽高填满整个区域。
    - ArcUI Path 的绘制是根据路径 commonds 占据的像素来绘制，不会根据 Shape 宽高填满整个区域。

- strokeCap、strokeJoin、strokeMiter 这个3个属性与clip 有冲突
    - 这三个属性是设置路径相交的方式，由于使用了 clip 裁切，边框在外部展示部分会被裁切，因此无效。

- translateZ 通过属性传递在 Shape zIndex(translateZ) 上使用，没有效果；直接在 ClipPath 组件 使用 zIndex(2) 有效果
    - ```jsx
        Shape() {
            Path({
                commands: this.d,
            })
        }
        .zIndex(this.translateZ) // 无效

        ClipPathView({
            translateZ: 1 // 无效
        })
        .zIndex(2) // 有效果
<br>
<br>
<br>
<br>
<br>
<br>


  svgKey?: string;【√】
  d?: string;【√】
  align?: string;  ArcTS 自定义组件有重名 改为 cpAlign
  aspect?: string;
  fillRule?: string; ArcTS Shape Path 没有
  viewBox?: TViewBox;【√】
  strokeWidth?: number;【√】
  strokeCap?: LineCapStyle;【√】
  strokeJoin?: LineJoinStyle;【√】
  strokeMiter?: number;【√】
  strokeStart?: number;
  strokeEnd?: number;

  translateZ?: number;  存疑对应使用zindex 无效
  transX?: number;【√】
  transY?: number;【√】
  transPercentageValue?: boolean; 【√】
  rot?: number;【√】
  rotOx?: number;【√】
  rotOy?: number;【√】
  rotPercentageValue?: boolean;【√】
  sc?: number;【√】
  scX?: number;【√】
  scY?: number;【√】
  scO?: number;【√】
  scOx?: number;【√】
  scOy?: number;【√】
  scPercentageValue?: boolean;【√】