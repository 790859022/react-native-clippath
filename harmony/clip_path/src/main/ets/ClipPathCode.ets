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
  @Prop rotO: number = 0
  @Prop rotOx: number = 0
  @Prop rotOy: number = 0
  @Prop rotPercentageValue: boolean = false
  @Prop sc: number = 1
  @Prop scX: number = 1
  @Prop scY: number = 1
  @Prop scO: number = 0
  @Prop scOx: number = 0
  @Prop scOy: number = 0
  @Prop scPercentageValue: boolean = false
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

  computedTranslateValue() {
    const transX = this.transX
    const transY = this.transY
    const transPercentageValue = this.transPercentageValue
    let val: TranslateOptions = {
      x: `${transX || 0}px`,
      y: `${transY || 0}px`,
      z: 0
    }
    if (transPercentageValue) {
      val.x = `${transX}%`
      val.y = `${transY}%`
    }
    return val
  }

  computedRotateValue(): RotateOptions {
    const rot = this.rot
    const rotO = this.rotO
    const rotOx = this.rotOx
    const rotOy = this.rotOy
    const rotPercentageValue = this.rotPercentageValue
    let val = {
      angle: rot
    } as RotateOptions

    if(rotOx || (rotOx === 0)){
      val.centerX = `${rotOx || 0}px`
    }
    if(rotOy || (rotOy === 0)){
      val.centerY = `${rotOy || 0}px`
    }

    if (rotO && rotPercentageValue) {
      val.centerX = `${rotO}%`
      val.centerY = `${rotO}%`
    } else if (rotO || (rot === 0)) {
      val.centerX = `${rotO}px`
      val.centerY = `${rotO}px`
    } else if (rotPercentageValue) {
      val.centerX = `${rotOx}%`
      val.centerY = `${rotOy}%`
    }

    const scaleConfig = this.computedScaleValue();
    if(rotO === 0 && rotOx === 0){
      val.centerX = scaleConfig.centerX || 0;
    }
    if(rotO === 0 && rotOy === 0) {
      val.centerY = scaleConfig.centerY || 0;
    }
    console.log(`FG rotate ${JSON.stringify(val)}`)
    return val
  }

  computedScaleValue(): RotateOptions {
    const sc = this.sc
    const scX = this.scX
    const scY = this.scY
    const scO = this.scO
    const scOx = this.scOx
    const scOy = this.scOy
    const scPercentageValue = this.scPercentageValue
    let val = {
      x: scX || 1,
      y: scY || 1,
      z: 1
    } as RotateOptions

    if(scOx || (scOx === 0)){
      val.centerX = `${scOx || 0}px`
    }
    if(scOy || (scOy === 0)){
      val.centerY = `${scOy || 0}px`
    }

    if (sc) {
      val.x = sc
      val.y = sc
    }

    if (scO && scPercentageValue) {
      val.centerX = `${scO}%`
      val.centerY = `${scO}%`
    } else if (scO || (scO === 0)) {
      val.centerX = `${scO}px`
      val.centerY = `${scO}px`
    } else if (scPercentageValue) {
      val.centerX = `${scOx}%`
      val.centerY = `${scOy}%`
    }

    console.log(`FG scale ${JSON.stringify(val)}`)
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
    .translate(this.computedTranslateValue())
    .scale(this.computedScaleValue())
    .rotate(this.computedRotateValue())
    .clip(this.computedClipParams())
    // .fill(this.fill)
    // .strokeWidth(this.strokeWidth)
    // .strokeMiterLimit(this.strokeMiter)
    // .strokeLineCap(this.strokeCap)
    // .strokeLineJoin(this.strokeJoin)
    // .clip(this.computedClipParams())
  }

  // build() {
  //     Shape() {
  //       Path({
  //         commands: this.d
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
  //     .fill(this.fill)
  //     .strokeWidth(this.strokeWidth)
  //     .strokeMiterLimit(this.strokeMiter)
  //     .strokeLineCap(this.strokeCap)
  //     .strokeLineJoin(this.strokeJoin)
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