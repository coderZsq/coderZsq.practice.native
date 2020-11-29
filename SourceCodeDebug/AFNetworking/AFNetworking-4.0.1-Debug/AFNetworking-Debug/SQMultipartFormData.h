//
//  SQMultipartFormData.h
//  AFNetworking-Debug
//
//  Created by 朱双泉 on 2020/11/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 AFMultipartFormData协议定义了AFHTTPRequestSerializer -multipartFormRequestWithMethod：URLString：parameters：constructingBodyWithBlock：的block参数中参数所支持的方法。
 */
@protocol SQMultipartFormData

/**
 附加HTTP标头`Content-Disposition：file; filename =＃{生成的文件名}; name =＃{name}”和“ Content-Type：＃{生成的mimeType}”，然后是编码的文件数据和多部分表单边界。

   表单中此数据的文件名和MIME类型将分别使用`fileURL`的最后一个路径部分和`fileURL`扩展名与系统相关的MIME类型自动生成。

   @param fileURL 对应于其内容将附加到表单的文件的URL。 该参数不能为“ nil”。
   @param name 与指定数据关联的名称。 该参数不能为“ nil”。
   @param error 如果发生错误，返回时将包含一个描述问题的NSError对象。

   @如果文件数据已成功添加，则返回“是”，否则返回“否”。
 */
- (BOOL)appendPartWithFileURL:(NSURL *)fileURL
                         name:(NSString *)name
                        error:(NSError * _Nullable __autoreleasing *)error;

/**
 附加HTTP标头`Content-Disposition：file; filename =＃{filename}; name =＃{name}”和“ Content-Type：＃{mimeType}”，然后是编码文件数据和多部分表单边界。

   @param fileURL 对应于其内容将附加到表单的文件的URL。 该参数不能为“ nil”。
   @param name 与指定数据关联的名称。 该参数不能为“ nil”。
   @param fileName 在Content-Disposition标头中使用的文件名。 该参数不能为“ nil”。
   @param mimeType 文件数据的声明的MIME类型。 该参数不能为“ nil”。
   @param error 如果发生错误，返回时将包含一个描述问题的NSError对象。

   @如果文件数据已成功添加，则返回“是”，否则返回“否”。
 */
- (BOOL)appendPartWithFileURL:(NSURL *)fileURL
                         name:(NSString *)name
                     fileName:(NSString *)fileName
                     mimeType:(NSString *)mimeType
                        error:(NSError * _Nullable __autoreleasing *)error;

/**
 附加HTTP标头`Content-Disposition：file; filename =＃{filename}; name =＃{name}”和“ Content-Type：＃{mimeType}”，然后是来自输入流的数据和多部分表单边界。

   @param inputStream 要添加到表单数据的输入流
   @param name 与指定的输入流关联的名称。 该参数不能为“ nil”。
   @param fileName 与指定输入流关联的文件名。 该参数不能为“ nil”。
   @param length 以字节为单位的指定输入流的长度。
   @param mimeType 指定数据的MIME类型。 （例如，JPEG图像的MIME类型为image / jpeg。）有关有效MIME类型的列表，请参见http://www.iana.org/assignments/media-types/。 该参数不能为“ nil”。
 */
- (void)appendPartWithInputStream:(nullable NSInputStream *)inputStream
                             name:(NSString *)name
                         fileName:(NSString *)fileName
                           length:(int64_t)length
                         mimeType:(NSString *)mimeType;

/**
 附加HTTP标头`Content-Disposition：file; filename =＃{filename}; name =＃{name}”和“ Content-Type：＃{mimeType}”，然后是编码文件数据和多部分表单边界。

   @param data 要编码并附加到表单数据的数据。
   @param name 与指定数据关联的名称。 该参数不能为“ nil”。
   @param fileName 与指定数据关联的文件名。 该参数不能为“ nil”。
   @param mimeType 指定数据的MIME类型。 （例如，JPEG图像的MIME类型为image / jpeg。）有关有效MIME类型的列表，请参见http://www.iana.org/assignments/media-types/。 该参数不能为“ nil”。
 */
- (void)appendPartWithFileData:(NSData *)data
                          name:(NSString *)name
                      fileName:(NSString *)fileName
                      mimeType:(NSString *)mimeType;

/**
 附加HTTP标头`Content-Disposition：form-data; name =＃{name}“`，后跟编码数据和多部分表单边界。

   @param data 要编码并附加到表单数据的数据。
   @param name 与指定数据关联的名称。 该参数不能为“ nil”。
 */

- (void)appendPartWithFormData:(NSData *)data
                          name:(NSString *)name;


/**
 附加HTTP标头，后跟编码数据和多部分表单边界。

   @param headers 要附加到表单数据的HTTP标头。
   @param body 要编码并附加到表单数据的数据。 该参数不能为“ nil”。
 */
- (void)appendPartWithHeaders:(nullable NSDictionary <NSString *, NSString *> *)headers
                         body:(NSData *)body;

/**
 节流通过限制数据包大小并为从上传流中读取的每个数据块增加延迟来请求带宽。

  通过3G或EDGE连接上载时，请求可能会失败，并显示“请求正文流已耗尽”。根据建议值（kAFUploadStream3GSuggestedPacketSize和kAFUploadStream3GSuggestedDelay）设置最大数据包大小和延迟，可降低输入流超过其分配带宽的风险。不幸的是，没有确定的方法来区分通过NSURLConnection的3G，EDGE或LTE连接。因此，不建议您仅根据网络可达性来限制带宽。相反，您应该考虑在故障块中检查“请求正文流已耗尽”，然后使用限制带宽重试该请求。

  @param numberOfBytes 最大数据包大小，以字节数为单位。输入流的默认数据包大小为16kb。
  @param delay 每次读取数据包时的延迟持续时间。默认情况下，不设置延迟。
 */
- (void)throttleBandwidthWithPacketSize:(NSUInteger)numberOfBytes
                                  delay:(NSTimeInterval)delay;

@end

NS_ASSUME_NONNULL_END
