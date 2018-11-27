import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image,
  TouchableOpacity,
  ListView
} from 'react-native';

var Dimensions = require('Dimensions');
var screenHeight = Dimensions.get('window').height;
var screenWidth = Dimensions.get('window').width;

var ScrollImg = require('./scrollimg')
var NewsDetail = require('./newsdetail')

var Home = React.createClass({

    getDefaultProps(){
        return {
            api_url: 'http://c.m.163.com/nc/article/headline/T1348647853363/0-20.html?from=toutiao&fn=1&prog=LTitleA&passport=&devId=nTM86EPlcxZu09VdpTEh6aR3%2B%2FQX6x8vHBD3ne3k5bbgOrg%2FIP5DcguSDmtYyWbs&offset=0&size=20&version=14.0&spever=false&net=wifi&lat=DUH4Hf95lyIDaAI03C3RSA%3D%3D&lon=HJ4tj6FL5wRHQxcf5GLEcg%3D%3D&ts=1470728804&sign=1H8K3yy9bMXakmxAlZ9P86meraJtjKQFz5vJuwhjNyl48ErR02zJ6%2FKXOnxX046I&encryption=1&canal=appstore',
            keyWord: 'T1348647853363'
        }
    },

    getInitialState(){
        var ds = new ListView.DataSource({
            rowHasChanged:(r1, r2) => r1 !== r2
        });
        return {
            dataSource: ds.cloneWithRows(['正在请求网络数据~']),
            scrollImg: []
        }
    },

    render(){
        // console.log(screenHeight, screenWidth);
        return (
            <ListView
                automaticallyAdjustContentInsets={false}
                dataSource={this.state.dataSource}
                renderRow={this.renderRow}
                renderHeader={this.renderHeader}
            />
        )
    },

    renderHeader(){
        if (this.state.scrollImg === undefined) return;
        return (
            <ScrollImg imgData={this.state.scrollImg}/>
        )
    },

    renderRow(rowData){
        if (rowData === '正在请求网络数据~' || rowData === undefined) {
            return (
                <View style={styles.loadingViewStyle}>
                    <Image source={require('../img/tableview_loading.png')}/>
                    <Text style={{color: 'orange', fontSize: 16}}>{rowData}</Text>
                </View>
            )
        } else {
            return (
                <TouchableOpacity style={styles.cellStyle} onPress={()=>this.pushToNewsDetail(rowData.docid)}>
                    <Image source={{uri: rowData.imgsrc}} style={styles.imgStyle}/>
                    <View style={styles.rightViewStyle}>
                        <Text style={{fontSize: 15, fontWeight: 'bold'}}>{rowData.title}</Text>
                        <View style={styles.bottomViewStyle}>
                            <Text style={{fontSize: 13, color: 'red'}}>{rowData.recReason}</Text>
                            <Text style={{fontSize: 13}}>{rowData.replyCount+'跟贴'}</Text>
                        </View>
                    </View>
                </TouchableOpacity>
            )
        }
    },

    // 请求网络数据
    componentDidMount(){
        this.loadDataFromNet()
    },

    loadDataFromNet(){
        fetch(this.props.api_url)
        .then((response)=>response.json())
        .then((responseData)=>{
            var listArr = [],
                imgsArr = [];
            var dataArr = responseData[this.props.keyWord];
            for (var i = 0; i < dataArr.length; i++) {
                var item = dataArr[i];
                if (item.hasHead == 1) {
                    imgsArr = item.ads;
                } else {
                    listArr.push(item);
                }
            }
            this.setState({
                dataSource: this.state.dataSource.cloneWithRows(listArr),
                scrollImg: imgsArr
            });
        })
    },
    pushToNewsDetail(docid){
        this.props.navigator.push({
            title: '详情页',
            component: NewsDetail,
            passProps:{docid}
        });
    }
});

const styles = StyleSheet.create({
    bottomViewStyle: {
        flexDirection: 'row',
        justifyContent: 'space-between'
    },
    cellStyle: {
        flexDirection: 'row',
        borderBottomWidth: 1,
        borderBottomColor: '#e8e8e8'
    },
    loadingViewStyle: {
        flex: 1,
        // justifyContent: 'center',
        alignItems: 'center',
        height: screenHeight,
        backgroundColor: '#e8e8e8'
    },
    rightViewStyle: {
        flex: 1,
        paddingRight: 8,
        // paddingTop: 10,
        justifyContent: 'space-around'
    },
    imgStyle: {
        width: 120,
        height: 90,
        margin: 10,
        // resizeMode: 'contain'
        backgroundColor: '#e8e8e8'
    }
});

module.exports = Home
