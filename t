#!/usr/bin/python3
"""
t, The simple tmux helper

Usage:
    t [list | ls] [session_name]
    t [attach | a] [session_name]
    t [new | n] [session_name]
    t [remove | rm] [session_name]

Options:
    -v, --version   Print the version
    -h, --help      Print this help

"""
import argparse
import os

from docopt import docopt
import tmuxp

# Parse args
args = docopt(__doc__, version="0.2.0")

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
    return server.list_sessions()

# Attach to a session
def attach_to_session(session_name):
    os.system("tmux attach-session -t '" + session_name + "'")

# Interactivly pick a session
def interactive_pick_session():
    # List sessions
    pretty_sessions = [format_session(s) for s in sessions]
    print("\n".join(pretty_sessions));

    # Get session id
    session_id = input("Pick session by id: ")

    # Loop through sessions to by id
    for session in sessions:
        if session.get("session_id") == "$" + session_id:
            return session.get("session_name")

# Create a session
def create_session(session_name):
    os.system("tmux new-session -s '" + session_name + "'")

def remove_session(session_name):
    os.system("tmux kill-session -t '" + session_name + "'")

# Get list of sessions
sessions = list_sessions()

# List the tmux sessions
if args["list"] or args["ls"]:
    pretty_sessions = [format_session(s) for s in sessions]
    print("\n".join(pretty_sessions));

# Attach to a session
elif args["attach"] or args["a"]:
    if "session" in args:
        # Session name provided as argument
        attach_to_session(args.session)
    else:
        # Session name not provided
        session_name = interactive_pick_session()
        attach_to_session(session_name)

# Create a new session
elif args["new"] or args["n"]:
    if "session" in args:
        # Session name provided as argument
        create_session(args.session)
    else:
        # Session name not provided
        session_name = input("Session name: ")
        create_session(session_name)

# Remove a session
elif args["remove"] or args["rm"]:
    if "session" in args:
        # Session name provided as argument
        remove_session(args.session)
    else:
        # Session name not provided
        session_name = interactive_pick_session()
        remove_session(session_name)
        print("'" + session_name + "' deleted")

# If no options are given, interactivly join a session
else:
    session_name = interactive_pick_session()
    attach_to_session(session_name)

