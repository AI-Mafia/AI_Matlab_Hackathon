import React, { useState } from 'react';
import { View, TextInput, Button, StyleSheet } from 'react-native';

const Form = ({ setFormData }) => {
  const [name, setName] = useState('');
  const [gender, setGender] = useState('');
  const [height, setHeight] = useState('');
  const [age, setAge] = useState('');
  const [weight, setWeight] = useState('');

  const handleSubmit = () => {
    setFormData({
      name: name,
      gender: gender,
      height: parseFloat(height),
      age: parseInt(age),
      weight: parseFloat(weight),
    });

    // Do something with the form data (e.g., submit to a server)

    // Reset form fields
    setName('');
    setGender('');
    setHeight('');
    setAge('');
    setWeight('');
  };

  return (
    <View style={styles.container}>
      <TextInput
        style={styles.input}
        placeholder="Name"
        value={name}
        onChangeText={text => setName(text)}
      />
      <TextInput
        style={styles.input}
        placeholder="Gender"
        value={gender}
        onChangeText={text => setGender(text)}
      />
      <TextInput
        style={styles.input}
        placeholder="Height"
        value={height}
        onChangeText={text => setHeight(text)}
        keyboardType="numeric"
      />
      <TextInput
        style={styles.input}
        placeholder="Age"
        value={age}
        onChangeText={text => setAge(text)}
        keyboardType="numeric"
      />
      <TextInput
        style={styles.input}
        placeholder="Weight"
        value={weight}
        onChangeText={text => setWeight(text)}
        keyboardType="numeric"
      />
      <Button title="Submit" onPress={handleSubmit} style={styles.button} />
    </View>
  );
};

const styles = StyleSheet.create({
    container: {
    //   flex: 1,
      padding: 20,
      backgroundColor: '#ffffff',
    },
    input: {
        width: 200,
      borderWidth: 1,
      borderColor: '#ccc',
      borderRadius: 5,
      padding: 10,
      marginBottom: 10,
    },
    button: {
      backgroundColor: 'blue',
      paddingVertical: 10,
      borderRadius: 5,
    },
    buttonText: {
      color: 'white',
      fontSize: 16,
      fontWeight: 'bold',
      textAlign: 'center',
    },
  });

export default Form;
