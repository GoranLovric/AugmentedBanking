# Skill: E-Mail Sending with mailR in R

## Description

You can send emails using the R package `mailR`. Use the following template for the R code.
The SMTP server and port are fixed. The fields "Recipient", "Subject" and "Body" are provided by the user.
Use this skill whenever the user asks about email sending, dispatching email, or similar requests.

**SMTP Server:** test.host.com
**Port:** 25

**R Code Template:**

```r
library(mailR)

send.mail(
  from = "<SENDER> <SENDER EMAIL>",
  to = "<RECIPIENT>",
  subject = "<SUBJECT>",
  body = "<BODY>",
  smtp = list(
    host.name = "test.host.com",
    port = 25,
    user.name = "your_email_here",
    passwd = "your_password_here",
    ssl = TRUE
  ),
  html = TRUE,
  authenticate = TRUE,
  send = TRUE,
  attach.files = c("<ATTACHMENT>")
)

## Rules

- Replace `<SENDER>`, `<SENDER EMAIL>`, `<RECIPIENT>`, `<SUBJECT>`, `<ATTACHMENT>`, and `<BODY>` with the details from the user prompt.
- Always generate exactly one `send.mail(...)` block.
- Use `send = TRUE` only once. Do not execute a second or duplicate `send.mail()` call.
- Respond only with valid R code. No explanations, no comments, no duplicate code blocks.
- When choosing an attachment, verify that the file exists and is not empty.

The sender information can be taken from the signatures in this document.

## Attachments

- The attachment can only be sent if it is located in the local folder.
- For documents as attachments, always search all subfolders and files in this path: \TESTPATH\Case_Study
- Always list all files from all subfolders in that path first.
- If the exact filename is not provided in the prompt, use the file with the most similar name.
- Attachments must not be empty. If `grep()` cannot find a file, split the prompt term into parts or search by word fragments.
- The SMTP server and port must always be used as specified above.

## Design

- Use Arial for the entire email, including the signature.
- Specify separately that each part of the email is formatted in Arial.
- Precede each part of the email with `<p style="margin: 0;">` to enforce single line spacing.
- Use proper blank lines as is customary in emails.
- Use the exact signature code from this skillset `email.md`.
- If you are unsure who the recipient is, check the `DL.db` database first and ask for clarification if needed.
- Compose the email and send it in HTML format.
- Use only the signature of the sender as stated below



John Johnson:

\&#x20;
<br>
<br>
<p style='margin: 0;'>Kind regards, </p>

<br>

<br>
<p style='margin: 0;'><b>John Johnson</b></p>
<p style='margin: 0;'>Manager</p>
<p style='margin: 0;'>___________________________________________________________</p>
<br>
<p style='margin: 0;'>Company XYZ</p>
<p style='margin: 0;'> <PLACEHOLDER ADDRESS> </p>
<p style='margin: 0;'>T <PLACEHOLDER PHONE></p>
<p style='margin: 0;'>E <PLACEHOLDER EMAIL></p>

<p style='margin: 0;'>www.companyXYZ.com </p>

<p style="margin: 0; font-size:9pt;"><PLACEHOLDER LEGAL TEXT></p>




The output must always be a single R code block that can send the email using the `mailR` package.



