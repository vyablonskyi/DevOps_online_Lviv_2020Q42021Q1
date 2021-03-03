**Python Flask application that allow us to enjoy by viewing photos with cats**

On the local VM with Ubuntu 18 (192.168.0.111) on board there was installed Docker.
The "tester" user was added to the "docker" group.
In the home folder of this user there was created necessary file structure in the [flask-cats folder](screenshots/001.JPG)

The ***app.py*** contains:
```
from flask import Flask, render_template
import random
app = Flask(__name__)

#create new list with URLs to cats photo
img = [
    "http://aws.whatabout.info/cats/cat-01.gif",
    "http://aws.whatabout.info/cats/cat-02.gif",
    "http://aws.whatabout.info/cats/cat-03.gif",
    "http://aws.whatabout.info/cats/cat-04.gif",
    "http://aws.whatabout.info/cats/cat-05.gif",
    "http://aws.whatabout.info/cats/cat-06.gif",
    "http://aws.whatabout.info/cats/cat-07.gif",
    "http://aws.whatabout.info/cats/cat-08.gif",
    "http://aws.whatabout.info/cats/cat-09.gif",
    "http://aws.whatabout.info/cats/cat-10.gif"
]
@app.route('/')
def index():
    myurl = random.choice(img)
    return render_template('index.html',url=myurl)

if __name__ == "__main__":
    app.run(host="0.0.0.0")
```

The ***Dockerfile*** contains:
```
FROM alpine:3.5
RUN apk add --update py2-pip
RUN pip install --upgrade pip
COPY requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt
COPY app.py /usr/src/app/
COPY templates/index.html /usr/src/app/templates/
EXPOSE 5000
CMD ["python", "/usr/src/app/app.py"]
```

The ***templates/index.html*** file contains:
```
<html>
  <head>
    <style type="text/css">
     body {
       background: black;
       color: white;
     }
     div.container{
       max-width: 1024px;
       margin: 100px auto;
       border: 20px solid white;
       padding: 10px;
       text-align: center;
     }
     h4 {
       text-transform: uppercase;
     }
    </style>
  </head>
  <body>
    <div class="container">
      <h4>Catssssss</h4>
      <img src="{{url}}" />
    </div>
  </body>
</html>
```

The ***requirements.txt*** file contains:
```
Flask==0.10.1
```

After running the following command: 
```
docker build -t catsinflask .
```
there was created the ***catsinflask*** image:
```
tester@localmachine:~/flask-cats$ docker images
REPOSITORY    TAG       IMAGE ID       CREATED          SIZE
catsinflask   latest    dbc4381071ad   9 minutes ago    67.4MB
<none>        <none>    fb5348358d7d   15 minutes ago   67.4MB
alpine        3.5       f80194ae2e0c   2 years ago      4MB
tester@localmachine:~/flask-cats$
```

There was run the ***catsinflask*** container by runnig the commad below:
```
 docker run -p 8080:5000 --name catsinflask catsinflask
```

And as [result](screenshots/002.JPG)  on the 192.168.0.111 server via the 8080 port there was got accessible our application and we can enjoy by viewing cats.
