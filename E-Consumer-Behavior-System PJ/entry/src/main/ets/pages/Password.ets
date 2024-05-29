import router from '@ohos.router';
@Entry
@Component
struct Password {
  @State params: any = router.getParams()
  build() {
    Row() {
      Column() {
        Text('< 返回')
          .textAlign(TextAlign.Start)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
          .onClick(()=>{
            router.back()
          })
          .margin({
            top:'40vp',
            left:'30vp'
          })
          .width('100%')
        Text('设置密码')
          .textAlign(TextAlign.Start)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .margin({
            top:'120vp',
            left:'30vp'
          })
          .width('100%')
        Text('设置密码用于登录')
          .textAlign(TextAlign.Start)
          .fontColor(Color.Gray)
          .fontSize(18)
          .margin({
            top:'30vp',
            left:'30vp'
          })
          .width('100%')
        TextInput({ placeholder: ('请输入密码') })
          .type(InputType.Password)
          .margin({
            top:'80vp'
          })
          .width('95%')
        TextInput({ placeholder: ('再次输入密码') })
          .type(InputType.Password)
          .margin({
            top:'20vp'
          })
          .width('95%')


        Button('确认注册')
          .width(300)
          .height(40)
          .margin({
            top:'100vp'
          })
          .backgroundColor(Color.Green)


      }
      .width('100%')

    }
    .height('70%')
  }
}