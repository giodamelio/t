#!/usr/bin/python3
import argparse
import os

import tmuxp

# Parse the arguments
parser = argparse.ArgumentParser(description="t, The simple tmux helper")
subparsers = parser.add_subparsers(dest="command")

# List
checkout = subparsers.add_parser("list",
        aliases=["ls"],
        help="List sessions")

# Attach
attach = subparsers.add_parser("attach",
        aliases=["a"],
        help="Attach to session by name")
attach.add_argument("session",
        metavar="session",
        nargs="?",
        help="Session name")

# Remove
remove = subparsers.add_parser("remove",
        aliases=["rm"],
        help="Delete to session by name")
remove.add_argument("session",
        metavar="session",
        help="Session name")

# Parse the args
args = parser.parse_args()

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

# Get list of sessions
sessions = list_sessions()

# List the tmux sessions
if args.command in ["list", "ls"]:
    pretty_sessions = [format_session(s) for s in sessions]
    print("\n".join(pretty_sessions));

# Attach to a session
elif args.command in ["attach", "a"]:
    if args.session:
        # Session name provided as argument
        attach_to_session(args.session)
    else:
        # Session name not provided
        session_name = interactive_pick_session()
        attach_to_session(session_name)


