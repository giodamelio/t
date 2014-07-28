#!/usr/bin/python
"""
t, The simple tmux helper

Usage:
    t (list | ls)
    t (attach | a) [<session_name>]
    t (new | n) [-n, --no-attach] [<session_name>]
    t (remove | rm) [-a, --all] [<session_name>]

Options:
    -v, --version   Print the version
    -h, --help      Print this help

"""
import argparse
import os
import sys

from docopt import docopt
import tmuxp

# Make input work with poth python 2 and 3
if sys.version_info[0] >= 3:
    get_input = input
else:
    get_input = raw_input

# Parse args
args = docopt(__doc__, version="0.2.2")

# Get current tmux server
server = tmuxp.Server()

# Pretty session display
def format_session(session):
    return "({0}) {1} | {2} Windows".format(
            session.get("session_id").replace("$", ""),
            session.get("session_name"),
            session.get("session_windows"))

# List current sessions
def list_sessions():
    try:
        return server.list_sessions()
    except tmuxp.exc.TmuxpException:
        print("No tmux server running...")
        sys.exit(1)

# Attach to a session
def attach_to_session(session_name):
    os.system("tmux attach-session -t '" + session_name + "'")

# Interactivly pick a session
def interactive_pick_session():
    # List sessions
    sessions = list_sessions()
    pretty_sessions = [format_session(s) for s in sessions]
    print("\n".join(pretty_sessions));

    # Get session id
    session_id = get_input("Pick session by id: ")

    # Loop through sessions to by id
    for session in sessions:
        if session.get("session_id") == "$" + str(session_id):
            return session.get("session_name")

# Create a session
def create_session(session_name, attach=True):
    if attach:
        os.system("tmux new-session -s '" + session_name + "'")
    else:
        os.system("tmux new-session -d -s '" + session_name + "'")
        print("Created session '" + session_name + "'")

def remove_session(session_name):
    os.system("tmux kill-session -t '" + session_name + "'")

# List the tmux sessions
if args["list"] or args["ls"]:
    pretty_sessions = [format_session(s) for s in list_sessions()]
    print("\n".join(pretty_sessions));

# Attach to a session
elif args["attach"] or args["a"]:
    if args["<session_name>"]:
        # Session name provided as argument
        attach_to_session(args["<session_name>"])
    else:
        # Session name not provided
        session_name = interactive_pick_session()
        attach_to_session(session_name)

# Create a new session
elif args["new"] or args["n"]:
    if args["<session_name>"]:
        # Session name provided as argument
        create_session(args["<session_name>"], not (args["-n"] or args["--no-attach"]))
    else:
        # Session name not provided
        session_name = get_input("Session name: ")
        create_session(session_name, not (args["-n"] or args["--no-attach"]))

# Remove a session
elif args["remove"] or args["rm"]:
    if args["<session_name>"]:
        # Session name provided as argument
        remove_session(args["<session_name>"])
        print("'" + args["<session_name>"] + "' deleted")
    else:
        # Session name not provided
        if args["-a"] or args["--all"]:
            # Delete all sessions
            for session in list_sessions():
                remove_session(session.get("session_name"))
            print("All sessions deleted")
        else:
            # Delete one session
            session_name = interactive_pick_session()
            remove_session(session_name)
            print("'" + session_name + "' deleted")

# If no options are given, interactivly join a session
else:
    session_name = interactive_pick_session()
    attach_to_session(session_name)

