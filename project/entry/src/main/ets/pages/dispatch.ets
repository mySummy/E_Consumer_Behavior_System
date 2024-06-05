import router from '@ohos.router';

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
            router.back({url:"pages/Index"})
          })
          .margin({
            top:'40vp',
            left:'10vp'
          })
      }
      .width('100%')
      Column(){
        Row(){

      }.margin({top:300})
    }
    .height('100%')
  }
}
}