# Experiment Factory Stroop Container

![https://expfactory.github.io/expfactory/img/expfactoryticketyellow.png](https://expfactory.github.io/expfactory/img/expfactoryticketyellow.png)

This is an automated build to generate a stroop task container, including the following Expfactory experiments:

 - [stroop](https://www.github.com/expfactory-experiments/stroop)
 - [stroop-5min](https://www.github.com/expfactory-experiments/stroop-5min)

It is intended for [this study](https://osf.io/9pc46/) registered on OSF. 
It is generated by way of the [expfactory builder](https://expfactory.github.io/builder) by writing the names of these
library experiments into the [experiments.txt](experiments.txt) file here, and then being built and deployed to Docker
Hub via this circle CI workflow:

[![CircleCI](https://circleci.com/gh/expfactory-containers/container-stroop.svg?style=svg)](https://circleci.com/gh/expfactory-containers/container-stroop)


## Usage
You can run the container as follows: 

```
docker run -d -p 80:80 vanessa/expfactory-container-stroop start
```

and you will see the familiar interface to choose your task and get started. [There are many ways to deploy](https://expfactory.github.io/expfactory/usage). depending on your needs for a database and experiment selection. 


## Data Analysis

An example to run and analyze an analysis is provided in [analysis](analysis).

As an example, the container was run to deploy the two tasks, and save data to a local folder on
the filesystem at `/tmp/data`:


```bash
$ docker run -p 80:80 -v /tmp/data:/scif/data vanessa/expfactory-container-stroop start
...
Database set as filesystem
Starting Web Server

 * Starting nginx nginx
   ...done.
==> /scif/logs/gunicorn-access.log <==

==> /scif/logs/gunicorn.log <==
[2018-07-22 14:17:05 +0000] [1] [INFO] Starting gunicorn 19.9.0
[2018-07-22 14:17:05 +0000] [1] [INFO] Listening at: http://0.0.0.0:5000 (1)
[2018-07-22 14:17:05 +0000] [1] [INFO] Using worker: sync
[2018-07-22 14:17:05 +0000] [34] [INFO] Booting worker with pid: 34
WARNING No user experiments selected, providing all 2
[2018-07-22 14:17:27,361] INFO in general: New session [subid] expfactory/87f6a6f3-b459-4540-a147-c8b839b55dee
[2018-07-22 14:17:27,385] INFO in utils: [router] None --> stroop [subid] expfactory/87f6a6f3-b459-4540-a147-c8b839b55dee [user] participant-name
[2018-07-22 14:17:30,193] DEBUG in main: Next experiment is stroop
[2018-07-22 14:17:30,193] INFO in utils: [router] stroop --> stroop [subid] expfactory/87f6a6f3-b459-4540-a147-c8b839b55dee [user] participant-name
[2018-07-22 14:17:30,194] DEBUG in utils: Redirecting to /experiments/stroop
[2018-07-22 14:17:30,214] DEBUG in utils: Rendering experiments/experiment.html
[2018-07-22 14:25:07,076] DEBUG in main: Saving data for stroop
[2018-07-22 14:25:07,077] DEBUG in server: Finishing stroop
[2018-07-22 14:25:07,077] INFO in main: Finished stroop, 1 remaining.
[2018-07-22 14:25:07,096] DEBUG in main: Next experiment is stroop-5min
[2018-07-22 14:25:07,096] INFO in utils: [router] stroop --> stroop-5min [subid] expfactory/87f6a6f3-b459-4540-a147-c8b839b55dee [user] participant-name
[2018-07-22 14:25:07,096] DEBUG in utils: Redirecting to /experiments/stroop-5min
[2018-07-22 14:25:07,118] DEBUG in utils: Rendering experiments/experiment.html
[2018-07-22 14:29:16,511] DEBUG in main: Saving data for stroop-5min
[2018-07-22 14:29:16,512] DEBUG in server: Finishing stroop-5min
[2018-07-22 14:29:16,514] INFO in main: Finished stroop-5min, 0 remaining.

```

It was then copied into this folder, and you can read about and see an example
for loading the result and analyzing it under [analysis](analysis).

Please reach out by asking a question on the issue board if you need help.
