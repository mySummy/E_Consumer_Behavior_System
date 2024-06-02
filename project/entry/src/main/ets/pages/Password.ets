import router from '@ohos.router';
import Prompt from '@system.prompt';
import http from '@ohos.net.http';
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
              const httpRequest = http.createHttp();
              httpRequest.request(
                'http://localhost:3000/register', // URL should be a string
                {
                  method: http.RequestMethod.POST, // 使用正确的枚举类型
                  header: { 'Content-Type': 'application/json' },
                  extraData: JSON.stringify({
                    username: this.username,
                    password: this.pwd1
                  }),
                  readTimeout: 60000, // 超时时间
                  connectTimeout: 60000 // 超时时间
                }
              ).then((data) => {
                const response = JSON.parse(data.result as string); // 确保 result 是字符串类型
                if (data.responseCode === 201 && response.message === 'User registered successfully') {
                  // 注册成功，进行相应的操作
                  console.log('注册成功');
                  router.back({url:'pages/logon'})
                } else {
                  // 注册失败，显示错误信息
                  Prompt.showDialog({
                    message: '注册失败: ' + response.message,
                  });
                }
              }).catch((err) => {
                // 网络错误或其他错误
                Prompt.showDialog({
                  message: '网络错误: ' + err,
                });
              });
            }
          })


      }
      .width('100%')

    }
    .height('70%')
  }
}