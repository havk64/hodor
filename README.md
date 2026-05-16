# Hodor — Hold the Door

A progressive HTTP security challenge solved in multiple programming languages, built as a project at [Holberton School](https://www.holbertonschool.com).

The premise: submit 1024 votes to a remote server. The catch: each level adds a new layer of protection you must reverse-engineer and bypass — cookies, header inspection, CAPTCHAs, and IP-based rate limiting.

I had so much fun solving those challenges!

Thank you for that [Julien Barbier](https://github.com/jbarbier)!

---

## The Challenge

Each level introduces a new obstacle on top of the previous ones:

| Level | Protection Added | Technique Required |
|-------|------------------|--------------------|
| 0 | None — raw POST endpoint | Basic HTTP POST request |
| 1 | Session cookie required | Cookie extraction and injection |
| 2 | User-Agent and Referer checks | HTTP header spoofing |
| 3 | Image CAPTCHA | OCR with [Tesseract](https://github.com/tesseract-ocr/tesseract) |
| 4 | IP-based rate limiting | Identity rotation via the [Tor network](https://www.torproject.org) |

By the final level, each vote requires: rotating your exit IP through Tor, extracting a fresh session cookie, solving the CAPTCHA, and submitting the request — all automated.

---

## Languages

Each level was solved in as many languages as possible, exploring how different ecosystems handle HTTP, concurrency, and system calls.

| Language | L0 | L1 | L2 | L3 | L4 |
|----------|----|----|----|----|-----|
| Shell (curl) | ✓ | ✓ | ✓ | ✓ | ✓ |
| Python | ✓ | ✓ | ✓ | ✓ | ✓ |
| Perl | ✓ | ✓ | ✓ | ✓ | ✓ |
| Lua | ✓ | ✓ | ✓ | ✓ | ✓ |
| R | ✓ | ✓ | ✓ | ✓ | ✓ |
| Ruby | ✓ | ✓ | ✓ | ✓ | |
| Go | ✓ | ✓ | ✓ | | |
| Node.js | ✓ | ✓ | ✓ | | |
| Scala | ✓ | ✓ | ✓ | ✓ | |
| Swift | ✓ | ✓ | ✓ | ✓ | |
| C | ✓ | ✓ | ✓ | | |
| PHP | ✓ | ✓ | ✓ | | |
| Erlang | ✓ | ✓ | ✓ | | |
| Jupyter Notebook | ✓ | | | | |
| Java | ✓ | | | | |
| Haskell | ✓ | | | | |
| OCaml | ✓ | | | | |
| Lisp | ✓ | | | | |
| Clojure | ✓ | | | | |
| Rust | ✓ | | | | |

---

## Highlights

**Level 3 — CAPTCHA bypass** was the most interesting to crack. The server generates a fresh image CAPTCHA for each session. The solution:
1. Open an HTTP session and fetch the CAPTCHA image
2. Pipe it to Tesseract OCR to extract the text
3. Submit the decoded string alongside the session cookie in the POST body

This was implemented in both Python (using `requests` + a Tesseract wrapper) and Bash (using `curl` with background jobs and `awk` for cookie parsing).

**Level 4 — Tor IP rotation** required integrating with the Tor control port via [Stem](https://stem.torproject.org) to signal a new circuit (`NEWNYM`) between each vote, ensuring the server never saw the same IP twice.

---

## Structure

```
level_0/    # Basic POST — 20 languages (Wow, I was sick!)
level_1/    # + Cookie auth
level_2/    # + Header inspection
level_3/    # + CAPTCHA (OCR)
level_4/    # + IP rate limiting (Tor)
```

Each level folder contains one sub-directory per language.

---

## Dependencies (Level 3)

- [Tesseract OCR](https://github.com/tesseract-ocr/tesseract): `brew install tesseract` (macOS) or `apt install tesseract-ocr`

## Dependencies (Level 4)

- [Tor](https://www.torproject.org): running locally on port 9050 (SOCKS) and 9051 (control)
- Python: `stem`, `requesocks`

---

*Original challenge by Julien Barbier. Solved by Alexandro de Oliveira in 2016 at Holberton School, San Francisco, CA.*
