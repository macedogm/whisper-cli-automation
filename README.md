### Introduction

This simple script automates the creation of secrets in Whisper. The default behaviour of Whisper is to encrypt the secret in the browser, before sending to the server. This scripts emaluates this behavior using the same library that Whispes uses - [Stanford Javascript Crypto Library](https://bitwiseshiftleft.github.io/sjcl/).

### How to execute

Every secret that needs to be encrypted must be writed in the file keys.txt, one secret per line.

```
$ cat keys.txt 
SECRET1
SECRET2
SECRET3
```

Next it is necessary to build the Docker image.

```
$ docker build -t whisper-secrets .
Sending build context to Docker daemon  7.168kB
Step 1/7 : FROM node
latest: Pulling from library/node
6f2f362378c5: Pull complete 
494c27a8a6b8: Pull complete 
7596bb83081b: Pull complete 
372744b62d49: Pull complete 
615db220d76c: Pull complete 
afaefeaac9ee: Pull complete 
22d677ae7b14: Pull complete 
954f64c2b02a: Pull complete 
3a0d282381d6: Pull complete 
Digest: sha256:5dc8167a7dca45fe6a063922576e05e684a29fc693e5f0b5b4625b851d469e41
Status: Downloaded newer image for node:latest
 ---> b074182f4154
Step 2/7 : RUN wget https://bitwiseshiftleft.github.io/sjcl/sjcl.js
 ---> Running in 304b6002bda0
--2019-06-12 13:00:26--  https://bitwiseshiftleft.github.io/sjcl/sjcl.js
Resolving bitwiseshiftleft.github.io (bitwiseshiftleft.github.io)... 185.199.110.153, 185.199.111.153, 185.199.108.153, ...
Connecting to bitwiseshiftleft.github.io (bitwiseshiftleft.github.io)|185.199.110.153|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 25378 (25K) [application/javascript]
Saving to: 'sjcl.js'

     0K .......... .......... ....                            100% 1.06M=0.02s

2019-06-12 13:00:26 (1.06 MB/s) - 'sjcl.js' saved [25378/25378]

Removing intermediate container 304b6002bda0
 ---> fc40edac9928
Step 3/7 : COPY encryption.js encryption.js
 ---> 45356bc225e1
Step 4/7 : COPY keys.txt keys.txt
 ---> 63a61e66a138
Step 5/7 : COPY whisper-secrets.sh whisper-secrets.sh
 ---> 8915b33dec8e
Step 6/7 : RUN chmod 700 whisper-secrets.sh
 ---> Running in faf16e308c9e
Removing intermediate container faf16e308c9e
 ---> ec7c56a1babd
Step 7/7 : ENTRYPOINT ["/whisper-secrets.sh"]
 ---> Running in 59fcc7e77101
Removing intermediate container 59fcc7e77101
 ---> 651db503ca9a
Successfully built 651db503ca9a
Successfully tagged whisper-secrets:latest
```

Finally the container can be execute.

```
$ docker run whisper-secrets
Key SECRET1 => password = Yf1KUiY8zQ7dyNd8 | URL = https://<whisper.server.address>/#/s/7a13db11-a927-4928-a237-d81052cdc149/Yf1KUiY8zQ7dyNd8
Key SECRET2 => password = enW3MWx1Ci8aedy8 | URL = https://<whisper.server.address>/#/s/59efc004-eea9-45b1-9ca0-1552d4d6d1e5/enW3MWx1Ci8aedy8
Key SECRET3 => password = GuUzfd31yWdis2Ut | URL = https://<whisper.server.address>/#/s/d4e0d23a-696a-45a0-b98c-5b1d6f1f5886/GuUzfd31yWdis2Ut
```

The script will by default output the password and the Whisper URL for each secret.
