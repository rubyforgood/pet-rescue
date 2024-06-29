---
Date: 2024-06-01T00:00:00.000Z
Topic: Checklists
Attendance: 'Ben, Mae, Justin, Chris, Ken'
Status: incomplete
---
# Checklists

## Context

Currently, the application has `Task` and `DefaultPetTask`. The `DefaultPetTask` allow for the organizations to create a template of tasks that will be created for every pet that is added to the system.

We decided a cleaner naming convention would be to namespace multiple models in `Checklist`. We will have:

- `Checklist::Template`
- `Checklist::TemplateItem`
- `Checklist::Assignment`

`Template` will serve as a replacement for `DefaultPetTask`, and it can have the ability to serve beyond just pets but any kind of default list of tasks.

`TemplateItem` will replace `Task`. This is something that requires action to be completed by staff.

`Assignment` will link the `TemplateItem` with a `Person`. The `Assignment` will cache the `TemplateItem` instead of soft linking to it. That way, if the `TemplateItem` is modified, the `Assignment` is unaffected.

These names will also be easier for developers to grok quickly.

## Decision

- Restructure `Task` as `Checklist::TemplateItem`
- Restructure `DefaultPetTask` as `Checklist::Template`

## Consequences

