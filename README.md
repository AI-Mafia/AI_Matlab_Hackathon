# MATALAB AI HACKATHON

### How to run the mobile application
You must download the Expo Go mobile application.

```
cd app
npm install
expo start
```

Scan the QR code with your mobile.

### Expectations
We built a full-stack mobile application that gets user data from the front-end, including all the needed sensor data.
The mobile application sends the data to an API on the server and that server runs the different models to get an output
and return it to the user to be shown on the front-end.

### Reality
We managed to build all the individual pieces of this pipeline. Front-end in the app folder, back-end in the server folder and
the models, including the data preprocessing scripts are in the model folder. Unfortunately, we did not have any time to connect
all the pieces together.
