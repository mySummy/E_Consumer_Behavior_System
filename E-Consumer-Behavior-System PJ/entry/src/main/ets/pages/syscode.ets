import router from '@ohos.router';
@Entry
@Component

struct Syscode {
  @State params: any = router.getParams()
  @State Codes:string = '点击发送验证码'
  @State code:string = ''
  startCountdown() {
    let countdown = 60;
    const intervalId = setInterval(() => {
      countdown -= 1;
      this.Codes = countdown + ' 秒后可重新发送';
      if (countdown <= 0) {
        this.Codes = '点击发送验证码';
        clearInterval(intervalId);
      }
    }, 1000);
  }
  build(){
    Row(){
      Column(){
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
          .type(InputType.Number)
          .onChange(val=>{
            this.code = val
            console.log(val)
          })
          .margin({
            top:'50vp'
          })
          .width('80%')
        Text(this.Codes)
          .fontColor(Color.Green)
          .textAlign(TextAlign.Start)
          .onClick(()=>{
              if (this.Codes === '点击发送验证码') {
                this.startCountdown()
              }
          })
          .margin({
            top:'40vp',
            left:'30vp'
          })
          .width('90%')
        Button('注册')
          .width(300)
          .height(40)
          .onClick(()=>{
            router.pushUrl({
              url:'pages/Password',
              params:{id : 1}
            },
              router.RouterMode.Single,
              err=>{
                if(err){
                  console.log('路由失败.')
                }
              }
            )
          })
          .margin({
            top:'50vp'
          })
          .backgroundColor(Color.Green)

      }
    }
  }
}
