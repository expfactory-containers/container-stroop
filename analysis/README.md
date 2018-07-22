# Experiment Factory Stroop Container Analysis

![https://expfactory.github.io/expfactory/img/expfactoryticketyellow.png](https://expfactory.github.io/expfactory/img/expfactoryticketyellow.png)

### Run the Container

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

For the above, the container is pulled from Docker Hub, named `vanessa/expfactory-container-stroop`.
We did not designate a tag, and by default pulled latest. If you want to find a tag corresponding
with a particular Github commit id, [view the tags here](https://hub.docker.com/r/vanessa/expfactory-container-stroop/tags/) and rnu (or pull) as follows:

```bash
$ docker pull vanessa/expfactory-container-stroop:<tag>
$ docker run -p 80:80 -v /tmp/data:/scif/data vanessa/expfactory-container-stroop:<tag> start
```

### Data
The data saved in `/tmp/data` with default study id `expfactory` and a randomly generated id was then copied into 
this folder.

```bash
# ensure we have permissions to touch the data
$ sudo chown -R /tmp/data $USER

# move it here
mkdir expfactory
$ mv /tmp/data/expfactory expfactory
```

The analysis script [5min_stroop_analyses.R](5min_stroop_analyses.R) was then run to produce the result. Note
that this analysis itself is not fully reproducible, as you would need to install R and the required packages.
Please reach out by asking a question on the [issue board](https://github.com/expfactory-containers/container-stroop/issues) if you need help.
