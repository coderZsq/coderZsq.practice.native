import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image,
  ScrollView
} from 'react-native';

var Dimensions = require('Dimensions');
var {width, height} = Dimensions.get('window')

import HomeTopListView from './hometoplistview'

var HomeTopMenu = React.createClass({

    getDefaultProps(){
        return {
            data: []
        }
    },

    getInitialState(){
        return {
            selectedIndicator: 0
        }
    },

    render(){
        return (
            <View style={styles.container}>
                <ScrollView
                    pagingEnabled={true}
                    showHorizontalScrollIndicator={false}
                    horizontal={true}
                    onMomentumScrollEnd={this.pageScrollEnd}
                >
                    {this.renderScrollItem()}
                </ScrollView>
                <View style={styles.bottomViewStyle}>
                    {this.renderIndicatorItem()}
                </View>
            </View>
        )
    },

    pageScrollEnd(e){
        var offsetX = e.nativeEvent.contentOffset.x;
        var currentPage = Math.round(offsetX / width);
        this.setState({
            selectedIndicator: currentPage
        })
    },

    renderIndicatorItem(){
        var itemArr = [], style;
        for (var i = 0; i < 2; i++) {
            style = this.state.selectedIndicator === i ? {color: 'orange'} : {color: 'gray'}
            itemArr.push(
                <Text key={i} style={[{fontSize: 25}, style]}>&bull;</Text>
            )
        }
        return itemArr
    },

    renderScrollItem(){
        var dataArr = this.props.data;
        var itemArr = [];
        for (var i = 0; i < dataArr.length; i++) {
            itemArr.push(
                <HomeTopListView data={dataArr[i]} key={i}/>
            );
        }
        return itemArr
    }
});

const styles = StyleSheet.create({
    container: {
        backgroundColor: 'white'
    },
    bottomViewStyle: {
        flexDirection: 'row',
        justifyContent: 'center'
    }
});

module.exports = HomeTopMenu
