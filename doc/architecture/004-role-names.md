---
Date: 2024-06-01
Topic: Role Names
Attendance: Ben, Mae, Justin, Chris, Ken
Status: accepted
---

# Role Names

## Context

The current roles are:

- adopter
- fosterer
- staff
- staff admin

These names reflect how the users see each other more than the developers. It is not clear to a developer what the general permissions for a `User` with the role of staff should be able to do.

It would be better to use typical role naming conventions on the developer side of things and have different names for any front-end display.

Roles:

- admin
- super admin
- sys-admin

We also discussed that it would be better not to refer to those working with the shelters as "staff" as that term typically implies pay, which may not always be the case. One term suggested instead was "team".

## Decision

- Rename `:staff` role as `:admin`
- Rename `:admin` role as `:super_admin`
- Add `:sys_admin` role

## Consequences

We will have to make sure to make this refactoring across all spots touched. I think this will affect `authorizable.rb`, the policy classes and tests, the factories, and the locations in controller actions that add roles to users.
