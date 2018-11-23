import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  Image,
  TextInput,
  TouchableOpacity
} from 'react-native';

var Dimensions = require('Dimensions');
var screenWidth = Dimensions.get('window').width

export default class BaseView extends Component {
  render() {
    return (
        <View style={styles.container}>
            <Image source={require('../img/Castiel.jpg')} style={styles.iconStyle}/>
            <TextInput placeholder="请输入账号" style={[styles.inputStyle, {marginTop: 30}]}/>
            <TextInput placeholder="请输入密码" password={true} style={styles.inputStyle}/>
            <TouchableOpacity style={styles.btnStyle} onPress={()=>this.clickBtn()}>
                <Text style={styles.btnTextStyle}>登 录</Text>
            </TouchableOpacity>
            <View style={styles.settingStyle}>
                <Text style={{color: 'blue'}}>无法登录</Text>
                <Text style={{color: 'blue'}}>新用户?</Text>
            </View>
            <View style={styles.footerViewStyle}>
                <Text>其他方式登录: </Text>
                <Image source={require('../img/Castiel.jpg')} style={styles.footerImgStyle}/>
                <Image source={require('../img/Castiel.jpg')} style={styles.footerImgStyle}/>
                <Image source={require('../img/Castiel.jpg')} style={styles.footerImgStyle}/>
            </View>
        </View>
    );
  }

  clickBtn() {
      alert('点击了按钮');
  }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        // justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#e8e8e8'
    },
    iconStyle: {
        width: 80,
        height: 80,
        marginTop: 60,
        borderRadius: 40,
        borderWidth: 3,
        borderColor: 'white'
    },
    inputStyle: {
        height: 44,
        backgroundColor: 'white',
        marginBottom: 1,
        textAlign: 'center'
    },
    btnStyle: {
        height: 44,
        width: screenWidth * 0.95,
        backgroundColor: 'orange',
        marginTop: 30,
        borderRadius: 10,
        justifyContent: 'center',
        alignItems: 'center'
    },
    btnTextStyle: {
        backgroundColor: 'rgba(0, 0, 0, 0)',
        color: 'white',
        fontSize: 18
    },
    settingStyle: {
        // backgroundColor: 'red',
        flexDirection: 'row',
        width: screenWidth * 0.95,
        justifyContent: 'space-between',
        marginTop: 10
    },
    footerViewStyle: {
        flexDirection: 'row',
        alignItems: 'center',
        position: 'absolute',
        left: 0,
        bottom: 0,
        paddingBottom: 20,
        paddingLeft: 10
    },
    footerImgStyle: {
        width: 50,
        height: 50,
        borderRadius: 25,
        marginLeft: 10,
    }
});

module.exports = BaseView;
