# t

The simple tmux helper.

## Motives

I wanted a simpler way to manage my tmux sessions. The build in commands are long and remembering all those options are hard. So I built `t`

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

