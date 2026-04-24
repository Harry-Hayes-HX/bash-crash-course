# Module 4: Permissions and Users

**Concepts:** **Reading `ls -l`** (what those letters and symbols mean), **who you are** (whoami, id), **chmod** (changing file permissions), **chown** (changing file ownership).

---

## Concept 1: Understanding `ls -l` (permissions in plain English)

When users report “Permission denied,” the cause is usually file or folder permissions. **ls -l** shows them.

**Small example:**

<img src="/static/images/lessons/basics/04-permissions-and-users/ls-l.png" alt="Screenshot: Running ls -l" style="max-width: 780px; height: auto;" />

You’ll see lines like:

```
-rw-r--r--  1 jsmith  staff  1234 Jan 15 10:00 notes.txt
drwxr-xr-x  2 jsmith  staff   128 Jan 15 09:00 Documents
```

**How to read it:**

| Part | Meaning |
|------|--------|
| **1st character** | `-` = file, `d` = directory |
| **Next 9 characters** | Permissions in three groups of three: **owner**, **group**, **others** |
| **r** | **R**ead (view/open) |
| **w** | **W**rite (change/delete) |
| **x** | E**x**ecute (run as program, or enter directory) |
| **-** | That permission is **not** granted |

So:

- **-rw-r--r--** = file; owner can read+write, group and others can only read.
- **drwxr-xr-x** = directory; owner can read/write/enter, group and others can read and enter but not create/delete there.

When someone gets “Permission denied,” they’re usually in the “others” group and the file doesn’t have `r` (or `x` for a directory) for others.

---

## Concept 2: Who am I? (`whoami` and `id`)

Before changing permissions, know **which user** you are and **which groups** you belong to.

| Command | What it does |
|---------|----------------|
| **whoami** | Your username |
| **id** | Your user id, group id, and group names |

**Small examples:**

<img src="/static/images/lessons/basics/04-permissions-and-users/whoami.png" alt="Screenshot: Running whoami" style="max-width: 780px; height: auto;" />


<img src="/static/images/lessons/basics/04-permissions-and-users/id.png" alt="Screenshot: Running id" style="max-width: 780px; height: auto;" />

*You might see something like `uid=501(jsmith) gid=20(staff) groups=20(staff),...`.*

When a user says “it says permission denied,” ask them to run `whoami` (if they have terminal access) so you know which account they’re running the command as.

---

## Concept 3: Changing permissions with `chmod`

**chmod** = **ch**ange **mod**e (permissions). Use only on files/folders you own (or as admin). Don’t relax permissions on sensitive system files.

Common pattern: **u** = user (owner), **g** = group, **o** = others; **+** = add, **-** = remove; **r**, **w**, **x** as above.

| Command | What it does |
|---------|----------------|
| **chmod u+x** *file* | Give (+) the **u**ser (owner) e**x**ecute permission |
| **chmod g+r** *file* | Give (+) the **g**roup **r**ead permission |
| **chmod o-w** *file* | Remove (-) **w**rite from **o**thers (more secure) |
| **chmod 644** *file* | Numeric form: 6=rw for owner, 4=r for group and others (common for files) |
| **chmod 755** *dir* | 7=rwx for owner, 5=rx for group and others (common for directories) |

**Small examples** (use a file you created, e.g. in `~/bash-practice`):

<img src="/static/images/lessons/basics/04-permissions-and-users/chmod-example-1.png" alt="Screenshot: chmod example 1" style="max-width: 780px; height: auto;" />


<img src="/static/images/lessons/basics/04-permissions-and-users/chmod-example-2.png" alt="Screenshot: chmod example 2" style="max-width: 780px; height: auto;" />

*Others lose write (if they had it).*


<img src="/static/images/lessons/basics/04-permissions-and-users/chmod-example-3.png" alt="Screenshot: chmod example 3" style="max-width: 780px; height: auto;" />

*Back to a typical “readable by all, writable only by me” file.*

---

## Concept 4: Changing ownership with `chown`

**chown** = **ch**ange **own**er. Use it when a file is owned by the wrong user and you have permission to fix that (e.g. you are an admin). You can change the owner, the group, or both.

| Command | What it does |
|---------|----------------|
| **chown** *user* *file* | Set the file's owner to *user* |
| **chown** *user*:*group* *file* | Set both owner and group |
| **sudo chown** *user* *file* | Change owner when the file is owned by root or another user (needs admin rights) |

**Typical case:** A file is owned by `root` and you need to read it. You can't change permissions on a file you don't own, so you first take ownership, then fix permissions:

```bash
sudo chown $(whoami) secret.txt    # take ownership (whoami = your username)
chmod 400 secret.txt               # then add read for yourself
cat secret.txt
```

Only use `chown` when you're allowed to (e.g. your own system or with sudo). Don't change ownership of system files unless you know what you're doing.

---

## Recap:

- **1:** `ls -l` — first column = type + permissions (r/w/x for owner, group, others).
- **2:** `whoami` and `id` — which user and groups; helps with “who is getting denied?”
- **3:** `chmod` — change permissions (u/g/o + r/w/x or numeric); use carefully.
- **4:** `chown` — change owner (and optionally group); use `sudo chown` when the file isn't yours.

---

## Example 1 — Focus on reading permissions

1. Run `ls -l ~`.
2. Pick one **file** and one **directory**. For each, say out loud: “Is it a file or directory? Can the owner read/write/execute? Group? Others?”
3. Find a file that has `rw-r--r--` and one that might have `rwx` for the owner (e.g. a script).

---

## Example 2 — Focus on who am I?

1. Run `whoami` and note the username.
2. Run `id` and find your primary group and any other groups.
3. Imagine a user says “I get permission denied on /shared/report.” You’d ask them to run `whoami` and check permissions on `/shared/report` with `ls -l` (if you have access) to see if that user or their group has r/x.

---

## Example 3 — Focus on `chmod`

1. In `~/bash-practice`: `touch chmod-demo.txt` then `ls -l chmod-demo.txt`.
2. Remove read from others: `chmod o-r chmod-demo.txt` then `ls -l chmod-demo.txt`.
3. Restore read for others: `chmod o+r chmod-demo.txt` then `ls -l chmod-demo.txt`.
4. Set “standard” file permissions: `chmod 644 chmod-demo.txt` then `ls -l chmod-demo.txt`.

---

## Example 4 — Focus on `chown`

1. Run `whoami` and note your username.
2. If you have a file owned by root (e.g. from a challenge): `ls -l` the file and note owner is `root`.
3. Take ownership: `sudo chown $(whoami) filename` (replace `filename` with the real path).
4. Run `ls -l` again and confirm you are now the owner; then use `chmod` if needed and read the file.

---

## Combined example:

**Goal:** Confirm your user, create a file, read its permissions, then adjust them and verify.

1. **Who am I?** Run `whoami` and `id`.
2. **Create a file:** `cd ~/bash-practice` then `touch secure-notes.txt` and `ls -l secure-notes.txt`. Note the permission string (e.g. `-rw-r--r--`).
3. **Tighten permissions:** Remove write for group and others so only you can change it:  
   `chmod go-w secure-notes.txt`  
   Run `ls -l secure-notes.txt` again and confirm the `w` is gone for group and others.
4. **Restore:** `chmod 644 secure-notes.txt` and `ls -l secure-notes.txt` to see the usual state.

You’ve used reading permissions, checking identity, changing permissions, and (in Example 4) changing ownership with `chown`. Next: variables and simple scripts (Module 5).

You’ve completed Permissions and Users, now move onto: [05 Variables and Scripts ](05-variables-and-scripts.md).

---