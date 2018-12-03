import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image,
  ListView,
  TouchableOpacity
} from 'react-native';

var GuestYouLikeListView = React.createClass({

    getDefaultProps(){
        return {
            api_url: 'http://api.meituan.com/group/v1/recommend/homepage/city/1?__skck=40aaaf01c2fc4801b9c059efcd7aa146&__skcy=mrUZYo7999nH8WgTicdfzaGjaSQ=&__skno=51156DC4-B59A-4108-8812-AD05BF227A47&__skts=1434530933.303717&__skua=bd6b6e8eadfad15571a15c3b9ef9199a&__vhost=api.mobile.meituan.com&ci=1&client=iphone&limit=40&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-06-17-14-50363&offset=0&position=39.982223,116.310502&userId=10086&userid=10086&utm_campaign=AgroupBgroupD100Fab_chunceshishuju__a__a___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_gxhceshi0202__b__a___ab_pindaochangsha__a__leftflow___ab_xinkeceshi__b__leftflow___ab_gxtest__gd__leftflow___ab_gxh_82__nostrategy__leftflow___ab_pindaoshenyang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_b_food_57_purepoilist_extinfo__a__a___ab_trip_yidizhoubianyou__b__leftflow___ab_i_group_5_3_poidetaildeallist__a__b___ab_waimaizhanshi__b__b1___a20141120nanning__m1__leftflow___ab_pind'
        }
    },

    getInitialState(){
        var ds = new ListView.DataSource({
            rowHasChanged: (r1, r2) => r1 !== r2
        })
        return {
            dataSource: ds.cloneWithRows([''])
        }
    },

    render(){
        return (
            <ListView
                dataSource={this.state.dataSource}
                renderRow={this.renderRow}
            />
        )
    },

    renderRow(rowData){
        return (
            <TouchableOpacity style={styles.rowStyle}>
                <Image
                    defaultSource={{uri: 'bg_merchant_photo_placeholder_big'}}
                    source={{uri: this.dealImgWithUrl(rowData.imgurl)}}
                    style={styles.imgStyle}/>
                <View style={styles.rightViewStyle}>
                    <Text numberOfLine={1} style={{color: 'red', fontSize: 15}}>{rowData.brandname}</Text>
                    <Text numberOfLine={2}>{rowData.mtitle}</Text>
                    <Text style={styles.rightInfoStyle}>{rowData.dt + 'km'}</Text>
                    <Text>{'¥' + rowData.price}</Text>
                </View>
            </TouchableOpacity>
        )
    },

    dealImgWithUrl(url){
        if (url == undefined) {
            return url;
        }
        var wh = 'w.h';
        var replaceUrl;
        if (url.search(wh) !== -1) {
            replaceUrl = url.replace(wh, '120.90');
        }
        return replaceUrl;
    },

    componentDidMount(){
        this.loadDataFromNet();
    },

    loadDataFromNet(){
        fetch(this.props.api_url)
        .then((response) => response.json())
        .then((responseData) => {
            this.setState({
                dataSource: this.state.dataSource.cloneWithRows(responseData.data)
            })
        })
    }
});

const styles = StyleSheet.create({
    rightInfoStyle: {
        position: 'absolute',
        right: 0,
        top: 0,
        backgroundColor: 'rgba(0,0,0,0)'
    },
    rowStyle: {
        backgroundColor: 'white',
        borderBottomColor: '#e8e8e8',
        borderBottomWidth: 1,
        flexDirection: 'row',
        padding: 7
    },
    imgStyle: {
        width: 120,
        height: 90,
        borderRadius: 5,
        marginRight: 5
    },
    rightViewStyle: {
        flex: 1,
        justifyContent: 'space-around'
    }
});

module.exports = GuestYouLikeListView
