================================================================================
  FINAL CHALLENGE — Unbreakable Script
================================================================================

USER STORY
----------

We have a list of files that need to be processed in one go (e.g. copied
somewhere or read and reported on). The list lives in a config file so it can
change without touching the script. We need one script that does this job
reliably—whether the list is correct, the paths exist, or someone interrupts
it—so we can run it from automation or by hand and trust the result.

As an engineer, I need a single Bash script so that:

  • I can run it with options (e.g. a config file and a destination directory).
  • It reads a list of file paths from the config file (one path per line).
  • It processes each path in that list (e.g. copy the file to the destination,
    or print its contents—the exact action is up to you, but it must use the
    list from the config).
  • It handles errors: missing config, missing files, invalid paths, command
    failures. It must not crash in a way that leaves me guessing what went
    wrong.
  • If I interrupt it (Ctrl+C) or something goes wrong, it exits cleanly—no
    half-finished state, no ugly stack traces.
  • It validates its arguments and fails with a clear message when used
    incorrectly (e.g. wrong or missing options).

So that I can rely on it when things go wrong or when it’s run in unexpected
ways.


When run correctly in perfect conditions
----------------------------------------

When the script is given valid options, a config file that exists and is
readable, and a list of paths that all exist and are valid for the operation
(e.g. copy or print), it should process every path in the config, perform the
intended action (e.g. copy each file to the destination, or output its
contents), exit with code 0, and report success or a clear summary. No errors,
no partial state—the run completes as intended.


HOW I WILL RUN IT
-----------------

I will run your script in a controlled environment. You can assume:

  • I choose the working directory and the arguments (options and values) I
    pass. I may use relative or absolute paths; the config file and
    destination (or equivalent) will match whatever interface you define.
  • I control the environment: what exists on the filesystem, permissions,
    and whether things like config files or target directories are present
    or valid. I may run the script more than once per “round,” with
    different invocations or states.
  • I will not tell you in advance the exact invocations, paths, or
    environment details. You design for a class of conditions, not for one
    specific run.


CONDITIONS (BY GROUP)
---------------------

Conditions are organised into groups. For each run (or round), I pick one
group and run your script under that group’s conditions. You will not be
told which group you are getting, and the group can change from run to run.
So your script must be robust across different kinds of stress: bad or
missing inputs, filesystem and permission issues, signals, resource limits,
weird or empty data, and similar. Plan for variety, not for one scenario.


HIDDEN CHALLENGE
----------------

One scenario is not described anywhere in this document. I will run it
without warning. Your script must still behave correctly (or fail cleanly).
Defend against the unknown by making your script generally robust—clear
validation, safe error handling, and clean exit under any condition.


THE GAME
--------

1. You write one script that fulfils the user story above.
2. You send that script to me.
3. I run it under the conditions above (one group per run; group unknown to
   you; possibly including the hidden challenge).
4. If I break it, that’s one “rewrite”: you fix the script and send it back.
   We repeat until your script survives everything I throw at it (or we stop).


WINNING
-------

  • Whoever gets to an “unbreakable” script the fastest wins.
  • Ties are broken by fewest rewrites (i.e. fewest times I successfully
    broke the script and you had to edit the code).

Use everything you’ve learned in this course—error handling, trap, set -e,
getopts, arrays, validation, clean exit—to make your script as robust as
possible. Good luck.

================================================================================
