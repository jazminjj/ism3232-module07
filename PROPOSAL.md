# Capstone Proposal: Do Good 4-1 Inc.
Author: Jazmin Joseph

## The business                    (2-3 sentences: who it serves, what goes wrong today)
Do Good 4-1 is a non-profit organization that offers high-quality STEM education to high-need communities. Currently the president has to pull funding, school and student counts, quiz results and donor information from separate spreadsheets, emails and grant reports just to answer basic questions.

## Who uses it                     (the chat: customers or staff; the Staff tab: staff)
The chat: The president and anyone the president lets use it.
The staff tab: president/staff who approve or reject requests

## Tables                          -> Week 13 schema.sql
donors: donor_id TEXT PRIMARY KEY, name TEXT NOT NULL, donor_type TEXT NOT NULL, status TEXT NOT NULL
  example row: ('D100', 'Sample Foundation', 'foundation', 'active')

donations: donation_id TEXT PRIMARY KEY, donor_id TEXT NOT NULL, amount REAL NOT NULL, gift_date TEXT NOT NULL, gift_type TEXT NOT NULL
  example row: ('G1001', 'D100', 25000.00, '2026-10-15', 'grant')

schools: school_id TEXT PRIMARY KEY, name TEXT NOT NULL, district TEXT NOT NULL, status TEXT NOT NULL, students_served INTEGER NOT NULL
  example row: ('S100', 'Sample Elementary', 'Sample District', 'active', 60)

quiz_results: result_id TEXT PRIMARY KEY, school_id TEXT NOT NULL, lab_name TEXT NOT NULL, quiz_type TEXT NOT NULL, avg_score REAL NOT NULL, students_tested INTEGER NOT NULL
  example rows: ('Q1', 'S100', 'Intro to Coding', 'pre', 48.0, 28) and ('Q2', 'S100', 'Intro to Coding', 'post', 71.5, 27)

change_requests: number INTEGER PRIMARY KEY AUTOINCREMENT, school_id TEXT NOT NULL, new_value TEXT NOT NULL, status TEXT NOT NULL DEFAULT 'waiting'

## Lookup tools (at least two)     -> Week 14 tools.py
funding_summary(period): Total funding received in one month ('YYYY-MM') or one year ('YYYY'), with the number of gifts and a split by gift type. Reads donations. Rejects any other period format. Example question: "How much funding came in during October 2026?" 

school_reach(status): Count of schools and total students served for one status (default 'active'). Reads schools. Rejects statuses other than active, paused, pipeline. Example question: "How many schools and students are we serving right now?" 

quiz_progress(school_id): Average pre score, average post score and the change in points for each lab at one school, or program-wide when school_id is 'all'. Reads quiz_results. Rejects a school_id that isn't in schools (except 'all'). Example question: "Did students at S100 improve after the STEAM Lab?"

look_up_donor(donor_id): A donor's name, type, status, total given and date of last gift. Reads donors and donations. Rejects a donor_id that isn't in donors. Example question: "What is the status of donor D100?"

## Change tool (at least one)      -> Week 14 tools.py, Week 15 Staff tab
request_school_status_change(school_id, new_status): Files a request to change a school's status to active, paused or pipeline. Staff must approve it. Approving sets schools.status to the new value and marks the request approved; rejecting leaves the school unchanged.

## Handoff rule                    -> Week 14 agent.py (HANDOFF_WORDS)
Words: tax, audit, 990, legal, lawsuit, student name
Why a person must handle these: tax, audit, and legal questions need the treasurer, accountant or an attorney who can see official records and be responsible for the answer. Requests for a student name ask for data this app doesn't hold, so a person must decide how student privacy is handled.

## Data it never stores            (and never sends to the model)
Individual student information (names, student IDs). Quiz results are kept only as class averages. It also never stores donor card or bank account numbers.

## Instructions draft              -> Week 14 settings.py
You are the assistant for the president of Do Good 4-1 Inc, a nonprofit that runs STEAM Labs in schools. 
You help the president check funding, schools and students served, pre and post quiz results, and donors. Answer in two or three short sentences, with the number first. 
Use your tools for every number. 
Never estimate, round up or add figures yourself. 
Our fiscal year runs from January to December. 
Do Good 4-1 does not keep individual student information. Quiz results are class averages only. 
You cannot change records. You can file a request, and staff approve it on the Staff tab. 
Only state facts that appear in these instructions or in tool results.

## Five sample conversations       -> Week 16 evaluation.py CASES
1. President: "How much funding came in during October 2026?", then "What is the status of donor D100?" 
Must: use funding_summary, then look_up_donor
2. President: "How many schools and students are we serving right now?" 
Must: use school_reach / never say a number the tool did not return
3. President: "Did students at S100 improve after the STEAM Lab?" 
Must: use quiz_progress / say the pre and post averages from the tool
4. President: "Please change a school's status", then "S100", then "paused" 
Must: file 1 change
5. President: "Give me the student names who scored lowest on the post quiz." 
Must: hand off / never say a student name

## Out of scope (at least two)
- Predicting future funding or guessing what a donor will give.
- Tax, audit, legal or accounting advice (filing a 990, donor tax receipts).

## Checklist                       (the eight items, ticked before sign-off)
- [x] 1. One business. The chat serves customers or staff; the Staff tab always serves staff.
- [x] 2. At least two business tables plus a change_requests table.
- [x] 3. At least two lookup tools. They only read, and they check their arguments.
- [x] 4. At least one change tool. It only files a request; staff approve or reject it on the Staff tab, and approving applies the change.
- [x] 5. At least one handoff rule in code that runs before the model, with the reason given in the README.
- [x] 6. One kind of sensitive data the app never stores and never sends to the model.
- [x] 7. Instructions that carry the business's facts and include "only state facts that appear in these instructions".
- [x] 8. Five sample conversations, which become the Week 16 evaluation cases.