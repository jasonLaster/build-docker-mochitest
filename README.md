### update docker image

`make build`

### check the status

`make status`

### publish image

First login with `docker login`, then run:

`make publish`


#### Volumes


docker run -ti -v $HOME/src/mozilla/build-docker-mochitest/firefox/:/firefox jasonlaster11/local-mc6
