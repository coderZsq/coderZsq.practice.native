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

var HomeCommonView = React.createClass({

    getDefaultProps(){
        return {
            data: {}
        }
    },

    render(){
        return (
            <TouchableOpacity style={styles.container}>
                <View>
                    <Text style={{color: this.props.data.titleColor, fontSize: 20}}>{this.props.data.title}</Text>
                    <Text style={{color: 'gray', marginTop: 4}}>{this.props.data.subTitle}</Text>
                </View>
                <Image source={{uri: this.props.data.rightImage}} style={styles.rightImgStyle}/>
            </TouchableOpacity>
        )
    },
});

const styles = StyleSheet.create({
    container: {
        backgroundColor: 'white',
        flexDirection: 'row',
        width: width * 0.5,
        height: 65,
        marginBottom: 1,
        alignItems: 'center',
        justifyContent: 'space-between',
        paddingLeft: 9,
        paddingRight: 9

    },
    rightImgStyle: {
        width: 80,
        height: 40,
        resizeMode: 'contain'
    }
});

module.exports = HomeCommonView
