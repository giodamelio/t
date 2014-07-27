import tmuxp
import pprint

server = tmuxp.Server()

def format_session(session):
    pane_count = [w.panes for w in session.windows]
    pane_count = [pane for window in pane_count for pane in window]
    pane_count = len(pane_count)
    return "({0}) {1} | {2} Windows, {3} Panes".format(
            session.get("session_id"),
            session.get("session_name"),
            session.get("session_windows"),
            pane_count)

def list_sessions():
    sessions = server.list_sessions()
    sessions = [format_session(s) for s in sessions]
    return sessions

