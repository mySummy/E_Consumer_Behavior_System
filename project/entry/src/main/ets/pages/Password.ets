import router from '@ohos.router';
import Prompt from '@system.prompt';
@Entry
@Component
struct Password {
  @State username: string = router.getParams()['username']
  @State pwd1:string = ''
  @State pwd2:string = ''
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
        Text('密码请设置为6-16位数')
          .textAlign(TextAlign.Start)
          .fontColor(Color.Gray)
          .fontSize(16)
          .margin({
            top:'30vp',
            left:'30vp'
          })
          .width('100%')
        TextInput({ placeholder: ('请输入密码') })
          .type(InputType.Password)
          .margin({
            top:'50vp'
          })
          .onChange(val=>{
            this.pwd1 = val
            console.log(val)
          })
          .width('95%')
        TextInput({ placeholder: ('再次输入密码') })
          .type(InputType.Password)
          .margin({
            top:'20vp'
          })
          .onChange(val=>{
            this.pwd2 = val
            console.log(val)
          })
          .width('95%')


        Button('确认注册')
          .width(300)
          .height(40)
          .margin({
            top:'100vp'
          })
          .backgroundColor(Color.Green)
          .onClick(()=>{

            if(this.pwd1.length < 6 || this.pwd1.length > 16){
              Prompt.showDialog({
                message: "请输入正确格式的密码",
              });
            }
            else if (this.pwd1 != this.pwd2) {
              Prompt.showDialog({
                message: "两次密码不一致",
              });

            }
            else{

            }
          })


      }
      .width('100%')

    }
    .height('70%')
  }
}