---
Date: 2024-06-01T00:00:00.000Z
Topic: Person Model
Attendance: 'Ben, Mae, Justin, Chris, Ken'
Status: incomplete
---
# Person Model

## Context

The current application is using `AdopterFosterAccount` and `StaffAccount`, but they are not actually holding useful information and mostly require developers to forward through it to reach information they actually want from the current user, like the information stored in the `AdopterFosterProfile`.

We are abandoning the two account models as well as `AdopterFosterProfile` and in their place using a `Person` model. We are also removing `OrganizationProfile` and merging that into `Organization`.

`User` will be solely for authentication and authorization purposes and adopters.

`Person` will hold the person's information such as name, contact information, and whatever else may be necessary for the shelters.

One benefit we discussed that this infrastructure would support would be staff being able to create a `Person` without necessarily that `Person` signing up for an account. This way, they could create matches with pets with people offline but still record it in app.

## Decision

- Remove `AdopterFosterAccount`, `StaffAccount`, `AdopterFosterProfile`, and `OrganizationProfile`
- Add `Person` model and table

## Consequences

