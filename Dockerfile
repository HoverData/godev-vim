FROM ubuntu:xenial

# Set non-interactive mode
ENV DEBIAN_FRONTEND=noninteractive

# Install all required packages
RUN apt-get update && \
       apt-get install -q -y vim && \
       apt-get install -q -y gcc && \
       apt-get install -q -y wget && \
       apt-get install -q -y git && \
       apt-get install -q -y cscope && \
       apt-get install -q -y ctags && \
       apt-get install -q -y curl && \
       apt-get update && \
       mkdir -p /go/src

# Installing all vim plugins except auto-complete
RUN mkdir -p ~/.vim/autoload ~/.vim/bundle ~/.vim/plugin && \
       curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim && \

       git clone --branch v1.7.1 https://github.com/fatih/vim-go.git ~/.vim/bundle/vim-go && \

       git clone https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline && \
       git clone https://github.com/vim-airline/vim-airline-themes ~/.vim/bundle/vim-airline-themes && \

       git clone --branch 5.0.0 https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree && \

       git clone https://github.com/garyburd/go-explorer.git ~/.vim/bundle/go-explorer && \

       git clone https://github.com/majutsushi/tagbar.git ~/.vim/bundle/tagbar && \

       wget -q -P ~/.vim/plugin http://cscope.sourceforge.net/cscope_maps.vim

# This is for auto-completion and increases image size by around 450MB
RUN apt-get install -q -y build-essential cmake python-dev python3-dev && \
       git clone https://github.com/Valloric/YouCompleteMe.git ~/.vim/bundle/YouCompleteMe && \
       cd ~/.vim/bundle/YouCompleteMe && git submodule update --init --recursive 

ENV GOPATH=/go
ENV PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

# Get golang version for the build
RUN cd /tmp && wget -q https://storage.googleapis.com/golang/go1.6.2.linux-amd64.tar.gz && \
       tar -C /usr/local -xzf /tmp/go1.6.2.linux-amd64.tar.gz && \
       rm *.gz && \
       mkdir -p /go/src
       
RUN ~/.vim/bundle/YouCompleteMe/install.py --gocode-completer

# script to generate ctags and cscope db
COPY vimrc-init tags-gen.sh /tmp/

# Setup vimrc and install go tools
RUN mv /tmp/vimrc-init ~/.vimrc && \
       mv /tmp/tags-gen.sh /go/src && chmod 777 /go/src/tags-gen.sh && \
       apt-get install -q -y vim-nox && \
       vim +GoInstallBinaries +qall && \
       vim +Helptags +qall

# Setup personalized vimrc
COPY myvimrc /tmp/
RUN cat /tmp/myvimrc >> ~/.vimrc

ENV DEBIAN_FRONTEND=interactive
WORKDIR /go/src
