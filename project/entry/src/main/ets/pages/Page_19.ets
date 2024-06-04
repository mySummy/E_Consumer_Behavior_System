import router from '@ohos.router';
import picker from '@ohos.file.picker';

@Entry
@Component
struct Page_19 {
  @State message: string = '任务5 上传'
  onLoadComplete() {
    // 跳转到另一个页面
    router.pushUrl({
      url: 'pages/userTabs'
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
      }
      .width('100%')
      Column(){
        Row(){
          Button('文件1')
            .fontColor(Color.Black)
            .type(ButtonType.Normal)
            .width('60')
            .height('40')
            .borderRadius(5)
            .backgroundColor(Color.White)
            .borderWidth(1)
            .borderColor(Color.Black)
            .onClick(()=>{
              router.pushUrl({
                url: 'pages/Page_13',
                params: { id: 1 }})
            })
          Button('文件2')
            .fontColor(Color.Black)
            .type(ButtonType.Normal)
            .width('60')
            .height('40')
            .borderRadius(5)
            .backgroundColor(Color.White)
            .borderWidth(1)
            .borderColor(Color.Black)
            .onClick(()=>{
              router.pushUrl({
                url: 'pages/Page_13',
                params: { id: 1 }})
            })
          Button('文件3')
            .fontColor(Color.Black)
            .type(ButtonType.Normal)
            .width('60')
            .height('40')
            .borderRadius(5)
            .backgroundColor(Color.White)
            .borderWidth(1)
            .borderColor(Color.Black)
            .onClick(()=>{
              router.pushUrl({
                url: 'pages/Page_13',
                params: { id: 1 }})
            })
          Button('文件4')
            .fontColor(Color.Black)
            .type(ButtonType.Normal)
            .width('60')
            .height('40')
            .borderRadius(5)
            .backgroundColor(Color.White)
            .borderWidth(1)
            .borderColor(Color.Black)
            .onClick(()=>{
              router.pushUrl({
                url: 'pages/Page_13',
                params: { id: 1 }})
            })
        }
        Text('请上传xls/xlsx文件，大小在60M以内')
          .fontColor(Color.Gray)
          .fontSize(15)
          .margin({top:30})
      }.margin({top:300})
    }
    .height('100%')
  }
}