import router from '@ohos.router';
class customer {
  name:string
  probability:number
  top:number
  constructor(name:string,probability:number,top:number) {
    this.name = name
    this.probability = probability
    this.top = top
  }
}
@Entry
@Component
struct Page_16 {
  @State message: string = 'TOP 5'
  params: any = router.getParams()
  int_id:Number = parseInt(this.params.id)
  private customers:Array<customer> = [
    new customer('田所浩二',99,1),
    new customer('田所浩二',98,2),
    new customer('田所浩二',97,3),
    new customer('田所浩二',96,4),
    new customer('田所浩二',95,5),
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
        Column(){
          Text('高价值预测TOP5')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
          Text('预测月份：20XX.XX')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          Text('预测时间区块')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          Text('起始月份')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          Select([{ value: '1'},{ value: '2'},{ value: '3'},{ value: '4'},{ value: '5'},{ value: '6'},{ value: '7'},{ value: '8'},
            { value: '9'},{ value: '10'},{ value: '11'},{ value: '12'}])
            .selected(-1)
            .value('选择月份')
            .font({ size: 16, weight: 500 })
            .fontColor('#182431')
            .selectedOptionFont({ size: 16, weight: 400 })
            .optionFont({ size: 16, weight: 400 })
            .margin({top:10})
            .onSelect((index: number) => {
              console.info('Select:' + index)
            })
            .borderWidth(1)
          Text('结束月份')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .margin({top:20})
          Select([{ value: '1'},{ value: '2'},{ value: '3'},{ value: '4'},{ value: '5'},{ value: '6'},{ value: '7'},{ value: '8'},
            { value: '9'},{ value: '10'},{ value: '11'},{ value: '12'}])
            .selected(-1)
            .value('选择月份')
            .font({ size: 16, weight: 500 })
            .fontColor('#182431')
            .selectedOptionFont({ size: 16, weight: 400 })
            .optionFont({ size: 16, weight: 400 })
            .margin({top:10})
            .borderWidth(1)

            .onSelect((index: number) => {
              console.info('Select:' + index)
            })
        }.margin({top:10,right:50}).alignItems(HorizontalAlign.Start)
        Text('预测结果')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .margin({right:250,top:100})
        Column(){
          Text('TOP          用户          高价值概率')
            .fontSize(20)
            .fontColor(Color.Green)
            .fontWeight(FontWeight.Bold)
          ForEach(
            this.customers,
            (customers:customer) => {
              Row(){
                Text(customers.top.toString())
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .margin({left:50})
                Text(customers.name)
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .margin({right:10})
                Text(customers.probability.toString() + '%')
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .margin({right:70})
              }.justifyContent(FlexAlign.SpaceBetween).width('100%')
            }
          )
        }
      }
      .width('100%')
    .height('100%')
  }
}