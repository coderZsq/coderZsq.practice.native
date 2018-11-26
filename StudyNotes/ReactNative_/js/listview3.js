import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image,
  ListView
} from 'react-native';

var dataSourceArr = require('../data/listview3.json')

var _ListView3 = React.createClass({

    getInitialState(){
        var getSectionData = (dataBlob, sectionID) => {
            return dataBlob[sectionID]
        };
        var getRowData = (dataBlob, sectionID, rowID) => {
            return dataBlob[sectionID + ':' + rowID]
        };
        return {
            dataSource: new ListView.DataSource({
                rowHasChanged:(r1, r2) => r1 !== r2,
                sectionHeaderHasChanged: (s1, s2) => s1 !== s2,
                getSectionData: getSectionData,
                getRowData: getRowData
            })
        }
    },

    render(){
        return (
            <View style={styles.container}>
                <ListView
                    dataSource={this.state.dataSource}
                    renderSectionHeader={this.renderHeader}
                    renderRow={this.renderRow}
                    >
                </ListView>
            </View>
        )
    },

    renderHeader(sectionData){
        return (
            <View style={{backgroundColor: 'gray'}}>
                <Text style={{color: 'red', fontSize:16}}>{sectionData}</Text>
            </View>
        )
    },

    renderRow(rowData, sectionID, rowID){
        return (
            <View style={{borderBottomColor:'#e8e8e8', borderBottomWidth:1}}>
                <Image source={require('../img/Castiel.jpg')} style={styles.cellImageStyle}/>
                <Text>{rowData.text}</Text>
            </View>
        )
    },

    componentDidMount(){
        var jsonData = dataSourceArr;
        var dataBlob = {},
            sectionIDs = [],
            rowIDs = [],
            groups = [];

        for (var i = 0; i < jsonData.length; i++) {
            var item = jsonData[i];
            sectionIDs.push(i);
            dataBlob[i] = item.title;
            groups = item.groups;
            rowIDs[i] = [];
            for (var j = 0; j < groups.length; j++) {
                rowIDs[i].push(j);
                dataBlob[i + ":" + j] = groups[j];
            }
        }
        this.setState({
            dataSource: this.state.dataSource.cloneWithRowsAndSections(dataBlob, sectionIDs, rowIDs)
        });
    }
});

const styles = StyleSheet.create({
    container: {
        flex: 1
    },
    cellImageStyle: {
        width: 80,
        height: 80,
        margin: 7,
        resizeMode: 'contain'
    }
});

module.exports = _ListView3
