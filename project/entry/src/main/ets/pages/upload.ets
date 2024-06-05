import router from '@ohos.router';
@Entry
@Component
struct Page {
  @State money: number = 0.0;
  @State frequency: number = 0.0;
  @State message: string = '分析-上传'
  @State mode: number = router.getParams()['mode']
  onLoadComplete() {
    // 跳转到另一个页面
      router.pushUrl({
        url: 'pages/Selection',
        params:{mode:this.mode}
      }, router.RouterMode.Single,
        err => {
          if (err) {
            console.log('路由失败');
          }
        }
      )
  }

  build() {
      Column() {
        Row(){
          Text('< 返回')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .onClick(()=>{
            router.back()
          })
          .margin({
            top:'40vp',
            left:'10vp'
          })
        }.justifyContent(FlexAlign.Start)
        .width('100%')
        Column(){
          Button('选择文件')
            .fontSize(16)
            .margin({top:30})
            .backgroundColor(Color.Gray)
            .onClick(()=>{
              this.onLoadComplete()
            })
          Text('请选择csv/xlsx文件')
            .fontColor(Color.Gray)
            .fontSize(15)
            .margin({top:30})
        }.margin({top:220})

      }
      .width('100%')
      .height('100%')
  }
}