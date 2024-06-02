import router from '@ohos.router';
import Prompt from '@system.prompt';
@Entry
@Component
struct Register {
  @State params: any = router.getParams()
  @State allow: Boolean = false
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
          Text('注册账户')
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
          Button('同意协议并注册')
            .width(300)
            .height(40)
            .onClick(()=>{
              if (this.username==='') {
                console.log(this.username);
                Prompt.showDialog({
                  message: "请输入手机号",
                });
              }
              else if(this.username.length!=11){
                console.log(this.username);
                Prompt.showDialog({
                  message: "请输入正确的手机号",
                });
              }
              else{
                router.pushUrl({
                url:'pages/syscode',
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
          Row(){
            Text('点击注册则代表已阅读并同意')
              .fontColor(Color.Gray)
              .fontSize(12)
              .margin({
                top:'30vp',
                left:'20vp'
              })
            Text('《电力用户分析软件服务协议》')
              .fontColor(Color.Green)
              .fontSize(12)
              .margin({
                top:'30vp',
                left:'5vp'
              })
          }
        }
      }
  }
}