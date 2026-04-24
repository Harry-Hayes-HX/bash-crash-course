# Lesson 4: getopts and Option Parsing

**Concepts:** **getopts** (parse short options), **OPTARG** and **OPTIND**, **option with value** (-f file).

---

Many scripts and commands use **options** (also called flags or switches): things like **-v** for “verbose” or **-f myfile.txt** for “use this file.” **getopts** is Bash’s built-in way to read those options from the command line so your script can react to **-a**, **-b**, **-f filename**, and so on, without parsing **$1**, **$2** by hand.

---

## Concept 1: getopts basics

**getopts** reads **short options**—single letters with a hyphen, like **-a** or **-b**—from the arguments the user passed to your script. You give it a string that lists which options you accept, and it steps through the arguments one option at a time. Each time, it tells you which option letter it found so you can handle it in a **case** statement.

**Syntax:**

```bash
getopts optstring name [args]
```

Here’s what the pieces mean:

- **optstring** — A string of the option letters your script allows. For example **"ab"** means you accept **-a** and **-b**. If an option should take a value (e.g. **-f filename**), put a **colon** after that letter: **"f:"** means “-f is followed by an argument.” So **"ab:c"** means: -a (no value), -b (takes a value), -c (no value).
- **name** — The name of a variable where getopts will put the **option letter** it just read (e.g. **opt**). In your **case** block you check **$opt** to see if it was **a**, **b**, **c**, etc.
- **OPTARG** — When an option takes a value (because of the colon in the optstring), the **value** the user gave (e.g. the filename after **-f**) is stored in this variable. So after getopts sees **-f myfile.txt**, **OPTARG** is **myfile.txt**.
- **OPTIND** — A number that points to the **next** argument getopts will look at. After the **while getopts** loop finishes, the “rest” of the command line (e.g. filenames that aren’t options) starts at that position. You use **shift $((OPTIND - 1))** so that **$1** becomes the first non-option argument and you can process the remaining arguments normally.

You almost always use getopts inside a **while** loop so it keeps reading options until there are no more. If the user passes an option that isn’t in the optstring, getopts sets **name** to **?**; in your **case** you can handle **\?** (escaped so the shell doesn’t treat it as a pattern) to print “invalid option” and exit.

**Small examples:**
*Example 1:*
```bash
while getopts "ab" opt; do
  case $opt in
    a) echo "Got -a" ;;
    b) echo "Got -b" ;;
    \?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
  esac
done
```

*Example call (save as e.g. **opts_ab.sh** and run):*
```bash
./opts_ab.sh -a -b
or
./opts_ab.sh -ab
```
*Example output:*
```
Got -a
Got -b
```

*Invalid option:*
```bash
./opts_ab.sh -x
```
*Output (to stderr):* 
`Invalid option: -x` 
then script exits 1.


*Example 2:*
```bash
# Shift so $1 is first non-option argument
while getopts "v" opt; do
  case $opt in
    v) VERBOSE=1 ;;
  esac
done
shift $((OPTIND - 1))
echo "First non-option arg: ${1:-none}"
```

*Example call:*
```bash
./script.sh -v hello
```
*Example output:*
```
First non-option arg: hello
```

*Without -v, the first arg is still the first non-option:*
```bash
./script.sh world
```
*Output:* `First non-option arg: world`  
*With no args:* `First non-option arg: none`

---

## Concept 2: Options with values

Put a **colon** after the letter in the optstring to mean “this option takes an argument”. The argument is in **OPTARG**.

**Small examples:**

*Example 1:*
```bash
while getopts "f:o:" opt; do
  case $opt in
    f) INFILE="$OPTARG" ;;
    o) OUTFILE="$OPTARG" ;;
    \?) echo "Usage: $0 -f <infile> -o <outfile>" >&2; exit 1 ;;
  esac
done
shift $((OPTIND - 1))
echo "Input: ${INFILE:-stdin}, Output: ${OUTFILE:-stdout}"
```

*Example call:*
```bash
./script.sh -f in.txt -o out.txt
```
*Example output:*
```
Input: in.txt, Output: out.txt
```

*Without -f or -o (defaults):*
```bash
./script.sh
```
*Output:* `Input: stdin, Output: stdout`

*Wrong option:*
```bash
./script.sh -x
```
*Output (stderr):* `Usage: ./script.sh -f <infile> -o <outfile>` then exit 1.

*Example 2:*
```bash
# Optional value: -d or -d /path
while getopts "d::" opt; do
  case $opt in
    d) DIR="${OPTARG:-.}" ;;   # default to . if no value
  esac
done
echo "DIR is: $DIR"
```

