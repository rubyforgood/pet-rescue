# Person Model

## Context

`User` will be solely for authentication and authorization purposes and adopters.

`Person` will hold the person's information such as name, contact information, and whatever else may be necessary for the shelters.

`User` belongs to `Person`. The direction of this relationship will allow for potentially support `Person` records that have no `User` which could help in situations such as offline pet shelter events.
