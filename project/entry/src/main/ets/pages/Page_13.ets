import router from '@ohos.router';
@Entry
@Component
struct Page_12 {
  @State message: string = 'Hello World'

  build() {
    Row() {
      Column() {
        Progress({
          value: 10,
          total: 100,
          type: ProgressType.Ring
        })
        Text('数据加载中')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)

      }
      .width('100%')
    }
    .height('100%')
  }
}