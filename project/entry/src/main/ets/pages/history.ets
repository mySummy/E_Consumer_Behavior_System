class file {
  id:string
  time:string
  type:string

  constructor(id:string,time:string,type:string) {
    this.id = id
    this.time = time
    this.type = type
  }
}
import router from '@ohos.router';
@Entry
@Component
struct Page_17 {
  @State message: string = '历史记录'
  @State private files:Array<file> = [
    new file('9999','2024.05.29','居民用电归类'),    new file('0001','2024.05.29','居民用电归类'),
    new file('0001','2024.05.29','居民用电归类'),    new file('0001','2024.05.29','居民用电归类'),
    new file('0001','2024.05.29','居民用电归类'),    new file('0001','2024.05.29','居民用电归类'),
    new file('0001','2024.05.29','居民用电归类'),    new file('0001','2024.05.29','居民用电归类'),
    new file('0001','2024.05.29','居民用电归类'),    new file('0001','2024.05.29','居民用电归类'),
    new file('0001','2024.05.29','居民用电归类'),    new file('0001','2024.05.29','居民用电归类'),
    new file('0001','2024.05.29','居民用电归类'),    new file('0001','2024.05.29','居民用电归类'),
    new file('0001','2024.05.29','居民用电归类'),    new file('0001','2024.05.29','居民用电归类'),
    new file('0001','2024.05.29','居民用电归类'),    new file('0001','2024.05.29','居民用电归类'),
    new file('0001','2024.05.29','居民用电归类'),    new file('0001','2024.05.29','居民用电归类'),
    new file('0001','2024.05.29','居民用电归类'),    new file('0001','2024.05.29','居民用电归类'),
    new file('0001','2024.05.29','居民用电归类'),    new file('0001','2024.05.29','居民用电归类'),
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
      Text('历史记录')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .margin({top:30,right:200})
      Column(){
        Text('编号       提交时间           类型         删除')
          .fontSize(20)
          .fontColor(Color.Green)
          .fontWeight(FontWeight.Bold)
          .margin({top:30})
      }
      List(){
        ForEach(
          this.files,
          (files:file,index) => {
            ListItem(){
              Row(){
                Text(files.id)
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                Text(files.time)
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                Text(files.type)
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                Image($r('app.media.clean'))
                  .onClick(() => {
                    this.files.splice(index,1)
                  })
                  .width(30)

              }.justifyContent(FlexAlign.SpaceBetween).width('100%').margin({top:10})
            }
          }
        )
      }
    }
    .width('100%')
    .height('100%')
  }
}