import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image,
  ListView,
  TouchableOpacity
} from 'react-native';

var dataSourceArr = require('../data/listview2.json')

var _ListView2 = React.createClass({

    getInitialState(){
        var ds = new ListView.DataSource({
            rowHasChanged:(r1, r2) => r1 !== r2
        });

        return {
            dataSource: ds.cloneWithRows(dataSourceArr)
        }
    },

    render(){
        return (
            <ListView
                dataSource={this.state.dataSource}
                renderRow={(rowData, sectionID, rowID)=>this.renderRow(rowData, sectionID, rowID)}
            />
        )
    },

    renderRow(rowData, sectionID, rowID) {
        return (
            <TouchableOpacity style={styles.cellStyle} onPress={()=>{alert('点击了第' + sectionID + '组中的第' + rowID + '行')}}>
                <Image source={require('../img/Castiel.jpg')} style={styles.cellImgStyle}/>
                <View style={styles.rightViewStyle}>
                    <Text style={{color: '#333', fontSize: 15}}>{rowData.title}</Text>
                    <Text numberOfLines={2} style={{color: 'gray', fontSize: 12}}>{rowData.desc}</Text>
                </View>
            </TouchableOpacity>
        );
    }
});

const styles = StyleSheet.create({
    rightViewStyle: {
        justifyContent: 'center',
        width: 300
    },
    cellStyle: {
        borderBottomWidth: 1,
        borderBottomColor: '#e8e8e8',
        flexDirection: 'row',
        margin: 5
    },
    cellImgStyle: {
        width: 60,
        height: 60,
        resizeMode: 'contain'
    }
});

module.exports = _ListView2
