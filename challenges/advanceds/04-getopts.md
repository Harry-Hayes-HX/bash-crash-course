# Challenge 4: Options

**Lesson:** 4 – getopts and options  
**Skills:** `getopts`, option with value (-f file)

---

## Mission

**run_me.sh** in `~/bash_ctf/advanceds/getopts/` will run **your script** with **`-f ./code.txt`** (or the full path to `code.txt`) as its argument. You must **write a script** that:

- Uses **getopts** to parse the **-f** option (option that takes an argument).
- When **`-f`** is seen, stores the argument (e.g. in a variable) and later **`cats`** that file.
- `Exits 0` after printing the file contents.

---

## Steps

1. `cd ~/bash_ctf/advanceds/getopts`
2. Run: `./run_me.sh ./your_script.sh`

---

## Success

You’ve completed the challenge when your script prints the code. Submit that exact string in the input for Advanced: 04 - GetOpts.

## Hints
<details>
<summary>Click to show hints</summary>
<ul>
<li>- The runner passes <code>-f</code> followed by a file path. You need to read that option and its argument in your script.</li>
<li>- <code>getopts</code> is the built-in way to parse options. Use a <code>while getopts 'f:' opt</code> loop; the colon after <code>f</code> means <code>-f</code> takes an
argument.</li>
<li>- The argument for <code>-f</code> is available in <code>$OPTARG</code>. Store it in a variable, then <code>cat</code> that file. Your script must exit 0 for the runner to confirm success.</li>

<details>
<summary>Full solution</summary>
<pre>
#!/bin/bash
while getopts 'f:' opt; do
  case $opt in
    f) FILE="$OPTARG" ;;
  esac
done
cat "$FILE"
</pre>
</details>
</ul>
</details>