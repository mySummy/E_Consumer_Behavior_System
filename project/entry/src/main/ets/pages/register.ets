import router from '@ohos.router';
import Prompt from '@system.prompt';

@Entry
@Component
struct Register {
  @State username: string = '';
  onLoadComplete() {
    // 跳转到另一个页面
    router.pushUrl({
      url: 'pages/Password',
      params:{username:this.username,
              mode:1}
    }, router.RouterMode.Single,
      err => {
        if (err) {
          console.log('路由失败');
        }
      }
    )
  }
  build() {
    Row() {
      Column() {
        Text('< 返回')
          .textAlign(TextAlign.Start)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
          .onClick(() => {
            router.back({url:'pages/logon'})
          })
          .margin({
            top: '30vp',
            left: '30vp'
          })
          .width('100%');

        Image($r('app.media.app_icon'))
          .width(100)
          .height(100)
          .margin({
            top: '70vp',
            bottom: '9vp'
          });
        Text('注册界面')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin(10);
        Text('欢迎使用 电力客户分析')
          .fontSize(16)
          .fontColor(Color.Gray);
        TextInput({ placeholder: '输入手机号' })
          .type(InputType.PhoneNumber)
          .margin({
            top: '30vp'
          })
          .onChange(val => {
            this.username = val;
            console.log(val);
          })
          .width('95%');
        Button('注册')
          .width(300)
          .height(40)
          .margin({
            top: '100vp'
          })
          .backgroundColor(Color.Green)
          .onClick(() => {
            if (this.username === '') {
              Prompt.showDialog({
                message: '请输入手机号',
              });
            }
            else {
            this.onLoadComplete();
            }
          });
      }
      .width('100%');
    }
    .height('80%');
  }
}
