@Entry
@Component
struct Index {
  build(){
    Row(){
      Column(){
        Text('< 返回')
          .textAlign(TextAlign.Start)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
          .margin({
            top:'30vp',
            left:'30vp'
          })
          .width('100%')
        Text('请输入验证码')
          .textAlign(TextAlign.Start)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .margin({
            top:'120vp',
            left:'30vp'
          })
          .width('100%')
        Text('验证码已发送至 phone')
          .textAlign(TextAlign.Start)
          .fontColor(Color.Gray)
          .fontSize(18)
          .margin({
            top:'30vp',
            left:'50vp'
          })
          .width('100%')
        TextInput({ placeholder: ('验证码') })
          .type(InputType.PhoneNumber)
          .margin({
            top:'100vp'
          })
          .width('80%')
        Button('注册')
          .width(300)
          .height(40)
          .margin({
            top:'50vp'
          })
          .backgroundColor(Color.Green)

      }
    }
  }
}