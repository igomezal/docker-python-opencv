# Docker with Python 2.7.12 and OpenCV 3.1

Docker container which has python 2.7.12 and OpenCV 3.1

### How to get it?

You can get this image from GitHub:

```bash
git clone https://github.com/igomezal/docker-python-opencv.git
```

or Docker Hub:

```bash
docker pull igomezal/docker-python-opencv
```


### How to use it?
To build it:
```bash
cd to_the_folder_where_is_Dockerfile
docker build . -t python-opencv31
```

If you run the container now it will show you the python prompt from the container we have just built.

```bash
docker run -it --rm --name the_name python-opencv31
```

If you want to run a python script you can do it with (you can use $PWD so it use your current dir):

```bash
docker run -it --rm --name the_name -v /python_script_dir:/a_dir -w /a_dir python-opencv31 python script.py
```

This will run the python script but with OpenCV you normally want to display the results of your script and you can do it like this:

1. Open up your X server:

    ```bash
    xhost +local:docker
    ```

2. Use this command line:

    ```bash
    docker run -it --rm --name the_name -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v /python_script_dir:/a_dir -w /a_dir python-opencv31 python script.py
    ```

3. And when you are finished using the container (for security):

    ```bash
    xhost -local:docker
    ```

Note that if you use the command `docker pull igomezal/docker-python-opencv` the name of your image will be *igomezal/docker-python-opencv* instead of *python-opencv31* 


### Bash function:

You can even create a bash function to use the container and add it to your .bashrc for example.

```bash
function opencv(){
        xhost +local:docker
	if [ $#  -gt 0 ]; then
		sudo docker run -it --rm --name opencv -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $PWD:$PWD -w $PWD python-opencv31 python $1
	else
		sudo docker run -it --rm --name opencv python-opencv31
	fi
	xhost -local:docker
}
```

If you do it, you will only have to call `opencv` in your terminal and it will show you the python prompt from the container or you can call `opencv script.py` to execute your python script.