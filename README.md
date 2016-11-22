# About this Repo
This is the Git repo of the Docker [official image](https://docs.docker.com/docker-hub/official_repos/) for [rails] (https://registry.hub.docker.com/_/rails/) and [mysql](https://hub.docker.com/_/mysql/). See these page for the full readme on how to use this Docker image and for information regarding contributing and issues.

## Pre-Requirements
First install `docker`, `docker compose` for your machine and start it. How this is done is very well documented all over the internet.

### Build the project
You need generate the Rails skeleton app using docker-compose run:
```
$ docker-compose run app rails new . --force --database=mysql --skip-bundle
```

Compose will build the image for the web service using the Dockerfile. Then it’ll run rails new inside a new container, using that image. Once it’s done, you should have generated a fresh app:
```
 $ ls -l
total 56
-rw-r--r--   1 user  staff   488 Nov 22 22:02 Dockerfile
-rw-r--r--   1 user  staff  1521 Nov 22 01:36 Gemfile
-rw-r--r--   1 user  staff  4006 Nov 22 01:36 Gemfile.lock
-rw-r--r--   1 user  staff   478 Nov 22 01:17 README.rdoc
-rw-r--r--   1 user  staff   249 Nov 22 01:17 Rakefile
drwxr-xr-x   8 user  staff   272 Nov 22 01:36 app
drwxr-xr-x   7 user  staff   238 Nov 22 01:36 bin
drwxr-xr-x  11 user  staff   374 Nov 22 10:38 config
-rw-r--r--   1 user  staff   153 Nov 22 01:17 config.ru
drwxr-xr-x   5 user  staff   170 Nov 22 10:46 db
-rw-r--r--   1 user  staff   420 Nov 22 22:02 docker-compose.yml
drwxr-xr-x   4 user  staff   136 Nov 22 01:36 lib
drwxr-xr-x   4 user  staff   136 Nov 22 01:39 log
drwxr-xr-x   7 user  staff   238 Nov 22 01:36 public
drwxr-xr-x   9 user  staff   306 Nov 22 01:27 test
drwxr-xr-x   6 user  staff   204 Nov 22 01:39 tmp
drwxr-xr-x   3 user  staff   102 Nov 22 01:36 vendor
```

Now that you’ve got rails app, you need to build the image again.
```
docker-compose build
```

### Connect the database
The app is now bootable, but you’re not quite there yet. By default, Rails expects a database to be running on `localhost` - so you need to point it at the `mysql container` instead. You also need to change the database and username to align with the defaults set by the mysql image.

Replace the contents of config/database.yml with the following:
```
default: &default
  adapter: mysql2
  encoding: utf8
  pool: 5
  username: root
  password: "root"
  host: mysql

development:
  <<: *default
  database: dev

test:
  <<: *default
  database: dev
```

You can now boot the app with:
```
docker-compose up -d
```

Finally, you need to create the database. In another terminal, run:
```
docker-compose run app rake db:create
```

That’s it. Your app should now be running on port 3000 on your Docker daemon. If you’re using Docker Machine, then `docker-machine ip MACHINE_VM` returns the Docker host IP address.
```
$ docker-machine ip default
192.168.99.100
```

http://192.168.99.100:3000/

![rails](https://cloud.githubusercontent.com/assets/5398914/20524938/578c3872-b100-11e6-8a7f-d359f982bd24.png)

To stop container then run following command:
```
$ docker-compose stop
Stopping ror_app_1 ... done
Stopping ror_mysql_1 ... done
```

To start container again then run following command:
```
$ docker-compose start
Starting dbdata ... done
Starting appdata ... done
Starting mysql ... done
Starting app ... done
```
