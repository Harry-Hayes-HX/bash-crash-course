#!/usr/bin/env python3
"""
Referee site for Bash CTF. Run with: python app.py
Serves on 0.0.0.0:5000 so it's reachable on the local network.
"""
import json
from pathlib import Path

import markdown
from flask import Flask, request, jsonify, render_template, send_file

app = Flask(__name__)

DATA_FILE = Path(__file__).parent / "data.json"
CHALLENGES_DIR = Path(__file__).resolve().parent / "challenges"
LESSONS_DIR = Path(__file__).resolve().parent / "lessons"
SETUP_DIR = Path(__file__).resolve().parent / "setup"

# Lesson (filename, display label) per level for scores page
LESSONS = {
    "basics": [
        ("00-history-of-bash.md", "00 – History of Bash"),
        ("01-getting-started.md", "01 – Getting started"),
        ("02-files-and-basics.md", "02 – Files and basics"),
        ("03-finding-and-filtering.md", "03 – Finding and filtering"),
        ("04-permissions-and-users.md", "04 – Permissions and users"),
        ("05-variables-and-scripts.md", "05 – Variables and scripts"),
        ("06-help-desk-scenario.md", "06 – Help desk scenario"),
    ],
    "intermediates": [
        ("01-conditionals.md", "01 – Conditionals"),
        ("02-loops.md", "02 – Loops"),
        ("03-functions-and-arguments.md", "03 – Functions and arguments"),
        ("04-exit-codes-and-robustness.md", "04 – Exit codes and robustness"),
        ("05-capstone-script.md", "05 – Capstone script"),
    ],
    "advanceds": [
        ("01-error-handling.md", "01 – Error handling"),
        ("02-trap-and-signals.md", "02 – Trap and signals"),
        ("03-arrays-and-data.md", "03 – Arrays and data"),
        ("04-getopts-and-options.md", "04 – getopts and options"),
        ("05-capstone.md", "05 – Capstone"),
    ],
    "git": [
        ("01-what-is-git.md", "01 – What is Git?"),
        ("02-status-add-commit.md", "02 – Status, add, and commit"),
        ("03-history-and-diff.md", "03 – History and diff"),
        ("04-branching.md", "04 – Branching"),
        ("05-remote-clone-push.md", "05 – Remote, clone, push, pull"),
    ],
}

SETUP_FILES = [
    ("setup-challenges-basics.sh", "Setup challenges (basics)"),
    ("setup-challenges-intermediates.sh", "Setup challenges (intermediates)"),
    ("setup-challenges-advanceds.sh", "Setup challenges (advanceds)"),
]

# Challenge ID -> (level_dir, filename) for serving challenge .md from REFEREE-SITE/challenges
CHALLENGE_DOCS = {
    "basics-1": ("basics", "01-navigation.md"),
    "basics-2": ("basics", "02-files.md"),
    "basics-3": ("basics", "03-finding.md"),
    "basics-4": ("basics", "04-permissions.md"),
    "basics-5": ("basics", "05-scripts.md"),
    "basics-6": ("basics", "06-capstone.md"),
    "interm-1": ("intermediates", "01-conditionals.md"),
    "interm-2": ("intermediates", "02-loops.md"),
    "interm-3": ("intermediates", "03-functions-arguments.md"),
    "interm-4": ("intermediates", "04-exit-codes.md"),
    "interm-5": ("intermediates", "05-capstone.md"),
    "advanced-1": ("advanceds", "01-error-handling.md"),
    "advanced-2": ("advanceds", "02-trap.md"),
    "advanced-3": ("advanceds", "03-arrays.md"),
    "advanced-4": ("advanceds", "04-getopts.md"),
    "advanced-5": ("advanceds", "05-capstone.md"),
}

# Challenge IDs and correct flags (trimmed, case-sensitive match)
FLAGS = {
    "basics-1": "9Kp2xLm7Qv4Rn8Jw",
    "basics-2": "3Nq5yHt8Wz1Bc6Fd",
    "basics-3": "7Xr9Mn2Pv4Ks6Lw",
    "basics-4": "2Jh5Gt8Yq1Zn3Bx",
    "basics-5": "4Fc7Vn9Rx2Km5Lp",
    "basics-6": "8Wz3Qm6Jt1Hv9Np",
    "interm-1": "a1B2c3D4e5F6g7H8",
    "interm-2": "x9Kp2Lm7Qv4Rn8Jw3Nq5Ht8",
    "interm-3": "7Xr9Mn2Pv4Ks6Lw",
    "interm-4": "2Jh5Gt8Yq1Zn3Bx",
    "interm-5": "8Wz3Qm6Jt1Hv9Np",
    "advanced-1": "5Tm9Kp2Lm7Qv4Rn8",
    "advanced-2": "8Wz3Qm6Jt1Hv9Np",
    "advanced-3": "2Jh5Gt8Yq1Zn3Bx",
    "advanced-4": "4Fc7Vn9Rx2Km5Lp",
    "advanced-5": "7Xr9Mn2Pv4Ks6Lw",
}

