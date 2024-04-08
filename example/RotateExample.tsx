import { View, Text, Image, ScrollView } from 'react-native'
import React from 'react'
import ClipPath from '@react-native-oh-tpl/clip-path'
import { myPath2,myPath3, myPath10, myPath11, myPath12 } from './paths'

export default function index() {
  const viewBox = [0, 0, 400, 400]
  const path = myPath12

  return (
    <ScrollView style={{ width: '100%', height: '100%'}}>
      <Text>rot: 0</Text>
      <ClipPath rot={0} viewBox={viewBox} d={myPath10} fill="#f00" style={{ width: 200, height: 100, backgroundColor: '#ff0' }}>
        <Text>MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM</Text>
      </ClipPath>
      <Text>--------------------------------------------</Text>
      <Text>rot: 30</Text>
      <ClipPath rot={30} viewBox={viewBox} d={myPath10} fill="#f00" style={{ width: 200, height: 100, backgroundColor: '#ff0' }}>
        <Text>MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM</Text>
      </ClipPath>
      <Text></Text><Text></Text><Text></Text>
      <Text>--------------------------------------------</Text>
      <Text>rot: 45, rotOx: 200, rotOy: 200</Text>
      <Text></Text><Text></Text><Text></Text>
      <ClipPath rot={45} rotOx={200} rotOy={200} viewBox={viewBox} d={myPath10} fill="#f00" style={{ width: 200, height: 100, backgroundColor: '#ff0' }}>
        <Text>MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM</Text>
      </ClipPath>
      <Text></Text><Text></Text><Text></Text>
      <Text>--------------------------------------------</Text>
      <Text>rot: 45, rotOx: 50, rotOy: 50, rotPercentageValue: true</Text>
      <Text></Text><Text></Text><Text></Text>
      <ClipPath rot={45} rotOx={50} rotOy={50} rotPercentageValue={true} viewBox={viewBox} d={myPath10} fill="#f00" style={{ width: 200, height: 100, backgroundColor: '#ff0' }}>
        <Text>MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM</Text>
      </ClipPath>
      <Text></Text><Text></Text><Text></Text>
    </ScrollView>
  )
}