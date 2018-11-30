import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image,
  TouchableOpacity
} from 'react-native';

var Dimensions = require('Dimensions');
var {width, height} = Dimensions.get('window')

import HomeCommonView from './homecommonview'

var HomeMiddleView = React.createClass({

    getDefaultProps(){
        return {
            dataObj: {}
        }
    },

    render(){
        var dataLeft = this.props.dataObj.dataLeft;
        return (
            <View style={styles.container}>
                <TouchableOpacity style={styles.leftViewStyle}>
                    <Image source={{uri: dataLeft.img1}} style={styles.imgStyle}/>
                    <Image source={{uri: dataLeft.img2}} style={styles.imgStyle}/>
                    <Text>{dataLeft.title}</Text>
                    <View style={{flexDirection: 'row'}}>
                        <Text>{dataLeft.price}</Text>
                        <Text>{dataLeft.sale}</Text>
                    </View>
                </TouchableOpacity>
                <View style={styles.rightViewStyle}>
                    {this.renderBottomItem()}
                </View>
            </View>
        )
    },

    renderBottomItem(){
        var rightDataArr = this.props.dataObj.dataRight;
        var itemArr = [];
        for (var i = 0; i < rightDataArr.length; i++) {
            var item = rightDataArr[i];
            itemArr.push(
                <HomeCommonView key={i} data={rightDataArr[i]}/>
            );
        }
        return itemArr;
    }
});

const styles = StyleSheet.create({
    container: {
        marginTop: 15,
        flexDirection: 'row'
    },
    leftViewStyle: {
        backgroundColor: 'white',
        width: width * 0.5 - 1,
        height: 131,
        alignItems: 'center',
        justifyContent: 'space-around',
        marginRight: 1
    },
    imgStyle: {
        width: width * 0.35,
        height: width * 0.1,
        resizeMode: 'contain'
    },
    rightViewStyle: {

    }
});

module.exports = HomeMiddleView
