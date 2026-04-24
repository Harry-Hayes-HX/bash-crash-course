# Challenge 1: Gatekeeper

**Lesson:** 1 – Conditionals  
**Skills:** Running a script with an argument; conditionals

---

## Mission

A script in `~/bash_ctf/intermediates/module1/` only prints the access token when it receives the **correct single argument**. You can find a list of arguments you can use in `args.txt`. Find the correct argument (the script’s message will hint when you’re wrong) and run the script so it outputs the access token.

---

## Steps

1. Go to the challenge folder:
   ```
   cd ~/bash_ctf/intermediates/module1
   ```
2. List files and read the available arguments:
   ```
   ls
   cat args.txt
   ```
3. Run the script with no argument or with a wrong argument (e.g. `./check.sh wrong`). Notice the “Access denied” behaviour.
4. Figure out the right argument (check the args.txt file) and run:
   ```bash
   ./check.sh allow
   ```
   (or the correct word if different)
5. The script should print the access token.
6. Please do not cat the `code.txt` file (i cant actually stop you from doing this, but its better for your learning if you dont)
7. Once you have found the correct argument, you can take a look at check.sh (`cat check.sh`) to see how i used conditionals to make this work

---

## Success

You’ve completed the challenge when you see the access token. Submit that exact string in the input for Intermediate 01 - Gatekeeper.

---

## Hints

<details>
<summary>Click to show hints</summary>
<ul>
<li>- The script uses a conditional: <b>if</b> the first argument equals a certain string, it cats the code file.</li>
<li>- Try short words that mean “permit” or “allow”.</li>
</ul>
</details>
