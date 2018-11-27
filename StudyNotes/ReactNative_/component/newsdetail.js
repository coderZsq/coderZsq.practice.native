import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image,
  WebView
} from 'react-native';

var NewsDetail = React.createClass({

    getInitialState(){
        return {
            html: '正在加载网页~'
        }
    },

    render(){
        return (
            <WebView
                automaticallyAdjustContentInsets={false}
                source={{html: this.state.html, baseUrl: ''}}
                javascriptEnabled={true}
                domStorageEnabled={true}
                startInLoadingState={true}
            />
        )
    },

    componentDidMount(){
        var url_api = 'http://c.m.163.com/nc/article/' + this.props.docid + '/full.html'
        fetch(url_api)
        .then((response)=>response.json())
        .then((responseData)=>{
            var allData = responseData[this.props.docid];
            var body = allData['body'];
            var img = allData['img'];
            if (img.length === 0) return;
            for (var i = 0; i < img.length; i++) {
                var item = img[i];
                var src = item.src;
                var ref = item.ref;
                var imgHtml = '<img src="' + src + '" width=100%/>';
                body = body.replace(ref, imgHtml);
            }
            this.setState({
                html: body
            })
        });
    }
});

const styles = StyleSheet.create({

});

module.exports = NewsDetail
