# Judge runbook — detailed conditions per group

Use this when testing scripts. Assume their script takes **-c** (config file) and **-d** (destination directory), and reads one path per line from the config. Adjust option letters if a submission uses different options (e.g. **-f** / **-o**); keep the *kind* of test the same.

Use a fresh temp dir per group (and per run if you want a clean state). Replace `SCRIPT` with the path to their script (e.g. `./submission.sh`).

---

## Group 1 — User error

| # | What you do | Expected |
|---|-------------|----------|
| 1.1 | Run with no arguments: `SCRIPT` | Clear usage/error message, non-zero exit. |
| 1.2 | Run with missing required option, e.g. only `-c /tmp/config.txt` (no `-d`) | Clear error about missing option/argument, non-zero exit. |
| 1.3 | Run with wrong option, e.g. `SCRIPT -x foo` or `SCRIPT --invalid` | Clear error or usage, non-zero exit. |
| 1.4 | Run with `-c` but no value (next arg is another option or missing) | Clear error, non-zero exit. |

**Commands (example):**
```bash
mkdir -p /tmp/judge_g1 && cd /tmp/judge_g1
SCRIPT=/path/to/their_script.sh

$SCRIPT
$SCRIPT -c /tmp/config.txt
$SCRIPT -d /tmp/out
$SCRIPT -c
$SCRIPT -c -d /tmp/out
```

---

## Group 2 — Missing or invalid config

| # | What you do | Expected |
|---|-------------|----------|
| 2.1 | Run with `-c /nonexistent/path/to/config.txt -d ./out` (config does not exist) | Clear error, non-zero exit. |
| 2.2 | Run with `-c` pointing to a directory, not a file | Clear error or sensible behaviour, non-zero exit. |
| 2.3 | Config file exists but is not readable (e.g. `chmod 000 config.txt`) then run with `-c config.txt -d ./out` | Clear error, non-zero exit. |
| 2.4 | Run with empty string or relative path that doesn’t exist, e.g. `-c "" -d ./out` (if supported) | No crash; clear error or usage. |

**Commands (example):**
```bash
mkdir -p /tmp/judge_g2 && cd /tmp/judge_g2
mkdir -p out
SCRIPT=/path/to/their_script.sh

$SCRIPT -c /nonexistent/config.txt -d ./out
touch config.txt && chmod 000 config.txt && $SCRIPT -c config.txt -d ./out
mkdir -p not_a_file && $SCRIPT -c not_a_file -d ./out
```

---

## Group 3 — Filesystem and permissions

| # | What you do | Expected |
|---|-------------|----------|
| 3.1 | Config lists a source file that does not exist. Run normally with valid `-d`. | Script reports error for missing file or exits non-zero; no trace/crash. |
| 3.2 | Destination directory does not exist and script is expected to create it, or it exists but is not writable (`chmod 555 dest`) | Either creates dir / handles cleanly or exits with clear error. |
| 3.3 | Config lists a path that is a directory (not a file), if that’s invalid for their design | Clear error or skip; no crash. |
| 3.4 | Source file exists but is not readable (`chmod 000 source.txt`), config points at it | Clear error or skip; non-zero exit. |

**Commands (example):**
```bash
mkdir -p /tmp/judge_g3 && cd /tmp/judge_g3
SCRIPT=/path/to/their_script.sh

echo "/nonexistent/source.txt" > config.txt
$SCRIPT -c config.txt -d ./out

echo "$(pwd)/real.txt" > config.txt
touch real.txt
chmod 000 real.txt
$SCRIPT -c config.txt -d ./out

mkdir -p out && chmod 555 out
echo "/etc/hosts" > config.txt
$SCRIPT -c config.txt -d ./out
```

---

## Group 4 — Signals and interruption

| # | What you do | Expected |
|---|-------------|----------|
| 4.1 | Run script with config that lists many files or a long-running action; send SIGINT (Ctrl+C) after a second or two. | Script exits cleanly (trap), no trace; optional cleanup. |
| 4.2 | Same as 4.1 but send SIGTERM (e.g. `kill $PID`). | Same: clean exit, no half-finished output or crash. |

**Commands (example):**
```bash
mkdir -p /tmp/judge_g4 && cd /tmp/judge_g4
SCRIPT=/path/to/their_script.sh
# Config that causes some work (e.g. many lines or a file that takes time)
printf '/etc/hosts\n%.0s' {1..50} > config.txt
mkdir -p out

$SCRIPT -c config.txt -d ./out &
PID=$!
sleep 1
kill -INT $PID
wait $PID

# Or: kill -TERM $PID
```

---

## Group 5 — Empty or malformed data

| # | What you do | Expected |
|---|-------------|----------|
| 5.1 | Config file is empty (0 bytes). Run with `-c empty.txt -d ./out`. | No crash; clear message or exit non-zero. |
| 5.2 | Config has only blank lines or whitespace. | Same. |
| 5.3 | Config has a mix of valid paths and blank lines / invalid paths. | Script skips or errors on bad lines; no crash. |
| 5.4 | Config has one valid path and one path that doesn’t exist. | Partial success or clear errors; no crash. |

**Commands (example):**
```bash
mkdir -p /tmp/judge_g5 && cd /tmp/judge_g5
SCRIPT=/path/to/their_script.sh
mkdir -p out
touch real.txt

touch empty.txt
$SCRIPT -c empty.txt -d ./out

printf '\n\n  \n' > blanks.txt
$SCRIPT -c blanks.txt -d ./out

echo -e "$(pwd)/real.txt\n/nonexistent.txt\n" > config.txt
$SCRIPT -c config.txt -d ./out
```

---

## Group 6 — Environment and context

| # | What you do | Expected |
|---|-------------|----------|
| 6.1 | Config contains relative paths (e.g. `./foo.txt`). Run from a different working directory so those paths don’t exist from cwd. | Clear error or resolved paths; no crash. |
| 6.2 | Run script with `-c` and `-d` as absolute paths, then same with relative paths. | Behaviour is consistent and correct for both. |
| 6.3 | Use a config path that is relative and a dest that is absolute (or vice versa). | Script handles both; no crash. |

**Commands (example):**
```bash
mkdir -p /tmp/judge_g6/sub && cd /tmp/judge_g6
SCRIPT=/path/to/their_script.sh
echo "should_not_exist_here.txt" > config.txt
mkdir -p out

# Run from sub so relative path in config doesn’t exist from cwd
cd sub && $SCRIPT -c ../config.txt -d ../out
cd /tmp/judge_g6
$SCRIPT -c "$(pwd)/config.txt" -d "$(pwd)/out"
$SCRIPT -c config.txt -d out
```

---

## Hidden challenge (undisclosed)

Keep one scenario only for yourself (e.g. a specific combo of the above, or something like: config is a symlink to a dir, or `-d` is a file not a dir, or script run as different user). Run it without warning; their script should either succeed or fail cleanly.

---

## Checklist per submission

- [ ] Pick one group (or rotate); run all tests in that group.
- [ ] If script fails any test, that’s one rewrite.
- [ ] Optionally run hidden challenge once they’ve passed a full group.
- [ ] Record: group used, which test failed (if any), rewrite count.
