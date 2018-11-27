import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image,
  TabBarIOS,
  NavigatorIOS
} from 'react-native';

var Home = require('./home')
var Find = require('./find')
var Message = require('./message')
var Mine = require('./mine')

var Main = React.createClass({

    getInitialState(){
        return {
            selectedTab: 'home'
        }
    },

    render(){
        return (
            <TabBarIOS
                tintColor="rgba(255, 130, 1, 1.0)"
            >
                <TabBarIOS.Item
                    title="首页"
                    icon={require('../img/tabbar_home.png')}
                    selectedIcon={require('../img/tabbar_home_highlighted.png')}
                    onPress={()=>{
                        this.setState({
                            selectedTab: 'home',
                        })
                    }}
                    selected={this.state.selectedTab === 'home'}
                >
                <NavigatorIOS
                    tintColor="rgba(255, 130, 1, 1.0)"
                    style={{flex: 1}}
                    initialRoute={{
                        title:'网易',
                        component: Home,
                        leftButtonIcon: require('../img/navigationbar_friendattention.png'),
                        rightButtonIcon: require('../img/navigationbar_pop.png')
                    }}
                />
                </TabBarIOS.Item>
                <TabBarIOS.Item
                    title="发现"
                    icon={require('../img/tabbar_discover.png')}
                    selectedIcon={require('../img/tabbar_discover_highlighted.png')}
                    onPress={()=>{
                        this.setState({
                            selectedTab: 'find'
                        })
                    }}
                    selected={this.state.selectedTab === 'find'}
                >
                <NavigatorIOS
                    style={{flex: 1}}
                    initialRoute={{
                        title:'发现',
                        component: Find
                    }}
                />
                </TabBarIOS.Item>
                <TabBarIOS.Item
                    title="消息"
                    icon={require('../img/tabbar_message_center.png')}
                    selectedIcon={require('../img/tabbar_message_center_highlighted.png')}
                    onPress={()=>{
                        this.setState({
                            selectedTab: 'message'
                        })
                    }}
                    selected={this.state.selectedTab === 'message'}
                >
                <NavigatorIOS
                    style={{flex: 1}}
                    initialRoute={{
                        title:'消息',
                        component: Message
                    }}
                />
                </TabBarIOS.Item>
                <TabBarIOS.Item
                    title="我的"
                    icon={require('../img/tabbar_profile.png')}
                    selectedIcon={require('../img/tabbar_profile_highlighted.png')}
                    onPress={()=>{
                        this.setState({
                            selectedTab: 'mine'
                        })
                    }}
                    selected={this.state.selectedTab === 'mine'}
                >
                <NavigatorIOS
                    style={{flex: 1}}
                    initialRoute={{
                        title:'我的',
                        component: Mine
                    }}
                />
                </TabBarIOS.Item>
            </TabBarIOS>
        )
    },
});

const styles = StyleSheet.create({

});

module.exports = Main;
