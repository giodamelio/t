#!/usr/bin/python3
import argparse

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
        help="Session name")

# Remove
remove = subparsers.add_parser("remove",
        aliases=["rm"],
        help="Delete to session by name")
remove.add_argument("session",
        metavar="session",
        help="Session name")


args = parser.parse_args()
print(args)

