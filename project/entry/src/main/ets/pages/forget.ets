import router from '@ohos.router';
import Prompt from '@system.prompt';
import http from '@ohos.net.http';

@Entry
@Component
struct Forget {
  @State params: any = router.getParams()
  @State username: string = ''

  build() {
    Row() {
      Column() {
        Text('< 返回')
          .textAlign(TextAlign.Start)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
          .onClick(() => {
            router.back()
          })
          .margin({
            top: '40vp',
            left: '30vp'
          })
          .width('100%')
        Text('忘记密码')
          .textAlign(TextAlign.Start)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .margin({
            top: '120vp',
            left: '30vp'
          })
          .width('100%')
        Text('请输入账号')
          .textAlign(TextAlign.Start)
          .fontColor(Color.Gray)
          .fontSize(18)
          .margin({
            top: '30vp',
            left: '50vp'
          })
          .width('100%')
        TextInput({ placeholder: ('账号') })
          .type(InputType.PhoneNumber)
          .margin({
            top: '60vp'
          })
          .onChange(val => {
            this.username = val
            console.log(val)
          })
          .width('80%')
        Button('验证账号')
          .width(300)
          .height(40)
          .onClick(() => {
            if (this.username === '') {
              console.log(this.username);
              Prompt.showDialog({
                message: "请输入账号",
              });
            } else {
              // 向服务器发送请求验证账号
              const httpRequest = http.createHttp();
              httpRequest.request(
                'http://localhost:3000/check-username',
                {
                  method: http.RequestMethod.POST,
                  header: { 'Content-Type': 'application/json' },
                  extraData: JSON.stringify({ username: this.username }),
                  readTimeout: 60000,
                  connectTimeout: 60000
                }
              ).then((data) => {
                const response = JSON.parse(data.result as string);
                if (data.responseCode === 200 && response.exists) {
                  // 用户名验证成功，跳转到Password页面
                  router.pushUrl({
                    url: 'pages/Password',
                    params: { username: this.username, mode: 0 }
                  }, router.RouterMode.Single, err => {
                    if (err) {
                      console.log('路由失败.');
                    }
                  });
                } else {
                  // 用户名验证失败，显示错误信息
                  Prompt.showDialog({
                    message: '用户名不存在',
                  });
                }
              }).catch((err) => {
                Prompt.showDialog({
                  message: '网络错误: ' + err,
                });
              });
            }
          })
          .margin({
            top: '80vp'
          })
          .backgroundColor(Color.Green)
      }
      .width('100%')
    }
    .height('60%')
  }
}
