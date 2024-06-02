import router from '@ohos.router';
import Prompt from '@system.prompt';
@Entry
@Component
struct Forget {
  @State params: any = router.getParams()
  @State username: string =''
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
        Text('忘记密码')
          .textAlign(TextAlign.Start)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .margin({
            top:'120vp',
            left:'30vp'
          })
          .width('100%')
        Text('请输入手机号')
          .textAlign(TextAlign.Start)
          .fontColor(Color.Gray)
          .fontSize(18)
          .margin({
            top:'30vp',
            left:'50vp'
          })
          .width('100%')
        TextInput({ placeholder: ('手机号') })
          .type(InputType.PhoneNumber)
          .margin({
            top:'60vp'
          })
          .onChange(val=>{
            this.username = val
            console.log(val)
          })
          .width('80%')
        Button('验证手机号')
          .width(300)
          .height(40)
          .onClick(()=>{
            if (this.username==='') {
              console.log(this.username);
              Prompt.showDialog({
                message: "请输入手机号",
              });
            }
            else{
              router.pushUrl({
                url:'pages/Password',
                params:{username:this.username}
              },
                router.RouterMode.Single,
                err=>{
                  if(err){
                    console.log('路由失败.')
                  }
                }
              )
            }
          })
          .margin({
            top:'80vp'
          })
          .backgroundColor(Color.Green)
      }
      .width('100%')
    }
    .height('60%')
  }
}