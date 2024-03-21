import { Descriptor, ComponentBuilderContext, ViewBaseProps, Tag } from 'rnoh';
import { RNComponentFactory, RNOHContext, RNViewBase } from 'rnoh'
import { TViewBox, IViewPort, TChildrenBuilder } from './types'

// import ShowList from './ShowList'

export const CLIP_PATH_TYPE: string = "ClipPath"

export interface ClipPathProps extends ViewBaseProps {
  color?: string;
  openClip?: boolean;
  d?: string;
  viewBox?: TViewBox;
  fill?: string;
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
    // const viewBox = [0, 0, '400px', '400px']
    if (viewBox?.length !== 4) return {}
    return {
      x: viewBox[0] + 'px',
      y: viewBox[1] + 'px',
      width: viewBox[2] + 'px',
      height: viewBox[3] + 'px'
    }
  }

  @Builder
  defaultChildrenBuilder() {
  };

  build() {
    Column() {
      Text('Clip Path Code')
      // ShowList({
      //   listData: this.propertyArr
      // })
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
      .viewPort(this.computedViewBoxParam())
      .fill(this.descriptor.props.fill)
      .strokeWidth(this.descriptor.props.strokeWidth)
      .strokeMiterLimit(this.descriptor.props.strokeMiter)
      .strokeLineCap(this.descriptor.props.strokeCap)
      .strokeLineJoin(this.descriptor.props.strokeJoin)

      .clip(this.computedClipParams())
    }
    .padding({
      // top: 100,
      // top: 400
    })
    .width('100%')
    .borderWidth(5)
    .borderColor(Color.Pink)
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
