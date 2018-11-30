import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image,
  ListView,
  TouchableOpacity
} from 'react-native';

var Dimensions = require('Dimensions');
var {width, height} = Dimensions.get('window')

var HomeTopListView = React.createClass({

    getDefaultProps(){
        return {
            data: {}
        }
    },

    getInitialState(){
        var ds = new ListView.DataSource({
            rowHasChanged: (r1, r2) => r1 !== r2
        });
        return {
            dataSource: ds.cloneWithRows(this.props.data)
        }
    },

    render(){
        return (
            <ListView
                dataSource={this.state.dataSource}
                renderRow={this.renderRow}
                contentContainerStyle={styles.listViewStyle}
                scrollEnabled={false}
            />
        )
    },

    renderRow(rowData){
        return (
            <TouchableOpacity style={styles.cellViewStyle}>
                <Image source={{uri: rowData.image}} style={styles.imgStyle}/>
                <Text style={{color: 'gray', fontSize: 12}}>{rowData.title}</Text>
            </TouchableOpacity>
        )
    }
});

const cols = 5;
const boxWidth = 64;
const vMargin = (width - cols * boxWidth) / (cols + 1);
const hMargin = 9;

const styles = StyleSheet.create({
    imgStyle: {
        width: boxWidth - 4,
        height: boxWidth - 4,
        borderRadius: boxWidth / 2
    },
    listViewStyle: {
        flexDirection: 'row',
        flexWrap: 'wrap',
        width: width
    },
    cellViewStyle: {
        width: boxWidth,
        height: boxWidth + 20,
        marginLeft: vMargin,
        marginTop: hMargin,
        justifyContent: 'center',
        alignItems: 'center'
    }
});

module.exports = HomeTopListView
