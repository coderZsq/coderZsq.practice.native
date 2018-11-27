import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image
} from 'react-native';
import  Swiper from 'react-native-swiper'

var ScrollImg = React.createClass ({

    getDefaultProps(){
        return {
            imgData: []
        }
    },

    render(){
        return (
            <Swiper style={styles.wrapper} height={200} horizontal={false} autoplay>
                {this.renderImg()}
            </Swiper>
        );
    },

    renderImg(){
        var itemArr = [];
        for (var i = 0; i < this.props.imgData.length; i++) {
            var item = this.props.imgData[i]
            console.log(item);
            itemArr.push(
                <Image key={i} source={{uri: 'https://i1.wp.com/acrosoft.co.uk/wp-content/uploads/jOwfoMVPYQgmaxresdefault.jpg?fit=1280%2C720&ssl=1'}} style={{flex: 1}}/>
            );
        }
        return itemArr;
    }
})

const styles = StyleSheet.create({
    wrapper: {
    },
})

module.exports = ScrollImg;