*Example calls:*
```bash
./script.sh -d
```
*Output:* `DIR is: .` (no value after -d, so OPTARG is empty; **${OPTARG:-.}** uses current dir).

```bash
./script.sh -d /tmp
```
*Output:* `DIR is: /tmp`

---

## Concept 3: Combining with validation

**getopts** only reads what the user typed; it doesn’t check that they gave you everything you need. So after the **while getopts** loop and the **shift**, you should **validate**: make sure any required options were actually provided (e.g. “did they pass **-f**?”) and that the values make sense (e.g. “does that path exist? Is it a file?”). If something is missing or wrong, print a clear message (e.g. “Missing -f” or “Not a file: …”) and **exit 1** so the script fails instead of doing something unexpected.

Typical checks: use ** [ -n "${FILE:-}" ]** to test “was FILE set?” and ** [ -f "$FILE" ]** to test “is it a regular file?”. If a check fails, print the error and exit. That way your script is safe and the user gets a helpful message instead of a cryptic error later.

**Small examples:**

```bash
while getopts "f:h" opt; do
  case $opt in
    f) FILE="$OPTARG" ;;
    h) echo "Usage: $0 -f <file>"; exit 0 ;;
    \?) exit 1 ;;
  esac
done
shift $((OPTIND - 1))
[ -n "${FILE:-}" ] || { echo "Missing -f"; exit 1; }
[ -f "$FILE" ] || { echo "Not a file: $FILE"; exit 1; }
echo "Processing $FILE"
```

*Example call (when **notes.txt** exists):*
```bash
./script.sh -f notes.txt
```
*Example output:*
```
Processing notes.txt
```

*Missing -f:*
```bash
./script.sh
```
*Output:* `Missing -f` then exit 1.

*File doesn’t exist:*
```bash
./script.sh -f nonexistent.txt
```
*Output:* `Not a file: nonexistent.txt` then exit 1.

*Help:*
```bash
./script.sh -h
```
*Output:* `Usage: ./script.sh -f <file>` then exit 0.

---

## Recap: 1, 2, 3

- **1:** Use **while getopts "optstring" opt; do case $opt in ... esac; done** to parse short options. **optstring** lists allowed letters; a colon after a letter means “this option takes a value.” Use **shift $((OPTIND - 1))** after the loop so **$1** is the first non-option argument.
- **2:** For options that take a value (e.g. **-f file**), put a colon in the optstring (**"f:"**) and read the value from **$OPTARG**. Use **::** for an optional value.
- **3:** After parsing, validate: check that required options were set and that values (e.g. file paths) exist and are correct. If not, print a clear error and exit 1.

---

## Example 1 — Focus on 1 (getopts)

Write a script that accepts **-v** (verbose) and **-q** (quiet). Loop with getopts; set a variable **VERBOSE=1** for -v and **QUIET=1** for -q. After the loop, shift and print "Remaining args: $*".

*Example call and output:*
```bash
./my_script.sh -v -q file1.txt file2.txt
```
*Output:* `Remaining args: file1.txt file2.txt`

---

## Example 2 — Focus on 2 (option with value)

Write a script that accepts **-f file** and **-n number**. Parse with getopts **"f:n:"**, store in **FILE** and **NUM**. After the loop, print "File: $FILE, Num: $NUM".

*Example call and output:*
```bash
./my_script.sh -f report.txt -n 42
```
*Output:* `File: report.txt, Num: 42`

---

## Example 3 — Focus on 3 (validation)

Extend the -f script: after getopts and shift, require that **-f** was given and that **$FILE** is a regular file. If not, print usage and exit 1. Otherwise run **wc -l "$FILE"**.

*Example call and output (when **data.txt** exists and has 10 lines):*
```bash
./my_script.sh -f data.txt
```
*Output:* `10 data.txt` (from **wc -l**)

*Missing -f:*
```bash
./my_script.sh
```
*Output:* usage message, then exit 1.

---

## Combined example — 1 + 2 + 3

Write a script **process.sh** that:

1. Accepts **-i inputfile** (required) and **-o outputfile** (optional; default: stdout).
2. Uses getopts **"i:o:"** and validates that **-i** was provided and that the input file exists.
3. If **-o** is set, run **cat "$INPUT" > "$OUTPUT"**; else **cat "$INPUT"**.

*Example call and output (input file has one line "hello"):*
```bash
./process.sh -i notes.txt
```
*Output:* `hello` (contents of notes.txt to stdout)

```bash
./process.sh -i notes.txt -o copy.txt
```
*Output:* (nothing to stdout; **copy.txt** now contains the same as **notes.txt**)

*Missing -i:*
```bash
./process.sh
```
*Output:* error message, exit 1.

You’ve used getopts, options with values, and validation. Next: [05 - Capstone](05-capstone.md).
