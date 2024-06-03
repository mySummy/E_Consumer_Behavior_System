import router from '@ohos.router';
import Prompt from '@system.prompt';
import http from '@ohos.net.http';

@Entry
@Component
struct Password {
  @State username: string = router.getParams()['username']
  @State mode: number = router.getParams()['mode']
  @State pwd1: string = ''
  @State pwd2: string = ''

  build() {
    Row() {
      Column() {
        Text('< 返回')
          .textAlign(TextAlign.Start)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
          .onClick(() => {
            router.showAlertBeforeBackPage({
              message: '确定要返回吗？'
            })
            router.back({ url: 'pages/logon' })
          })
          .margin({
            top: '40vp',
            left: '30vp'
          })
          .width('100%')
        Text('设置密码')
          .textAlign(TextAlign.Start)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .margin({
            top: '120vp',
            left: '30vp'
          })
          .width('100%')
        Text('设置密码用于登录')
          .textAlign(TextAlign.Start)
          .fontColor(Color.Gray)
          .fontSize(18)
          .margin({
            top: '30vp',
            left: '30vp'
          })
          .width('100%')

        TextInput({ placeholder: ('请输入密码') })
          .type(InputType.Password)
          .margin({
            top: '50vp'
          })
          .onChange(val => {
            this.pwd1 = val
            console.log(val)
          })
          .width('95%')
        TextInput({ placeholder: ('再次输入密码') })
          .type(InputType.Password)
          .margin({
            top: '20vp'
          })
          .onChange(val => {
            this.pwd2 = val
            console.log(val)
          })
          .width('95%')
        Button(this.mode === 1 ? '确认注册' : '确认重置密码')
          .width(300)
          .height(40)
          .margin({
            top: '100vp'
          })
          .backgroundColor(Color.Green)
          .onClick(() => {
            if (this.pwd1 != this.pwd2) {
              Prompt.showDialog({
                message: "两次密码不一致",
              });
            } else if (this.mode === 1) {
              const httpRequest = http.createHttp();
              httpRequest.request(
                'http://localhost:3000/register',
                {
                  method: http.RequestMethod.POST,
                  header: { 'Content-Type': 'application/json' },
                  extraData: JSON.stringify({
                    username: this.username,
                    password: this.pwd1
                  }),
                  readTimeout: 60000,
                  connectTimeout: 60000
                }
              ).then((data) => {
                console.log('Response data:', data.result);
                try {
                  const response = JSON.parse(data.result.toString());
                  if (data.responseCode === 201 && response.message === 'User registered successfully') {
                    console.log('注册成功');
                    router.back({ url: 'pages/logon' })
                  } else {
                    Prompt.showDialog({
                      message: '注册失败: ' + response.message,
                    });
                  }
                } catch (e) {
                  console.error('JSON parsing error:', e, 'Response data:', data.result);
                  Prompt.showDialog({
                    message: 'JSON解析错误: ' + e.message,
                  });
                }
              }).catch((err) => {
                Prompt.showDialog({
                  message: '网络错误: ' + err,
                });
              });
            } else {
              const httpRequest = http.createHttp();
              httpRequest.request(
                'http://localhost:3000/forget',
                {
                  method: http.RequestMethod.POST,
                  header: { 'Content-Type': 'application/json' },
                  extraData: JSON.stringify({
                    username: this.username,
                    newPassword: this.pwd1
                  }),
                  readTimeout: 60000,
                  connectTimeout: 60000
                }
              ).then((data) => {
                console.log('Response data:', data.result);
                try {
                  const response = JSON.parse(data.result.toString());
                  if (data.responseCode === 200 && response.message === 'Password reset successfully') {
                    console.log('重置密码成功');
                    router.back({ url: 'pages/logon' })
                  } else {
                    Prompt.showDialog({
                      message: '重置密码失败: ' + response.message,
                    });
                  }
                } catch (e) {
                  console.error('JSON parsing error:', e, 'Response data:', data.result);
                  Prompt.showDialog({
                    message: 'JSON解析错误: ' + e.message,
                  });
                }
              }).catch((err) => {
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
