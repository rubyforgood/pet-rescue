---
Date: 2024-06-01
Topic: Person Model
Attendance: Ben, Mae, Justin, Chris, Ken
Status: accepted
---

# Person Model

## Context

The current application is using `AdopterFosterAccount` and `StaffAccount`, but they are not actually holding useful information and mostly require developers to forward through it to reach information they actually want from the current user, like the information stored in the `AdopterFosterProfile`.

We are abandoning the two account models as well as `AdopterFosterProfile` and `OrganizationProfile` and in their place using a `Person` model.

`User` will be solely for authentication and authorization purposes and adopters will not necessarily require to have an associated `User` record.

`Person` will hold the person's information such as name, contact information, and whatever else may be necessary for the shelters.

One of the ideas spawning this change was the idea that adopters will not necessarily need accounts and would be able to apply for pets via tokens provided by links.

## Decision

- Remove `AdopterFosterAccount`, `StaffAccount`, `AdopterFosterProfile`, and `OrganizationProfile`
- Add `Person` model and table

## Consequences

- Adopters will not log in with a log in button.
