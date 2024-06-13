---
Date: 2024-06-01T00:00:00.000Z
Topic: Form Uploading
Attendance: 'Ben, Mae, Justin, Chris, Ken'
Status: incomplete
---
# Form uploading

## Context

We are having `CustomForm` built right now by Bryan to allow the shelters to build forms inside their application themselves for their users to complete. However, in the interim and as an alternative, we decided it would be good to support allowing users to upload CSV files.

The shelter could provide a google forms link which the adopter could complete while providing their email on the form to associate with the application. The staff could upload a CSV from the form to get the form parsed into our database.

## Decision

- Support both importing forms and `CustomForm`
- Allow staff to provide Google form link to adopters
- Import csv into app for parsing

## Consequences

