import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image,
  ListView,
  TabBarIOS
} from 'react-native';

var TabBar = React.createClass({

    getInitialState() {
        return {
            selectedTab: 0
        }
    },

    render(){
        return (
            <TabBarIOS
                tintColor="gray"
                barTintColor="skyblue"
                >
                <TabBarIOS.Item
                    systemIcon="bookmarks"
                    onPress={()=>{
                        this.setState({
                            selectedTab: 0
                        })
                    }}
                    selected={this.state.selectedTab === 0}
                >
                <View style={{flex: 1, backgroundColor: 'red'}}><Text>第1页</Text></View>
                </TabBarIOS.Item>

                <TabBarIOS.Item
                    systemIcon="contacts"
                    onPress={()=>{
                        this.setState({
                            selectedTab: 1
                        })
                    }}
                    selected={this.state.selectedTab === 1}
                >
                <View style={{flex: 1, backgroundColor: 'yellow'}}><Text>第2页</Text></View>
                </TabBarIOS.Item>

                <TabBarIOS.Item
                    systemIcon="downloads"
                    onPress={()=>{
                        this.setState({
                            selectedTab: 2
                        })
                    }}
                    selected={this.state.selectedTab === 2}
                >
                <View style={{flex: 1, backgroundColor: 'blue'}}><Text>第3页</Text></View>
                </TabBarIOS.Item>

                <TabBarIOS.Item
                    systemIcon="favorites"
                    onPress={()=>{
                        this.setState({
                            selectedTab: 3
                        })
                    }}
                    selected={this.state.selectedTab === 3}
                >
                <View style={{flex: 1, backgroundColor: 'green'}}><Text>第4页</Text></View>
                </TabBarIOS.Item>
            </TabBarIOS>
        )
    }
});

const styles = StyleSheet.create({

});

module.exports = TabBar
