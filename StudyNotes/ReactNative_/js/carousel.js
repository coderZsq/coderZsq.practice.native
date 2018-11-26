import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  ScrollView,
  Image
} from 'react-native';

var Dimensions = require('Dimensions');
var screenWidth = Dimensions.get('window').width;
var TimerMixin = require('react-timer-mixin');

var Carousel = React.createClass({

    mixins: [TimerMixin],

    getDefaultProps() {
        return {
            durationTime: 1000,
            imageData: []
        }
    },

    getInitialState() {
        return {
            selectedPage: 0
        }
    },

    render() {
        return (
            <View style={{marginTop: 20}}>
                <ScrollView
                    ref="scrollview"
                    horizontal={true}
                    pagingEnabled={true}
                    showsHorizontalScrollIndicator={false}
                    onMomentumScrollEnd={(e)=>this.onPageScrollEnd(e)}
                    onScrollBeginDrag={()=>this.clearTimer()}
                    onScrollEndDrag={()=>this.startTime()}>
                    {this.renderImgItem()}
                </ScrollView>
                <View style={styles.indicatorViewStyle}>
                    {this.renderIndicatorItem()}
                </View>
            </View>
        )
    },

    componentDidMount() {
        this.startTime();
    },

    startTime() {
        var scrollview = this.refs.scrollview;
        this.timer = this.setInterval(function() {
            var activePage;
            if (this.state.selectedPage + 1 >= this.props.imageData.length) {
                activePage = 0;
            } else {
                activePage = this.state.selectedPage + 1;
            }
            this.setState({
                selectedPage: activePage
            });
            var offsetX = activePage * screenWidth;
            scrollview.scrollResponderScrollTo({x: offsetX, y: 0, animated: true});
        }, this.props.durationTime);
    },

    clearTimer() {
        this.clearInterval(this.timer);
    },

    renderImgItem() {
        var imgItemArr = []
        for (var i = 0; i < this.props.imageData.length; i++) {
            var item = this.props.imageData[i];
            imgItemArr.push(
                <Image key={i} source={require('../img/Castiel.jpg')} style={styles.imgStyle}/>
            );
        }
        return imgItemArr;
    },

    renderIndicatorItem() {
        var indicatorItemArr = [], style;
        for (var i = 0; i < this.props.imageData.length; i++) {
            style = (i === this.state.selectedPage) ? {color: 'orange'} : {color : 'white'};
            var item = this.props.imageData[i];
            indicatorItemArr.push(
                <Text key={i} style={[{fontSize: 25}, style]}>&bull;</Text>
            );
        }
        return indicatorItemArr;
    },

    onPageScrollEnd(e) {
        // alert(e);
        var offsetX = e.nativeEvent.contentOffset.x;
        var currentPage = offsetX / screenWidth;
        this.setState({
            selectedPage: currentPage
        })
    }
});


const styles = StyleSheet.create({
    imgStyle: {
        width: screenWidth,
        height: 180
    },
    indicatorViewStyle: {
        backgroundColor: 'rgba(0, 0, 0, 0.1)',
        flexDirection: 'row',
        position: 'absolute',
        justifyContent: 'center',
        left: 0,
        bottom: 0,
        width: screenWidth
    }
});

module.exports = Carousel;
