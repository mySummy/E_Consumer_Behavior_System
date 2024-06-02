import router from '@ohos.router';
@Entry
@Component
struct Page_13 {
  @State message: string = 'Hello World'

  build() {
      Column() {
        Row(){
          Text('<返回')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .onClick(()=>{
              router.back()
            })
        }.justifyContent(FlexAlign.Start)
        .width('100%')
        Row(){
          Text('全部数据')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
        }.margin({right:100})
        Row(){
          Column(){
            Text('平均缴费金额')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
            Text('114RMB')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Yellow)}
          Button('所有用户类型')
            .type(ButtonType.Normal)
            .width(125)
            .height(100)
            .borderRadius(10)
            .backgroundColor(Color.Green)
        }.justifyContent(FlexAlign.SpaceAround)
        .width('100%')
        Row(){
          Column(){
            Text('平均缴费次数')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
            Text('514')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Yellow)}
          Button('预测高价值TOP5')
            .type(ButtonType.Normal)
            .width(125)
            .height(100)
            .borderRadius(10)
            .backgroundColor(Color.Red)
        }.justifyContent(FlexAlign.SpaceAround)
        .width('100%')
        Button('重新上传')
          .type(ButtonType.Normal)
          .width(300)
          .height(50)
          .borderRadius(10)
          .backgroundColor(Color.Blue)
          .margin({top:20})
      }
      .width('100%')
      .height('100%')
  }
}