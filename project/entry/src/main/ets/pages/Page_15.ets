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
        Text('用户  平均缴费金额 平均缴费次数  类型')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Green)
          .margin({top:100})
        List(){
          ForEach(
            this.customers,
            (customers:customer) => {
              ListItem(){
                Row(){
                  Text(customers.name)
                    .fontSize(20)
                    .fontWeight(FontWeight.Bold)
                  Text(customers.money.toString() + 'RMB')
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
      }
      .width('100%')
      .height('100%')
  }
}