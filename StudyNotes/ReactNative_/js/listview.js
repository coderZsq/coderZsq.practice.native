import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image,
  ListView
} from 'react-native';

var _ListView = React.createClass({

    getInitialState(){
        var ds = new ListView.DataSource({
            rowHasChanged:(r1, r2) => r1 !== r2
        });

        return {
            dataSource: ds.cloneWithRows(['第1行','第2行', '第3行', '第4行', '第5行'])
        }
    },

    render(){
        return (
            <ListView
                dataSource={this.state.dataSource}
                renderRow={(rowData)=>this.renderRow(rowData)}
            />
        )
    },

    renderRow(rowData) {
        return (
            <View>
                <Text>{rowData}</Text>
            </View>
        );
    }
});

const styles = StyleSheet.create({

});

module.exports = _ListView
