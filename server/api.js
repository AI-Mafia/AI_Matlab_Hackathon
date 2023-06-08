import fs from "fs";
import express from 'express';
import bodyParser from 'body-parser';
import { createObjectCsvWriter } from "csv-writer";
import { exec } from "child_process";

const app = express();
app.use(bodyParser.json());

app.get('/', (req, res) => {
    res.send({ message: 'hello world' });
    }
);

app.post('/post', async (req, res) => {
    // console.log(req.body);

    const records = []

    console.log(req.body.userdata)
    const name = req.body.userdata.name;

    // fs.mkdir(`${name}`)
    // fs.writeFileSync(`${name}/${name}_user_data.json`, JSON.stringify(req.body.userdata));

    console.log('ok')

    for (let i = 0; i < req.body.sensordata.timestamp.length; i++) {
        records.push({
            timestamp: req.body.timestamp[i],
            acc_x: req.body.accelerometer.x[i],
            acc_y: req.body.accelerometer.y[i],
            acc_z: req.body.accelerometer.z[i],
            gyro_x: req.body.gyroscope.x[i],
            gyro_y: req.body.gyroscope.y[i],
            gyro_z: req.body.gyroscope.z[i],
        })
    }

    const csvWriter = createObjectCsvWriter({
        path: `${name}/${name}_sensor_data.csv`,
        header: [
            { id: 'acc_x', title: 'Accel_X' },
            { id: 'acc_y', title: 'Accel_Y' },
            { id: 'acc_z', title: 'Accel_Z' },
            { id: 'gyro_x', title: 'Gyro_X' },
            { id: 'gyro_y', title: 'Gyro_Y' },
            { id: 'gyro_z', title: 'Gyro_Z' },
            { id: 'timestamp', title: 'Time' },
        ]
    });

    csvWriter.writeRecords(records)
        .then(() => console.log('The CSV file was written successfully'))

    // run matlab code
    const command = `/Applications/MATLAB_R2022b.app/bin/matlab -nodesktop -nodisplay -nosplash -r "run('/Users/yiannis/work/projects/contests/ai_matlab_hackathon/test.m'); exit;"`
    exec(command, (err, stdout, stderr) => {
        console.log(stdout)
    });


    res.sendStatus(200);
})

app.listen(80);