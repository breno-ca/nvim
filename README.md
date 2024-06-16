# nvim
My personal configuration for Neovim

##### Experimental
To build a container image change the version of the base image in the Dockerfile as needed. Then execute the following command to build the image and tag it for control. In the code below it will build an ubuntu image.

```bash
docker build -t nvim:ubuntu .
```

After building a container with a specific OS specified in the Dockerfile, you can run the following command to start a "dev-container" mounted to the current directory and with the SSH agent forwarded to the container. This will allow you to use the SSH keys on your host machine avoinding errors when trying to clone a repository from a private repository. 

```bash
docker run -it -v $(pwd):/usr/src/project -v $SSH_AUTH_SOCK:/ssh-agent --env SSH_AUTH_SOCK=/ssh-agent
```
