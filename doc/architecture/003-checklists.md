# Checklists

## Context

Anything under the `Checklist` namespace is for creating pet tasks, but they could be used for other tasks in the future.

We would like this infrastructure:

- `Checklist::TaskTemplate`: For grouping related tasks
- `Checklist::TaskItem`: The tasks
- `Checklist::TaskAssignment`: The link between a task and a Pet or anything that is assignable.

As of 2024-07-21, we have `DefaultPetTask` which serves as both the `Template` and the `TemplateItem`. `Task` currently servers as the `Assignment`. The `DefaultPetTask` records serve as the "items". They are scoped under `Organizations`,so an organization only has one template currently. There is a PR to add a species column to `DefaultPetTask` which would allow for more templates within an organization, but that would be limited to one per species.

However, with the checklist infrastructure using `Checklist::Template`, users would be able to specify and create as many templates as they would want. So if they wanted a template for rescued dogs being added that are elderly versus puppies, they could create those separate templates.
