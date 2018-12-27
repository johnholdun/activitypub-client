# ActivityPub Client

A human-friendly client for any ActivityPub server

## TODO

- Authentication/authorization flow (actor URI and access token; OAuth? IndieAuth?)
  - To begin with, perhaps just two fields for URI and token that are saved in a cookie or localStorage?
- Composer that POSTs to your outbox and offers helpful AS2.0 prefills
- Timeline view that parses your inbox and splits its items into notifications and notes
  - HTML renderer, object fetcher, maybe some kind of feed splitting logic? Customizable per user or per installation? This could get ~complicated~
- Composer shortcuts as reaction links on inbox items?
- RSS view?
  - Could this just be another mode of the timeline renderer?
