import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  TouchableOpacity,
  TextInput
} from 'react-native';

var LifeCycle = React.createClass({
    //初始化属性 只读 不能修改
    getDefaultProps() {
        return {
            name: 'Castiel'
        }
    },
    //初始化属性 可读写
    getInitialState() {
        return {
            age: 26
        }
    },
    componentWillMount() {

    },
    //初始化 渲染界面
    render() {
        return(
            <View style={styles.container}>
                <Text>Name: {this.props.name};</Text>
                <Text>Age: {this.state.age};</Text>
                <TextInput ref="textInput" style={{width: 300, height: 40, borderWidth: 1, borderColor: 'red'}}/>
                <TouchableOpacity onPress={this.dealWithAge}>
                    <Text>plus 1</Text>
                </TouchableOpacity>
            </View>
        )
    },
    //处理一些耗时的操作 网络操作 定时器
    componentDidMount() {

    },

    dealWithAge() {
        this.setState({
            age: this.state.age += 1
        })
        this.refs.textInput.focus();
    }
})

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#f5fcff'
    }
})

module.exports = LifeCycle;
