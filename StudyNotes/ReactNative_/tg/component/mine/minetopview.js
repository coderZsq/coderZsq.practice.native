import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image,
  TouchableOpacity,
  Platform
} from 'react-native';

var Dimensions = require('Dimensions');
var {width, height} = Dimensions.get('window')

var MineTopView = React.createClass({

    getDefaultProps(){
        return {
            data: {}
        }
    },

    render(){
        var personData = this.props.data.personData;
        return (
            <View style={styles.container}>
                <View style={styles.topViewStyle}>
                    <View style={{flexDirection: 'row', alignItems: 'center'}}>
                        <Image source={require('../../../img/Castiel.jpg')} style={styles.iconStyle}/>
                        <Text style={styles.titleStyle}>{personData.personName}</Text>
                        <Image source={require('../../img/avatar_vip.png')} style={styles.rankStyle}/>
                    </View>
                    <Image source={require('../../img/icon_cell_rightarrow.png')}/>
                </View>
                <View style={styles.bottomViewStyle}>
                    {this.renderBottomView()}
                </View>
            </View>
        )
    },

    renderBottomView(){
        var itemArr = [];
        var orderData = this.props.data.orderData;
        for (var i = 0; i < orderData.length; i++) {
            var item = orderData[i];
            itemArr.push(
                <TouchableOpacity key={i} style={styles.innerViewStyle}>
                    <Text style={{color: 'white', fontSize: 15}}>{item.number}</Text>
                    <Text style={{color: 'white', marginTop: 4, fontSize: 15}}>{item.name}</Text>
                </TouchableOpacity>
            );
        }
        return itemArr;
    }
});

const styles = StyleSheet.create({
    container: {
        backgroundColor: 'rgba(255, 96, 0, 0.7)',
        height: Platform.OS === 'ios' ? 500 : 200
    },
    topViewStyle: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        paddingLeft: 8,
        paddingRight: 8,
        paddingTop: Platform.OS === 'ios' ? 340 : 40,
        alignItems: 'center'
    },
    bottomViewStyle: {
        flexDirection: 'row',
        backgroundColor: 'rgba(255, 255, 255, 0.4)',
        position: 'absolute',
        bottom: 0,
        left: 0,
        paddingTop: 8,
        paddingBottom: 8,
        width: width
    },
    titleStyle: {
        marginLeft: 5,
        marginRight: 5,
        fontSize: 18,
        color: 'white',
        fontWeight: 'bold'
    },
    innerViewStyle: {
        width: width / 3 + 1,
        justifyContent: 'center',
        alignItems: 'center',
        borderRightWidth: 1,
        borderRightColor: 'white'
    },
    iconStyle: {
        width: 80,
        height: 80,
        borderRadius: 40
    },
    rankStyle: {
        width: 17,
        height: 17
    }
});

module.exports = MineTopView
