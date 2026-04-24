# Challenge 4: Locked Door

**Module:** 4 – Permissions and users  
**Skills:** `ls -l`, `whoami`, `chmod`, `chown`

---

## Mission

In `~/bash_ctf/basics/module4/` there are one or more files; the one that contains the **access code** is locked and may be owned by root (permission denied if you try to read it). Use `whoami`, `ls -l`, then `chown` (with `sudo` if you don’t own the file) and `chmod` so you can read the correct file. The line you need starts with `ACCESS_CODE:`.

---

## Steps

1. Go to the module:
   ```
   cd ~/bash_ctf/basics/module4
   ```
2. List files and check permissions (`ls -l`). Note which file has the access code and who owns it (`whoami`).
3. If you don’t own that file, take ownership of it using chown. Then change permissions with `chmod` so you can read it, and read the file.

---

## Success

You’ve completed the challenge when you can read the full flag. Submit that exact string in the input for Basics: 04 - Permissions

---

## Hints

<details>
<summary>Click to show hints</summary>
<ul>
<li><code>chmod 400</code> means: 4 (read) for owner, 0 for group, 0 for others. So only you can read.</li>
<li><code>chmod u+r file</code> adds <b>r</b>ead permissions for the <b>u</b>ser (owner).</li>
<li>If the file is owned by root, take ownership first: <code>sudo chown $(whoami) secret.txt</code> (use the real filename). Then <code>chmod 400</code> and <code>cat</code> it.</li>
</ul>

</details>