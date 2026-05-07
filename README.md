KIERAN TEST



# Bash CTF Referee Site

Simple local site for two teams to submit CTF flags. Runs on the machine’s IP so both teams can use it on the same network.

## Setup

Use a virtual environment (recommended on macOS/Homebrew Python to avoid “externally-managed-environment”):

```bash
cd REFEREE-SITE
python3 -m venv .venv
source .venv/bin/activate   # On Windows: .venv\Scripts\activate
pip install -r requirements.txt
```

## Run

With the venv activated:

```bash
python app.py
```

- **Local:** open http://127.0.0.1:8080  
- **Network:** open http://\<this-machine-ip\>:8080 (e.g. http://192.168.1.10:8080) from other devices.

**If the page never loads from another device:** macOS Firewall may be blocking it. In **System Settings → Network → Firewall → Options**, allow incoming connections for **Python** (or turn the firewall off temporarily to test). Using port 8080 avoids macOS reserving port 5000 for AirPlay Receiver.

## Pages

- **Team A** (/team-a) — Team A’s submission page; they can set a custom team name.
- **Team B** (/team-b) — Same for Team B.
- **Scores** (/scores) — Both team names and scores; refreshes every 2 seconds.

Each team gets one input per challenge (Basics, Intermediates, Advanced). Correct flag → green tick and submit button hides. Wrong flag → red X. One point per correct flag.

Data is stored in `data.json` in this folder (created on first submit or name change).
