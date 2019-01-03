module Fastlane
  module Actions
    module SharedValues
      REMOVE_TAG_CUSTOM_VALUE = :REMOVE_TAG_CUSTOM_VALUE
    end

    class RemoveTagAction < Action
      def self.run(params)
        # fastlane will take care of reading in the parameter and fetching the environment variable:
        # UI.message "Parameter API Token: #{params[:api_token]}"

        # sh "shellcommand ./path"

        # Actions.lane_context[SharedValues::REMOVE_TAG_CUSTOM_VALUE] = "my_val"

        tagName = params[:tag]
        isRemoveLocalTag = params[:rL]
        isRemoveRemoteTag = params[:rR]

        # 1. 先定义一个数组, 用来存储所有需要执行的命令
        cmds = []
        # 2. 往数组里面, 添加相应的命令
        # 删除本地标签
        # git tag -d 标签名称
        if isRemoveLocalTag
          cmds << "git tag -d #{tagName} "
        end
        # 删除远程标签
        # git push origin :标签名称
        if isRemoveRemoteTag
          cmds << " git push origin :#{tagName}"
        end
        # 3. 执行数组里面的所有命令
        result = Actions.sh(cmds.join('&'));
        return result

      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        # "A short description with <= 80 characters of what this action does"
        "删除标签"
      end

      def self.details
        # Optional:
        # this is your chance to provide a more detailed description of this action
        # "You can use this action to do cool things..."
        "我们可以使用这个action, 来删除本地或者远程标签"
      end

      def self.available_options
        # Define all options your action supports. 
        
        # Below a few examples
        [
          # FastlaneCore::ConfigItem.new(key: :api_token,
          #                              env_name: "FL_REMOVE_TAG_API_TOKEN", # The name of the environment variable
          #                              description: "API Token for RemoveTagAction", # a short description of this parameter
          #                              verify_block: proc do |value|
          #                                 UI.user_error!("No API token for RemoveTagAction given, pass using `api_token: 'token'`") unless (value and not value.empty?)
          #                                 # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
          #                              end),
          # FastlaneCore::ConfigItem.new(key: :development,
          #                              env_name: "FL_REMOVE_TAG_DEVELOPMENT",
          #                              description: "Create a development certificate instead of a distribution one",
          #                              is_string: false, # true: verifies the input is a string, false: every kind of value
          #                              default_value: false), # the default value if the user didn't provide one
          FastlaneCore::ConfigItem.new(key: :tag,
                                       description: "需要被删除的标签名称",
                                       optional: false,
                                       is_string: true), 
          FastlaneCore::ConfigItem.new(key: :rL,
                                       description: "是否需要删除本地标签",
                                       optional: true,
                                       is_string: false,
                                       default_value: true),
          FastlaneCore::ConfigItem.new(key: :rR,
                                       description: "是否需要删除远程标签",
                                       optional: true,
                                       is_string: false,
                                       default_value: true)                             
        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        # [
        #   ['REMOVE_TAG_CUSTOM_VALUE', 'A description of what this value contains']
        # ]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.authors
        # So no one will ever forget your contribution to fastlane :) You are awesome btw!
        ["Castie!"]
      end

      def self.is_supported?(platform)
        # you can do things like
        # 
        #  true
        # 
        #  platform == :ios
        # 
        #  [:ios, :mac].include?(platform)
        # 

        platform == :ios
      end
    end
  end
end
