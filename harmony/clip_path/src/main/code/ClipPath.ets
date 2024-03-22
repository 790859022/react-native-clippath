import { TViewBox, IViewPort, TChildrenBuilder } from './types'

@Preview
@Component
struct ClipPath {
  @Prop openClip: boolean = true
  @Prop fill: ResourceColor = Color.Black
  @Prop svgKey: string = ''
  @Prop d: string = ''
  @Prop viewBox: TViewBox = []
  @Prop cpAlign: string = '' // align
  @Prop aspect: string = ''
  @Prop fillRule: string = ''
  @Prop strokeWidth: string | number = 0
  @Prop strokeCap: LineCapStyle = LineCapStyle.Butt
  @Prop strokeJoin: LineJoinStyle = LineJoinStyle.Miter
  @Prop strokeMiter: string | number = 0
  @Prop strokeStart: number = 0
  @Prop strokeEnd: number = 1
  @Prop translateZ: number = 1
  @Prop transX: number = 0
  @Prop transY: number = 0
  @Prop transPercentageValue: boolean = false
  @Prop rot: number = 0
  @Prop rotOx: number = 0
  @Prop rotOy: number = 0
  @Prop rotPercentageValue: boolean = false
  @Prop sc: number = 1
  @Prop scX: number = 1
  @Prop scY: number = 1
  @Prop scO: number = 1
  @Prop scOx: number = 0
  @Prop scOy: number = 0
  @Prop scPercentageValue: number = 1
  @BuilderParam childrenBuilder: TChildrenBuilder = this.defaultChildrenBuilder
  @BuilderParam closer: TChildrenBuilder = this.defaultChildrenBuilder

  aboutToAppear(): void {
    console.log(`FG ${this.backgroundColor}`)
  }

  computedClipParams(): PathAttribute | boolean {
    return this.openClip ? new Path({ commands: this.d }) : false
  }

  computedViewBoxParam(): IViewPort {
    const viewBox = this.viewBox
    if (viewBox.length !== 4) return {}
    return {
      x: viewBox[0] + 'px',
      y: viewBox[1] + 'px',
      width: viewBox[2] + 'px',
      height: viewBox[3] + 'px'
    }
  }

  computedTranslateValue(val: number){
    if(this.transPercentageValue){
      return `${val}%`
    }
    return `${val}px`
  }

  computedRotateValue(): RotateOptions{
    let val = {
      // centerX: 0,
      // centerY: 0,
      // centerZ: 0,
      angle: this.rot
    } as RotateOptions
    if(this.rotOx) {
      val.x = this.rotOx
    }
    if(this.rotOy) {
      val.y = this.rotOy
    }
    if(this.rotPercentageValue){

    }
    return val
  }

  @Builder
  defaultChildrenBuilder() {
  };

  build() {
    Shape() {
      Path({
        commands: this.d,
      })
      // .backgroundColor('#eeeeee')
      // .width('400px')
      // .height('400px')
      // .width('100%')
      // .height('100%')
      Column() {
        this.childrenBuilder()
        //         ForEach(this.descriptor.childrenTags, (tag: Tag) => {
        //           Column() {
        //             RNComponentFactory({ ctx: this.ctx, tag: tag, buildCustomComponent: this.buildCustomComponent })
        //           }
        //         }, (tag: Tag) => tag.toString())
        // Text(`${this.translateZ}`).align(Alignment.Center)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .key(this.svgKey)
    .viewPort(this.computedViewBoxParam())
    .fill(this.fill)
    .strokeWidth(this.strokeWidth)
    .strokeMiterLimit(this.strokeMiter)
    .strokeLineCap(this.strokeCap)
    .strokeLineJoin(this.strokeJoin)
    .zIndex(this.translateZ)
    .translate({
      x: this.computedTranslateValue(this.transX),
      y: this.computedTranslateValue(this.transY),
      z: 0
    })
    .rotate(this.computedRotateValue())
    // .clip(this.computedClipParams())

    // .fill(this.descriptor.props.fill)
    // .strokeWidth(this.descriptor.props.strokeWidth)
    // .strokeMiterLimit(this.descriptor.props.strokeMiter)
    // .strokeLineCap(this.descriptor.props.strokeCap)
    // .strokeLineJoin(this.descriptor.props.strokeJoin)
    .clip(this.computedClipParams())
  }

  // build() {
  //     Shape() {
  //       Path({
  //         commands: this.descriptor.props.d
  //       })
  //       Column() {
  //         this.childrenBuilder()
  //         ForEach(this.descriptor.childrenTags, (tag: Tag) => {
  //           Column() {
  //             RNComponentFactory({ ctx: this.ctx, tag: tag, buildCustomComponent: this.buildCustomComponent })
  //           }
  //         }, (tag: Tag) => tag.toString())
  //       }
  //       .alignItems(HorizontalAlign.Start)
  //     }
  //     .viewPort(this.computedViewBoxParam())
  //     .fill(this.descriptor.props.fill)
  //     .strokeWidth(this.descriptor.props.strokeWidth)
  //     .strokeMiterLimit(this.descriptor.props.strokeMiter)
  //     .strokeLineCap(this.descriptor.props.strokeCap)
  //     .strokeLineJoin(this.descriptor.props.strokeJoin)
  //     .clip(this.computedClipParams())
  //   }
  //   .padding({
  //     // top: 100,
  //     // top: 400
  //   })
  //   .width('100%')
  //   .borderWidth(5)
  //   .borderColor(Color.Pink)
  // }
}

export default ClipPath