CHALLENGE_LABELS = {
    "basics-1": "01 – Navigation",
    "basics-2": "02 – Files",
    "basics-3": "03 – Finding",
    "basics-4": "04 – Permissions",
    "basics-5": "05 – Scripts",
    "basics-6": "06 – Capstone",
    "interm-1": "01 – Conditionals",
    "interm-2": "02 – Loops",
    "interm-3": "03 – Functions & args",
    "interm-4": "04 – Exit codes",
    "interm-5": "05 – Capstone",
    "advanced-1": "01 – Error handling",
    "advanced-2": "02 – Trap",
    "advanced-3": "03 – Arrays",
    "advanced-4": "04 – Getopts",
    "advanced-5": "05 – Capstone",
}


def _default_data():
    return {
        "teamA": {"name": "Team A", "solved": []},
        "teamB": {"name": "Team B", "solved": []},
    }


def load_data():
    if not DATA_FILE.exists():
        return _default_data()
    try:
        with open(DATA_FILE) as f:
            text = f.read().strip()
            if not text:
                data = _default_data()
                save_data(data)
                return data
            return json.loads(text)
    except (json.JSONDecodeError, ValueError):
        data = _default_data()
        save_data(data)  # repair corrupted/empty file
        return data


def save_data(data):
    with open(DATA_FILE, "w") as f:
        json.dump(data, f, indent=2)


@app.route("/")
def index():
    return render_template("index.html", git_lessons=LESSONS["git"])


def _render_markdown(path):
    """Read a .md file and return HTML wrapped in a styled page."""
    text = path.read_text(encoding="utf-8")
    html = markdown.markdown(
        text,
        extensions=["fenced_code", "tables", "nl2br", "sane_lists", "md_in_html"],
    )
    return render_template("markdown_page.html", content=html, title=path.stem)


@app.route("/challenge/<level>/<filename>")
def challenge_doc(level, filename):
    if level not in ("basics", "intermediates", "advanceds", "final-challenge") or not filename.endswith(".md"):
        return "", 404
    path = CHALLENGES_DIR / level / filename
    if not path.is_file():
        return "", 404
    return _render_markdown(path)


@app.route("/lesson/<level>/<filename>")
def lesson_doc(level, filename):
    if level not in ("basics", "intermediates", "advanceds", "git") or not filename.endswith(".md"):
        return "", 404
    path = LESSONS_DIR / level / filename
    if not path.is_file():
        return "", 404
    return _render_markdown(path)


@app.route("/setup/<filename>")
def setup_download(filename):
    if filename not in ("setup-challenges-basics.sh", "setup-challenges-intermediates.sh", "setup-challenges-advanceds.sh"):
        return "", 404
    path = SETUP_DIR / filename
    if not path.is_file():
        return "", 404
    return send_file(path, as_attachment=True, download_name=filename)


@app.route("/team-a")
def team_a():
    return render_template(
        "team.html",
        team_id="A",
        team_label="Team A",
        challenge_labels=CHALLENGE_LABELS,
        challenge_ids=list(CHALLENGE_LABELS.keys()),
        challenge_docs=CHALLENGE_DOCS,
        setup_files=SETUP_FILES,
    )


@app.route("/team-b")
def team_b():
    return render_template(
        "team.html",
        team_id="B",
        team_label="Team B",
        challenge_labels=CHALLENGE_LABELS,
        challenge_ids=list(CHALLENGE_LABELS.keys()),
        challenge_docs=CHALLENGE_DOCS,
        setup_files=SETUP_FILES,
    )


@app.route("/scores")
def scores():
    return render_template("scores.html", lessons=LESSONS)


@app.route("/api/state")
def api_state():
    return jsonify(load_data())


@app.route("/api/submit", methods=["POST"])
def api_submit():
    data = load_data()
    body = request.get_json() or {}
    team = body.get("team")
    challenge_id = body.get("challengeId")
    submitted = (body.get("flag") or "").strip()

    if team not in ("A", "B") or challenge_id not in FLAGS:
        return jsonify({"ok": False, "error": "Invalid team or challenge"}), 400

    team_key = "teamA" if team == "A" else "teamB"
    team_name = data[team_key].get("name", f"Team {team}")
    correct_flag = FLAGS[challenge_id]
    correct = submitted == correct_flag

    if correct and challenge_id not in data[team_key]["solved"]:
        data[team_key]["solved"].append(challenge_id)
        save_data(data)

    # Log to terminal for referee
    status = "CORRECT" if correct else "WRONG"
    print(f"[FLAG] {team_name} | {status} | challenge={challenge_id} | submitted={submitted!r}")

    return jsonify({
        "ok": correct,
        "teamName": team_name,
        "correct": correct,
        "submitted": submitted,
    })


@app.route("/api/team-name", methods=["GET", "POST"])
def api_team_name():
    data = load_data()
    if request.method == "GET":
        team = request.args.get("team")
        if team not in ("A", "B"):
            return jsonify({"error": "Invalid team"}), 400
        key = "teamA" if team == "A" else "teamB"
        return jsonify({"name": data[key]["name"]})

    body = request.get_json() or {}
    team = body.get("team")
    name = (body.get("name") or "").strip() or None
    if team not in ("A", "B"):
        return jsonify({"error": "Invalid team"}), 400
    key = "teamA" if team == "A" else "teamB"
    if name:
        data[key]["name"] = name[:80]  # cap length
        save_data(data)
    return jsonify({"name": data[key]["name"]})


if __name__ == "__main__":
    # Port 8080 to avoid macOS AirPlay Receiver using 5000 (Monterey+)
    app.run(host="0.0.0.0", port=8080, debug=True)
