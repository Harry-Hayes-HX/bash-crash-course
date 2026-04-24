# Challenge 1: Fail Safe

**Lesson:** 1 – Error handling  
**Skills:** Input validation, strict mode, handling failures explicitly (`|| true` / `if !`), exit codes

---

## Mission

In `~/bash_ctf/advanceds/errorhandling/` your script is **tested with one argument**: the path to that directory. **run_me.sh** runs your script three ways:

1. **No argument** — Your script must print usage and **exit 2**.
2. **Invalid path** (e.g. not a directory) — Your script must print an error and **exit 1**.
3. **Valid path** (the errorhandling directory) — Your script must run **task.sh** (which fails until a file `ready` exists), **handle the failure**, create `ready`, run **task.sh** again so it prints the code, and **exit 0**.

You must **write a script** that: (1) **validates** the argument (missing → exit 2; not a directory → exit 1); (2) when valid, runs task.sh, handles the error so your script does not exit, creates `ready`, runs task.sh again so the code is printed.

---

## Rules

- **Your solution must be a single script** that you pass to run_me.sh. It must pass all three tests (no-arg → exit 2, bad path → exit 1, good path → exit 0 and print code).
- **You must not** fix things by hand; the script must do validation, error handling, and the fix.
- You may read the README or run task.sh once to see what it needs. After that, your script must do everything.

---

## Steps

1. `cd ~/bash_ctf/advanceds/errorhandling`
2. Read the README and optionally run **./task.sh** to see what it needs.
3. Write your script so it: (a) exits 2 when given no arg, (b) exits 1 when the arg is not a directory, (c) when given the correct path, runs task.sh, handles the failure, creates ready, runs task.sh again.
4. Run: `./run_me.sh ./your_script.sh`. run_me.sh will test all three cases; if any fail, it will tell you which.

---

## Success

You've completed the challenge when run_me.sh reports success and the code (SAFE_CODE:...) was printed. Submit that exact string in the input for Advanced: 01 - Fail Safe.

---

## Hints

<details>
<summary>Click to show hints</summary>
<ul>
<li><strong>Validation:</strong> At the start, check <code>[ -z "${1:-}" ]</code> and exit 2 with a usage message. Then check <code>[ -d "$1" ]</code> (or <code>! [ -d "$1" ]</code>) and exit 1 if the path is not a directory.</li>
<li>The file task.sh looks for is named <strong>ready</strong> in the directory passed as <code>$1</code>. Create it with <code>touch "$1/ready"</code>.</li>
<li>If your script uses <code>set -e</code>, the first run of <code>task.sh</code> would exit the script when task.sh returns 1. Use <code>"$1/task.sh" || true</code> or <code>if ! "$1/task.sh"; then :; fi</code> so the script continues, then create ready and run task.sh again.</li>
<li>Order for the success path: validate → run task.sh (fails) → create ready → run task.sh again (succeeds and prints code).</li>
<details><summary>Click to show full solution</summary><pre>
#!/bin/bash
set -euo pipefail
[ -n "${1:-}" ] || { echo "Usage: $0 &lt;errorhandling-dir&gt;"; exit 2; }
[ -d "$1" ] || { echo "Not a directory: $1"; exit 1; }
"$1/task.sh" || true
touch "$1/ready"
"$1/task.sh"
</pre>
Save as e.g. <code>fix_and_run.sh</code>, then:
<pre>cd ~/bash_ctf/advanceds/errorhandling
chmod +x fix_and_run.sh
./run_me.sh ./fix_and_run.sh</pre>
run_me.sh tests no-arg (exit 2), bad path (exit 1), then correct path (exit 0 and SAFE_CODE in output).
</details>
</li>
</ul>
</details>