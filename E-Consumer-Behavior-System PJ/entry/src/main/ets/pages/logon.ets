import router from '@ohos.router';
@Entry
@Component
struct Logon {
  @State message: string = 'Hello World'

  build() {
    Row() {
      Column() {
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

        Image($r('app.media.app_icon'))
          .width(100)
          .height(100)
          .margin({
            top:'70vp',
            bottom:'9vp'
          })
        Text('登陆界面')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin(10)
        Text('欢迎使用 电力客户分析')
          .fontSize(16)
          .fontColor(Color.Gray)
        TextInput({ placeholder: ('手机号') })
          .type(InputType.PhoneNumber)
          .margin({
            top:'30vp'
          })
          .width('95%')
        TextInput({ placeholder: ('输入密码') })
          .type(InputType.Password)
          .margin({
            top:'20vp'
          })
          .width('95%')
        Row({space : 180}){
          Text('忘记密码')
            .fontSize(16)
            .fontColor(Color.Gray)
            .onClick(()=>{
              router.pushUrl({
                url:'pages/forget',
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
              top:'30vp'
            })
          Text('注册账号')
            .fontSize(16)
            .fontColor(Color.Green)
            .onClick(()=>{
              router.pushUrl({
                url:'pages/register',
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
              top:'30vp'
            })
        }

        Button('登录')
          .width(300)
          .height(40)
          .margin({
            top:'100vp'
          })
          .backgroundColor(Color.Green)


      }
      .width('100%')
    }
    .height('80%')
  }
}