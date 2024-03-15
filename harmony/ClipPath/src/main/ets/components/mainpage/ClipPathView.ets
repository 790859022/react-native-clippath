import { TViewBox, IViewPort, TChildrenBuilder } from './types'

@Component
struct ClipPathView {
  @Prop openClip: boolean = true
  @Prop viewBox: TViewBox = []
  @Prop d: string = ''
  @Prop fill: ResourceColor = Color.Black
  @Prop strokeWidth: string | number = 0

  // @State clipParams: PathAttribute | boolean = new Path({ commands: this.d })
  // @State viewPort: IViewPort = {}
  @BuilderParam childrenBuilder: TChildrenBuilder = this.defaultChildrenBuilder

  computedClipParams(): PathAttribute | boolean {
    return this.openClip ? new Path({ commands: this.d }) : false
  }

  computedViewBoxParam(): IViewPort{
    const viewBox = this.viewBox
    if(viewBox.length !== 4) return {}
    return {
      x: viewBox[0],
      y: viewBox[1],
      width: viewBox[2],
      height: viewBox[3]
    }
  }

  @Builder
  defaultChildrenBuilder() {};

  build() {
      Shape() {
        Path({
          commands: this.d
        })
        Column() {
          // Text(`${JSON.stringify(this.computedViewBoxParam())}`)
          //   .fontSize('16px')
          //   .fontColor(Color.Black)
          this.childrenBuilder()
        }
        .alignItems(HorizontalAlign.Start)
      }
      .viewPort(this.computedViewBoxParam())
      .fill(this.fill)
      .strokeWidth(this.strokeWidth)
      .clip(this.computedClipParams())
    }
}

export default ClipPathView