import router from '@ohos.router';
import Prompt from '@system.prompt';
import http from '@ohos.net.http';
@Entry
@Component
struct Page_14 {
  @State message: string = '分析-主界面'
  @State money:number = 0
  @State time:number = 0
  params: any = router.getParams()
  int_id:Number = parseInt(this.params.id)

  onInit() {
    this.sendHttpRequest(
      (response, statusCode) => {
        this.money = response.avgAmount;
        this.time = response.avgCount;
        Prompt.showToast({ message: `Data fetched: avgAmount = ${this.money}, avgCount = ${this.time}` });
      },
      (error) => {
        Prompt.showToast({ message: `Error: ${error.message || error}` });
      }
    );
  }
  sendHttpRequest(onSuccess: (response: any, statusCode: number) => void, onError: (error: any) => void) {
    const httpRequest = http.createHttp();
    httpRequest.request(
      'http://localhost:3000/payment-stats', // 确保服务器端在这个地址运行
      {
        method: http.RequestMethod.GET, // 使用GET方法
        header: { 'Content-Type': 'application/json' },
        readTimeout: 60000,
        connectTimeout: 60000
      }
    ).then((data) => {
      try {
        const response = JSON.parse(data.result.toString());
        onSuccess(response, data.responseCode);
      } catch (e) {
        onError(e);
      }
    }).catch((error) => {
      onError(error);
    });
  }
  build() {
      Column() {
        Row(){
          Text('<返回')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .onClick(()=>{
              router.back({url:"pages/Index"})
            })
            .margin({
              top:'40vp',
              left:'10vp'
            })
        }.justifyContent(FlexAlign.Start)
        .width('100%')
        Row(){
          Text('全部数据')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
        }.margin({right:180,
                  top:50  })
        Row(){
          Column(){
            Text('平均缴费金额')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
            Text('￥'+this.money)
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Gray)}
              .margin({top:50})
          Button('所有用户类型')
            .type(ButtonType.Normal)
            .width(125)
            .height(100)
            .borderRadius(10)
            .backgroundColor(Color.Green)
            .margin({top:50})
            .onClick(()=>{
              router.pushUrl({
                url:'pages/classification',
                params: { id: this.int_id }
              },router.RouterMode.Single,
                err => {
                  if(err){
                    console.log('路由失败')
                  }
                }
              )
            })
        }.justifyContent(FlexAlign.SpaceAround)
        .width('100%')
        Row(){
          Column(){
            Text('平均缴费次数')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
            Text(this.time +'次')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Gray)}
              .margin({top:50})
          Button('预测高价值TOP5')
            .type(ButtonType.Normal)
            .width(125)
            .height(100)
            .borderRadius(10)
            .backgroundColor(Color.Green)
            .margin({top:50})
            .onClick(()=>{
              router.pushUrl({
                url:'pages/Top5',
                params: { id: this.int_id }
              },router.RouterMode.Single,
                err => {
                  if(err){
                    console.log('路由失败')
                  }
                }
              )
            })
        }.justifyContent(FlexAlign.SpaceAround)
        .width('100%')
        Button('重新上传')
          .type(ButtonType.Normal)
          .width(300)
          .height(50)
          .borderRadius(10)
          .backgroundColor(Color.Blue)
          .margin({top:80})
          .onClick(()=>{
            router.back({url:"pages/upload"})
          })
      }
      .width('100%')
      .height('100%')
  }
}