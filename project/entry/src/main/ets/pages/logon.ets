import router from '@ohos.router';
import Prompt from '@system.prompt';
import http from '@ohos.net.http';

@Entry
@Component
struct Logon {
  @State username: string = ''
  @State pwd: string = ''
  build() {
    Row() {
      Column() {
        Text('< 返回')
          .textAlign(TextAlign.Start)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
          .onClick(()=>{
            router.back({url:'pages/Indexbeforelogin'})
          })
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
        TextInput({ placeholder:('输入账号')})
          .type(InputType.PhoneNumber)
          .margin({
            top:'30vp'
          })
          .onChange(val=>{
            this.username = val
            console.log(val)
          })
          .width('95%')
        TextInput({placeholder: ('输入密码') })
          .type(InputType.Password)
          .margin({
            top:'20vp'
          })
          .width('95%')
          .onChange(val=>{
            this.pwd = val
            console.log(val)
          })
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
          .onClick(()=>{
            if (this.username === '') {
              Prompt.showDialog({
                message: "请输入账号",
              });
            } else if (this.pwd === '') {
              Prompt.showDialog({
                message: "请输入密码",
              });
            } else {
              const httpRequest = http.createHttp();
              httpRequest.request(
                'http://66:3000/login', // URL should be a string
                {
                  method: http.RequestMethod.POST, // 使用正确的枚举类型
                  header: { 'Content-Type': 'application/json' },
                  extraData: JSON.stringify({
                    username: this.username,
                    password: this.pwd
                  }),
                  readTimeout: 60000, // 超时时间
                  connectTimeout: 60000 // 超时时间
                }
              ).then((data) => {
                const response = JSON.parse(data.result as string); // 确保 result 是字符串类型
                if (data.responseCode === 200 && response.message === 'Login successful') {
                  // 登录成功，进行相应的操作
                  console.log('登录成功');
                  router.clear();
                  router.pushUrl({
                    url: 'pages/Page_11', // 主页页面
                    params:{username:this.username}
                  },
                    router.RouterMode.Single,
                    err => {
                      if (err) {
                        console.log('路由失败.');
                      }
                    }
                  );
                } else {
                  // 登录失败，显示错误信息
                  Prompt.showDialog({
                    message: '登录失败: ' + response.message,
                  });
                }
              }).catch((err) => {
                // 网络错误或其他错误
                console.error('登录请求错误:', err); // 输出完整的错误对象
                Prompt.showDialog({
                  message: '网络错误: ' + err,
                });
              });
            }
          })
      }
      .width('100%')
    }
    .height('80%')
  }
}

