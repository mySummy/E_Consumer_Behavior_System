import router from '@ohos.router';
import Prompt from '@system.prompt';
import http from '@ohos.net.http';
class customer {
  name:string
  money:number
  frequency:number
  type:string

  constructor(name:string,money:number,frequency:number,type:string) {
    this.name = name
    this.money = money
    this.frequency = frequency
    this.type = type
  }
}
@Entry
@Component
struct Page_15 {
  @State message: string = '分析-用户分类'
  params: any = router.getParams()
  int_id:Number = parseInt(this.params.id)
  private customers:Array<customer> = []
  getCsvData() {
    const httpRequest = http.createHttp();
    httpRequest.request(
      'http://localhost:3000/csv2-data', // URL 应为字符串
      {
        method: http.RequestMethod.GET, // 使用正确的枚举类型
        header: { 'Content-Type': 'application/json' }, // 设置正确的请求头
        readTimeout: 60000, // 读取超时
        connectTimeout: 60000 // 连接超时
      }
    ).then((data) => {
      const response = JSON.parse(data.result as string); // 确保 result 是字符串类型
      if (data.responseCode === 200) {
        // 请求成功，处理返回的数据
        console.log('获取CSV数据成功');
        this.customers = response.map((item) =>
        new customer(
          item['用户编号'],
          parseFloat(item['缴费金额']) / parseInt(item['缴费次数']),
          parseInt(item['缴费次数']),
          item['客户类型']
        )
        );
      } else {
        // 请求失败，显示错误信息
        const errorMessage = '获取CSV数据失败: ' + response.message;
        console.error(errorMessage);
        Prompt.showDialog({
          message: errorMessage,
        });
      }
    }).catch((err) => {
      // 网络错误或其他错误
      const errorMessage = '网络错误: ' + err.message;
      console.error('获取CSV数据请求错误:', err);
      Prompt.showDialog({
        message: errorMessage,
      });
    });
  }
  build() {
      Column() {
        Row() {
          Text('<返回')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .onClick(()=>{
              router.back()
            })
            .margin({
              top:'40vp',
              left:'10vp'
            })
        }.justifyContent(FlexAlign.Start)
        .width('100%')

        Text('所有用户类型')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 50, right: 90 })
        DataPanel({ values: [30,30,30,10], max: 100, type: DataPanelType.Line }).width(360).height(30)
        Row(){
          Text('高价值').fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#F5B621')
          Text('大众型').fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#F1521E')
          Text('潜力型').fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#EE64A1')
          Text('低价值').fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#A64CEF')}.justifyContent(FlexAlign.SpaceBetween).width('100%')
        Text('用户  平均缴费金额 平均缴费次数  类型')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Green)
          .margin({top:50})
        List(){
          ForEach(
            this.customers,
            (customers:customer) => {
              ListItem(){
                Row(){
                  Text(customers.name)
                    .fontSize(20)
                    .fontWeight(FontWeight.Bold)
                  Text('￥'+customers.money.toString())
                    .fontSize(20)
                    .fontWeight(FontWeight.Bold)
                  Text(customers.frequency.toString() + '次')
                    .fontSize(20)
                    .fontWeight(FontWeight.Bold)
                  Text(customers.type)
                    .fontSize(20)
                    .fontWeight(FontWeight.Bold)
                }.justifyContent(FlexAlign.SpaceBetween).width('100%')
              }
            }
          )
        }
        .height(400)
        Button('下载')
          .width(300)
          .height(50)
          .type(ButtonType.Normal)
          .backgroundColor(Color.Green)
          .borderRadius(10)
          .backgroundColor(Color.Green)
          .margin({top:20})
      }
      .width('100%')
      .height('100%')
      .onAppear(() => {
        this.getCsvData()
      });
  }
}