import { Descriptor, ComponentBuilderContext, ViewBaseProps, Tag } from 'rnoh';
import { RNComponentFactory, RNOHContext, RNViewBase } from 'rnoh'
import { TViewBox, IViewPort, TChildrenBuilder } from './types'

// import ShowList from './ShowList'

export const CLIP_PATH_TYPE: string = "ClipPath"

export interface ClipPathProps extends ViewBaseProps {
  color?: string;
  openClip?: boolean;
  fill?: string;

  svgKey?: string;
  d?: string;
  viewBox?: TViewBox;

  strokeWidth?: number;
  strokeCap?: LineCapStyle;
  strokeJoin?: LineJoinStyle;
  strokeMiter?: number;
  strokeStart?: number;
  strokeEnd?: number;
  translateZ?: number;
  transX?: number;
  transY?: number;
  transPercentageValue?: boolean;
  rot?: number;
  rotO?: number;
  rotOx?: number;
  rotOy?: number;
  rotPercentageValue?: boolean;
  sc?: number;
  scX?: number;
  scY?: number;
  scO?: number;
  scOx?: number;
  scOy?: number;
  scPercentageValue?: boolean;
}

export type ClipPathDescriptor = Descriptor<"ClipPath", ClipPathProps>

@Component
export struct ClipPath {
  ctx!: RNOHContext
  tag: number = 0
  @State descriptor: ClipPathDescriptor = {} as ClipPathDescriptor
  @BuilderParam buildCustomComponent: (componentBuilderContext: ComponentBuilderContext) => void
  @BuilderParam childrenBuilder: TChildrenBuilder = this.defaultChildrenBuilder
  private unregisterDescriptorChangesListener?: () => void = undefined
  @State propertyArr: Array<string> = [];

  aboutToAppear() {
    this.descriptor = this.ctx.descriptorRegistry.getDescriptor<ClipPathDescriptor>(this.tag)
    this.unregisterDescriptorChangesListener = this.ctx.descriptorRegistry.subscribeToDescriptorChanges(this.tag,
      (newDescriptor) => {
        this.descriptor = (newDescriptor as ClipPathDescriptor)
      }
    )
    console.log(`FG ${JSON.stringify(this.descriptor.props)}`)
    this.propertyArr = Object.entries(this.descriptor.props).map((item: Array<string>) => `${item[0]}: ${item[1]}`)
    console.log(`FG ${this.propertyArr}`)
  }

  aboutToDisappear() {
    this.unregisterDescriptorChangesListener?.()
  }

  computedClipParams(): PathAttribute | boolean {
    const openClip = this.descriptor.props.openClip
    const d = this.descriptor.props.d
    return openClip ? new Path({ commands: d }) : false
  }

  computedViewBoxParam(): IViewPort {
    const viewBox = this.descriptor.props.viewBox
    if (viewBox?.length !== 4) return {}
    return {
      x: viewBox[0] + 'px',
      y: viewBox[1] + 'px',
      width: viewBox[2] + 'px',
      height: viewBox[3] + 'px'
    }
  }

  computedTranslateValue() {
    const transX = this.descriptor.props.transX
    const transY = this.descriptor.props.transY
    const transPercentageValue = this.descriptor.props.transPercentageValue
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
    const rot = this.descriptor.props.rot
    const rotO = this.descriptor.props.rotO
    const rotOx = this.descriptor.props.rotOx
    const rotOy = this.descriptor.props.rotOy
    const rotPercentageValue = this.descriptor.props.rotPercentageValue
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
    const sc = this.descriptor.props.sc
    const scX = this.descriptor.props.scX
    const scY = this.descriptor.props.scY
    const scO = this.descriptor.props.scO
    const scOx = this.descriptor.props.scOx
    const scOy = this.descriptor.props.scOy
    const scPercentageValue = this.descriptor.props.scPercentageValue
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
        commands: this.descriptor.props.d
      })
      Column() {
        this.childrenBuilder()
        ForEach(this.descriptor.childrenTags, (tag: Tag) => {
          Column() {
            RNComponentFactory({ ctx: this.ctx, tag: tag, buildCustomComponent: this.buildCustomComponent })
          }
        }, (tag: Tag) => tag.toString())
      }
      .alignItems(HorizontalAlign.Start)
    }
    .key(this.descriptor.props.svgKey)
    .viewPort(this.computedViewBoxParam())
    .fill(this.descriptor.props.fill)
    .strokeWidth(this.descriptor.props.strokeWidth)
    .strokeMiterLimit(this.descriptor.props.strokeMiter)
    .strokeLineCap(this.descriptor.props.strokeCap)
    .strokeLineJoin(this.descriptor.props.strokeJoin)
    .zIndex(this.descriptor.props.translateZ)
    .translate(this.computedTranslateValue())
    .scale(this.computedScaleValue())
    .rotate(this.computedRotateValue())
    .clip(this.computedClipParams())
    .clip(this.computedClipParams())
  }

  //   build() {
  //     Column(){
  //       Text('Clip Path Test 1')
  //         .backgroundColor(this.descriptor.props.color)
  //         .fontSize(30)
  //         .textAlign(TextAlign.Center)
  //       Text('Clip Path Test 2')
  //         .fontColor(this.descriptor.props.color)
  //         .fontSize(30)
  //         .textAlign(TextAlign.Center)
  //     }
  //     .padding({
  //       top: 400
  //     })
  //     .width('100%')
  //     .borderWidth(5)
  //     .borderColor(Color.Pink)
  //
  //     // RNViewBase({ ctx: this.ctx, tag: this.tag }) {
  //     //   Text('Clip Path Test')
  //     //     .backgroundColor(this.descriptor.props.color)
  //     //     .fontColor("red")
  //     //     .fontSize(12)
  //     //     .textAlign(TextAlign.Center)
  //     //     .width("100%")
  //     //     .height("100%")
  //     // }
  //   }
}
