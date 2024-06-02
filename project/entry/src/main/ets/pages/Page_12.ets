import router from '@ohos.router';
@Entry
@Component
struct Page {
  @State money: number = 0.0;
  @State frequency: number = 0.0;

  build() {
      Column() {
        Row(){
          Text('< 返回')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .onClick(()=>{
            router.back()
          })
        }.justifyContent(FlexAlign.Start)
        .width('100%')
        Column(){
          Button('上传文件')
            .fontColor(Color.Black)
            .type(ButtonType.Normal)
            .width('150')
            .height('40')
            .borderRadius(5)
            .backgroundColor(Color.White)
            .borderWidth(1)
            .borderColor(Color.Black)
            .onClick(()=>{
              router.pushUrl({
                url:'pages/Page_13',
                params:{id:1}
              },router.RouterMode.Single,
                err => {
                  if(err){
                    console.log('路由失败')
                  }
                }
              )
            })
          Text('请上传xls/xlsx文件，大小在60M以内')
            .fontColor(Color.Gray)
            .fontSize(15)
            .margin({top:25})
        }.margin({top:220})
        Column(){
          Text('评判标准-自定义')
            .fontSize(25)
            .fontColor(Color.Black)
          Text('留空则为系统默认标准')
            .fontSize(15)
            .fontColor(Color.Gray)
        }.margin({top:100})
        Row(){
          Text('评价缴费金额标准')
            .fontSize(18)
            .fontColor(Color.Black)
            .margin({right:10})
          TextInput({placeholder:'默认'})
            .type(InputType.Number)
            .borderWidth(1)
            .width(150)
            .onChange( value =>{
              this.money = parseFloat(value)
            })
        }.margin({top:10})
        Row(){
          Text('评价缴费次数标准')
            .fontSize(18)
            .fontColor(Color.Black)
            .margin({right:10})
          TextInput({placeholder:'默认'})
            .type(InputType.Number)
            .borderWidth(1)
            .width(150)
            .onChange( value =>{
              this.frequency = parseFloat(value)
            })
        }.margin({top:20})

      }
      .width('100%')
      .height('100%')
  }
}