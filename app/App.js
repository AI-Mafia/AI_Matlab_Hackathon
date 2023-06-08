import React, { useState, useEffect } from 'react';
import { StatusBar } from 'expo-status-bar';
import { StyleSheet, Text, TouchableOpacity, View } from 'react-native';
import { Accelerometer } from 'expo-sensors';
import { Gyroscope } from 'expo-sensors';
import Form from './Form';

export default function App() {

  // formdata
  const [formdata, setFormData] = useState({})

  // accelerometer data
  const [accelerometerData, acc_setData] = useState({
    x: 0,
    y: 0,
    z: 0,
  });
  const [acc_subscription, acc_setSubscription] = useState(null);

  // gyroscope data
  const [gyroscopeData, gyro_setData] = useState({
    x: 0,
    y: 0,
    z: 0,
  });
  const [gyro_subscription, gyro_setSubscription] = useState(null);

  const [isRecording, setIsRecording] = useState(false)
  const [recordedData, setRecordedData] = useState({
    accelerometer: {
      x: [],
      y: [],
      z: []
    },
    gyroscope: {
      x: [],
      y: [],
      z: []
    },
    timestamp: [],
  })

  const _slow = () => Accelerometer.setUpdateInterval(200);
  const _fast = () => Accelerometer.setUpdateInterval(200);

  const getTimestamp = () => {
    return new Date().getTime()
  }

  const [x, setX] = useState([])

  const _subscribe = () => {
 
    acc_setSubscription(
      Accelerometer.addListener( async({x , y , z , }) => {
        setRecordedData((prev) => ({
          ...prev,
          accelerometer: {
            x: [...prev.accelerometer.x, x],
            y: [...prev.accelerometer.y, y],
            z: [...prev.accelerometer.z, z],
          },
          timestamp: [...prev.timestamp, getTimestamp()],
        }))
      })
    );

    gyro_setSubscription(
      Gyroscope.addListener( async({x , y , z , }) => {
        setRecordedData((prev) => ({
          ...prev,
          gyroscope: {
            x: [...prev.gyroscope.x, x],
            y: [...prev.gyroscope.y, y],
            z: [...prev.gyroscope.z, z],
          },
        }))
      })
    )
  };

  const onRecord = (value) => {
    setIsRecording(value);

    if (value) {
      console.log('started recording')
      setRecordedData({
        accelerometer: {
          x: [],
          y: [],
          z: []
        },
        gyroscope: {
          x: [],
          y: [],
          z: []
        },
        timestamp: [],
      })

      _subscribe();
    }
    else {
      console.log(recordedData)
      _unsubscribe();
      // make api calls

      sendRecordedData();
    }
  }

  const _unsubscribe = () => {
    acc_subscription && acc_subscription.remove();
    acc_setSubscription(null);

    gyro_subscription && gyro_subscription.remove();
    gyro_setSubscription(null);
  };

  const sendRecordedData = () => {
    console.log(JSON.stringify(recordedData));
    fetch('https://a14c-2001-648-2000-e9-8dd0-992-2024-e202.ngrok-free.app/post', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        sensordata: recordedData,
        userdata: formdata,
      })
    })
      .then(response => console.log(response));
      // .then(data => console.log(data));
  }

  const test = () => {
    const resp = fetch('https://a14c-2001-648-2000-e9-8dd0-992-2024-e202.ngrok-free.app/')
      .then(response => response.json())
      .then(data => console.log(data));
  }

  useEffect(() => {
    Accelerometer.setUpdateInterval(200);
    Gyroscope.setUpdateInterval(200);
    // _subscribe();
    // return () => _unsubscribe();
  }, []);
  
  return (
    <View style={styles.container}>
      {/* <Text>Accelerometer: (in gs where 1g = 9.81 m/s^2)</Text> */}
      {/* <Text>x: {recordedData.accelerometer.x[recordedData.accelerometer.x.length - 1]}</Text>
      <Text>y: {recordedData.accelerometer.y[recordedData.accelerometer.y.length - 1]}</Text>
      <Text>z: {recordedData.accelerometer.z[recordedData.accelerometer.z.length - 1]}</Text>
      <Text>Gyroscope:</Text>
      <Text>x: {recordedData.gyroscope.x[recordedData.gyroscope.x.length - 1]}</Text>
      <Text>y: {recordedData.gyroscope.y[recordedData.gyroscope.y.length - 1]}</Text>
      <Text>z: {recordedData.gyroscope.z[recordedData.gyroscope.z.length - 1]}</Text> */}
      <Form setFormData={setFormData} />
      <TouchableOpacity onPress={() => onRecord(!isRecording)} style={styles.button}>
        <Text style={styles.buttonText}>Record</Text>
      </TouchableOpacity>
      {/* <TouchableOpacity onPress={sendRecordedData}>
        <Text>Test</Text>
      </TouchableOpacity> */}

      <StatusBar style="auto" />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
  button: {
    backgroundColor: 'blue',
    paddingVertical: 10,
    paddingHorizontal: 20,
    borderRadius: 5,
  },
  buttonText: {
    color: 'white',
    fontSize: 16,
    fontWeight: 'bold',
    textAlign: 'center',
  },
});
