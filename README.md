# godev-vim
Dockerized Golang development environment using vim and all required plugins.

### Dockerhub link: <https://hub.docker.com/r/ctapan/godev-vim>

## Usage: 

* `docker run -it -v ${your_src_dir}:/go/src/${proj_name} godev-vim bash`
  * if your project is on github.com, mount your project at "/go/src/github.com/${proj_name}". This will ensure your package paths are correct
  * This will mount your project source directory into your project name inside /go/src/ inside the container. 
  * You can also give a name to your container to track multiple projects/branches
* Inside the container: `cd /go/src/`
* Run `./tags-gen.sh` script to create cscope files
* Run `ctags -cR` to generate the ctags file
* now you can open your files in vim from /go/src directory. It will automatically load cscope & ctags files
  * There are key-mappings already setup for cscope and ctags. "ctrl+]" + cscope instruction letter
  * Please refer "cscope_maps" link below for how to navigate your source code from inside vim.
  
  

## Create a new container for your project specific packages
* Create a new Dockerfile with `FROM godev-vim`
* Add commands like `go get ${package_name}`


## godev-vim uses following plugins
* pathogen: <https://github.com/tpope/vim-pathogen>
* vim-go: <https://github.com/fatih/vim-go>
* vim-airline: <https://github.com/vim-airline/vim-airline>
* go-explorer: <https://github.com/garyburd/go-explorer>
* nerdtree: <https://github.com/scrooloose/nerdtree>
* tagbar: <https://github.com/majutsushi/tagbar>
* YouCompleteMe: <https://github.com/Valloric/YouCompleteMe>
* cscope: <http://cscope.sourceforge.net/cscope_vim_tutorial.html>
* ctags: <http://ctags.sourceforge.net/>
* cscope_maps: <http://cscope.sourceforge.net/cscope_maps.vim>

*Special thanks to all the contributors of these projects that have made our life easier*

## godev-vim also has following packages installed:
* gcc
* git
* wget
* vim
* curl
 
## vimrc
I have my own vimrc as default which has some cool things that I like, for example:
* Vertical line where the cursor is
* line numbers
* syntax highlighting
* highlight search with nice colors
* spell check for comments


### Want to use your own vimrc?
* `docker pull godev-vim`
* Clone the repository: `git clone https://github.com/ctapan/godev-vim.git`
* compare your ".vimrc" with "vimrc-init" file for any possible conflicts
* replace "myvimrc" with your .vimrc. Please keep the same name "myvimrc". 
* Run `docker build -t my-godev-vim .` while inside godev-vim directory
* It should complete very quickly if you have already pulled the "godev-vim" image.
* after it is successful, you have a new Docker image "my-godev-vim". Use it with above commands

Please let me know your feedback.


### Screenshot below:

![alt tag](https://cloud.githubusercontent.com/assets/11622864/16939512/2bcaaeee-4d37-11e6-8311-a30aa8e2b516.png)
