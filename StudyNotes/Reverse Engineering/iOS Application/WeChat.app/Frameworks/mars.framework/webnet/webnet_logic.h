//
//  webnet_logic.h
//  webnet
//
//  Created by elviswu on 2017/9/25.
//  Copyright © 2017年 Tencent. All rights reserved.
//

#ifndef webnet_logic_h
#define webnet_logic_h

#include <string>
#include <vector>

#include "webnet.h"

namespace mars {
namespace webnet {
        
    //callback interface
    class Callback
    {
      public:
        virtual ~Callback(){}
        virtual void OnProgressChanged(const std::string& _id, size_t _completed_length, size_t _total_length){}
        virtual void OnUploadCompleted(const std::string& _id, const URLUploadResponse& _response){}
        virtual void OnDownloadCompleted(const std::string& _id, const URLDownloadResponse& _response){}
    };
    
    // set webnet data root path
    int SetRootPath(const std::string& _root_path);

    // callback
    void SetCallback(Callback* const callback);

    // set debug ip. set `ip` to NULL to clean debugip
    void SetDebugIP(const char* ip);
    //for dns resolve accelerate
    void SetHostIP(const std::string& host, const std::vector<std::string>& iplist, int source);
    
    //Task
    int StartURLDownloadTask(const URLDownloadRequest& _req);
    int StartURLUploadTask(const URLUploadRequest& _req);
    void CancelTask(const std::string& _client_msg_id);
    
    int PauseTask(const std::string& _id);
    int ResumeTask(const std::string& _id);
    
    int QueryTaskState(const std::string& _id, size_t& _completed_length, size_t& _total_length);
    
    int Cancel(const std::string& _id);
    int CancelUploadTaskWithResult(const std::string& _id, URLUploadResponse& _cur_resp);
    int CancelDownloadTaskWithResult(const std::string&  _id, URLDownloadResponse& _cur_resp);
    
    void Init();
    
    
} //namespace webnet
} //namespace mars


#endif /* webnet_logic_h */
