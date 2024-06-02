import router from '@ohos.router';

@Entry
@Component
struct Page2 {
  build() {
    Row() {
      Column() {
        Text('< 返回')
          .textAlign(TextAlign.Start)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
          .margin({
            top:'40vp',
            left:'30vp'
          })
          .onClick(()=>{
            router.back()
          })
          .width('100%')

        Image($r('app.media.app_icon'))
          .width(100)
          .height(100)
          .margin({
            top:'100vp',
            bottom:'9vp'
          })

        Text('使用前请登录')
          .fontColor(Color.Gray)
          .fontSize(24)
          .margin({
            top: '100vp'
          })

        Button('登录')
          .width(300)
          .height(40)
          .onClick(()=>{
            router.pushUrl({
              url:'pages/logon'
            },router.RouterMode.Single,
              err => {
                if(err){
                  console.log('路由失败')
                }
              }
            )
          })
          .margin({top:100})

      }
      .width('100%')
    }
    .height('50%')
  }
}

