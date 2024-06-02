import router from '@ohos.router';
@Entry
@Component
struct Page_18 {
  @State message: string = 'Hello World'

  build() {
    Column() {
      Row(){
        Text('< 返回')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .onClick(()=>{
            router.back()
          })
      }
      .width('100%')
      Column(){
        Button('上传文件')
          .fontColor(Color.Black)
          .type(ButtonType.Normal)
          .width('125')
          .height('30')
          .borderRadius(10)
          .backgroundColor(Color.White)
          .borderWidth(1)
          .borderColor(Color.Black)
        Text('请上传xls/xlsx文件，大小在60M以内')
          .fontColor(Color.Gray)
          .fontSize(15)
      }.margin({top:300})
    }
    .height('100%')
  }
}