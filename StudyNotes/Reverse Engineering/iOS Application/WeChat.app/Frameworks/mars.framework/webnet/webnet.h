//
//  webnet.h
//  webnet
//
//  Created by elviswu on 2017/9/25.
//  Copyright © 2017年 Tencent. All rights reserved.
//

#ifndef webnet_h
#define webnet_h
#include <string>
#include <vector>
#include <map>
namespace mars {
namespace webnet {
    enum WEBNetErrorCode {
        kErrSuccess = 0,
        
        //client -200XX
        //不可重试的错误码
        kErrNotInit                       = -20001, //没有init
        kErrInvalidRootPath              = -20002, //根目录非法
        kErrInvalidParam                   = -20003, //参数错误
        kErrUnavalible                    = -20004, //WebNet不可用
        
        
    };
    
    class URLRequest {
      public:
        std::string client_msg_id_ = "";
        std::string url_ = "";
        std::string bakup_url_ = "";
        std::string file_path_ = "";
        
        std::vector<std::string> user_define_headers_;
        
        uint64_t queue_timeout_ms_ = 0; //0表示使用内部默认超时
        uint64_t transfer_timeout_ms_ = 0;//0表示使用内部默认超时
        
        int file_type_ = 0; //图片、视频、大文件、小程序、游戏
        
        bool allow_mobile_net_traffic_ = false; //传输数据过程中切换到mobile网络是否继续
        uint64_t mobile_net_hold_ms_ = 0; //allow_mobile_net_traffic_为false时才有效，在mobile_net_hold_ms内，网络类型切换回wifi则重试，否则返回失败
        uint64_t no_net_hold_ms_ = 0;
    };
    class URLResponse {
      public:
        std::string client_msg_id_ = "";
        std::string url_ = "";
        std::string file_path_ = "";
        size_t file_size_ = 0;
        int file_type_ = 0;
        int error_type_ = 0;
        int error_code_ = 0;
    };
    
    class URLUploadRequest : public URLRequest {
        
    };
    class URLDownloadRequest : public URLRequest {
      public:
        size_t predict_file_size_ = 0;
        ssize_t max_task_retry_count_ = -1; //<0 for unlimit
        std::vector<std::string> prior_ips_;
        std::map<std::string, std::string> user_define_headers_;
        std::map<std::string, std::string> verify_headers_;
    };
    
    class URLUploadResponse : public URLResponse {
        
    };
    class URLDownloadResponse : public URLResponse {
      public:
        int status_code_ = 0;
        bool is_resumed_ = false;
    };
    
    
    extern void OnProgressChanged(const std::string& _id, size_t _completed_length, size_t _total_length);
    extern void OnUploadCompleted(const std::string& _id, const URLUploadResponse& _response);
    extern void OnDownloadCompleted(const std::string& _id, const URLDownloadResponse& _response);
        
        
} //namespace webnet
} //namespace mars


#endif /* webnet_h */
