# Image

Image is a simple image storage and processing service.

It is built using Ruby on Rails with a minimal API-only stack.

It uses Active Storage to handle image storage. Images are stored
locally when uploaded at the moment. Before going live we would need to
configure Active Storage to use a cloud storage provider such as Amazon
S3.

Image storage and processing is currently done by the Web server itself.
In order to scale we would need to offload this work to a background
process using Sidekiq, delayed job or similar.
