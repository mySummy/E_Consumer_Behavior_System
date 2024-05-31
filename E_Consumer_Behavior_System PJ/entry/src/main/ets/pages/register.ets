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
              if (!this.allow) {
                Prompt.showDialog({
                  message: "请勾选允许登录选项",
                });
              }
              else{
                router.pushUrl({
                url:'pages/syscode',
                params:{id : 1}
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
            Checkbox({name:'agreement'})
              .selectedColor(Color.Green)
              .onChange(val => {
                this.allow = val;
                console.log('agreement change is ' + val);
                console.log('this is ' + this);
                console.log('allow is ' + this.allow);
              })
              .margin({
                top:'30vp'
              })
            Text('我已阅读并同意')
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