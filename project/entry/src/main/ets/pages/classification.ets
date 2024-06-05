import router from '@ohos.router';
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
  private customers:Array<customer> = [
    new customer('田所浩二',1145,14,'恶臭客户'),
    new customer('田所浩二',1145,14,'恶臭客户'),
    new customer('田所浩二',1145,14,'恶臭客户'),
    new customer('田所浩二',1145,14,'恶臭客户'),
    new customer('田所浩二',1145,14,'恶臭客户'),
    new customer('田所浩二',1145,14,'恶臭客户'),
    new customer('田所浩二',1145,14,'恶臭客户'),
    new customer('田所浩二',1145,14,'恶臭客户'),
    new customer('田所浩二',1145,14,'恶臭客户'),
    new customer('田所浩二',1145,14,'恶臭客户'),
    new customer('田所浩二',1145,14,'恶臭客户'),
    new customer('田所浩二',1145,14,'恶臭客户'),
    new customer('田所浩二',1145,14,'恶臭客户'),
    new customer('田所浩二',1145,14,'恶臭客户'),
    new customer('田所浩二',1145,14,'恶臭客户'),
    new customer('田所浩二',1145,14,'恶臭客户'),
    new customer('田所浩二',1145,14,'恶臭客户'),
    new customer('田所浩二',1145,14,'恶臭客户'),
    new customer('田所浩二',1145,14,'恶臭客户'),
    new customer('田所浩二',1145,14,'恶臭客户'),
    new customer('田所浩二',1145,14,'恶臭客户'),
    new customer('田所浩二',1145,14,'恶臭客户'),
    new customer('田所浩二',1145,14,'恶臭客户'),
  ]
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
  }
}