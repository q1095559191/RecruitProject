

//当前设备的屏幕宽度
#define SCREEN_WIDTH   [[UIScreen mainScreen]  bounds].size.width

//当前设备的屏幕高度
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height

//类型转换
#define WeakSelf __weak typeof(self) weakSelf = self;
#define WeakObj(o) __weak typeof(o) o##Weak = o;

#define LSTYPEChangeModel(type,data)  typeof(type) model = (typeof(type))data;


/* 自定义NSLog */
//#ifdef DEBUG
//#define NSLog NSLog(@"[%s] [%s] [%d] ",strrchr(__FILE__,'/'), __FUNCTION__, __LINE__);NSLog
//#else
//#define NSLog(...)
//#endif



/* 下载文件路径 */
#define DocumentsDirectory [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject]
#define FileDocPath [DocumentsDirectory stringByAppendingPathComponent:@"fileDownTextDoc"]
#define FilePath(fileName) [FileDocPath stringByAppendingPathComponent:fileName]
#define APPDELEGETE ((AppDelegate *)[[UIApplication sharedApplication] delegate])

//非空 字典
#define ISNOTNILDIC(IPHONEDIC) ([IPHONEDIC isKindOfClass:[NSDictionary class]] && IPHONEDIC != nil)? YES:NO
// 非空 数组
#define ISNOTNILARR(ARR) ([ARR isKindOfClass:[NSArray class]] && ARR != nil)? YES:NO
//非空 字符串
#define ISNOTNILSTR(STR) ([STR isKindOfClass:[NSString class]] && STR != nil)? YES:NO
//空字符串
#define LSHabdleNilSTR(str)  ISNOTNILSTR(str)?:str = @""


#define ISNILSTR(STR)    ([STR isEqualToString:@""] || STR == nil)? YES:NO
#define ISKINDOFCLASS(obj,classname)  [obj isKindOfClass:[classname class]]
