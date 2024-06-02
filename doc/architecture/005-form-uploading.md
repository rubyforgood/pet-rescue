---
Date: 2024-06-01
Topic: Form Uploading
Attendance: Ben, Mae, Justin, Chris, Ken
Status: accepted
---

# Form uploading

## Context

We are having `CustomForm` built right now by Bryan to allow the shelters to build forms inside their application themselves for their users to complete. However, in the interim and as an alternative, we decided it would be good to support allowing users to upload CSV files.

The shelter could provide a google forms link which the adopter could copy, complete, download, and then submit. This would require the shelter to process the information themselves. When `CustomForm` is completed, some of that processing could be handled by the application instead.

We discussed importing the csv into a jsonb column in the database.

## Decision

- Support both importing forms and `CustomForm`
- Allow staff to provide Google form link to adopters
- Allow adopters to submit a CSV file to the application
- Import csv into jsonb column

## Consequences
