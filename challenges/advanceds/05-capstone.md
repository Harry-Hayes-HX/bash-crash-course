# Challenge 5: Full Stack (Capstone)

**Lesson:** 5 – Capstone  
**Skills:** set -e, trap, getopts, arrays

---

## Mission

Go to **~/bash_ctf/advanceds/capstone/**. Run your script with **./run_me.sh &lt;your_script&gt;**; the runner will pass **-d** and a directory, then stop your script after a moment. Get the token.

---

## Success

You've completed the challenge when your script prints the token. Submit that exact string in the input for Advanced: 05 - Capstone.

---

## Hints
<details>
<summary>Click to show hints</summary>
<ul>
<li>Run: <code>./run_me.sh your_script.sh</code> (or <code>./run_me.sh ./your_script.sh</code>). Your script gets <code>-d</code> (this directory). While it runs, <code>data/secret.txt</code> does not exist; we reveal it when we stop your script. You must use: (1) <code>set -e</code>, (2) <code>trap</code> on <code>EXIT</code> to <code>cat</code> the token when the script exits, (3) <code>getopts</code> to parse <code>-d</code>, (4) read <code>files.txt</code> into an array (<code>mapfile</code> in Bash 4+, or a <code>while IFS= read -r line; do arr+=( "$line" ); done &lt; file</code> loop for Bash 3.2 / macOS), then filter to the path containing 'secret', and in the trap <code>cat \"\$DIR/&lt;that path&gt;\"</code>. The file <code>data/secret.txt</code> will exist when the trap runs.</li>
<li>- The runner <b>stops</b> your script after a moment. What can run when a script exits, no matter how it exits?</li>
<li>- You need to parse the <code>-d</code> option to get the directory; <code>getopts</code> is the usual way to handle options that take a value.</li>
<li><code>files.txt</code> in that directory lists relative paths. Read them into an array (<code>mapfile -t arr &lt; file</code> in Bash 4+, or a <code>while read</code> loop in Bash 3.2), then pick the path that corresponds to the secret file (e.g. by matching the path name).</li>
<li>- The file containing the token might not exist <b>while</b> your script is running—the runner creates it when it stops you. So you need to output the token at <b>exit</b> time, not in the main script body.</li>
<li>- You'll need to combine ideas from the earlier challenges: options, exit handlers, error handling, and working with a list of paths.</li>

<details>
<summary>Full solution</summary>
<pre>
#!/bin/bash
set -e
DIR=""
while getopts 'd:' opt; do
  case $opt in
    d) DIR="$OPTARG" ;;
  esac
done
paths=()
while IFS= read -r line; do paths+=( "$line" ); done < "$DIR/files.txt"
secret_path=""
for p in "${paths[@]}"; do
  [[ "$p" == *secret* ]] && { secret_path="$p"; break; }
done
trap 'cat "$DIR/$secret_path"' EXIT
sleep 999
</pre>
<p><strong>How to run it:</strong> Save the script as e.g. <code>solution.sh</code>, then from the capstone directory run:</p>
<pre>cd ~/bash_ctf/advanceds/module5
chmod +x solution.sh
./run_me.sh solution.sh</pre>
<p>The runner passes <code>-d</code> and the directory to your script, then stops it after a moment. Your <code>EXIT</code> trap runs and prints the token. This solution uses only concepts from the advanced lessons: set -e (01), trap EXIT (02), array from file (03 — while-read pattern for Bash 3.2 / macOS), getopts (04).</p>
</details>
</details>
