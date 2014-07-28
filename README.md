# t

The simple tmux helper.

## Motives

I wanted a simpler way to manage my tmux sessions. The built in commands are long and remembering all those options is hard. So I built `t`.

## Install

`t` is compatable with both python 2 and 3

    sudo pip install tmux_t

## Usage

If you start `t` without any options, it will list current sessions and let you choose which one to connect to.

Options in square brackets are optional.


###List current sessions

    $ t list
    $ t ls

###Attach to a session

    $ t attach [session name]
    $ t a [session name]

### Create a session

    $ t new [session name]
    $ t n [session name]

### Remove a session

    $ t remove [session name]
    $ t rm [sessions name]

