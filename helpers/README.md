# Helpers

Sinatra has things called "helpers" avaiable to help do useful tasks which should be shared across your application to help, well... do things. Such as check if a user is authenticated, redirecting users, and pretty much anything you want. You can share this loging within the context of these custom sinatra helpers which you can write.

## Boilerplate Example

Within the context of this boilerplate code, we have the application helper which provides one generic method to check if a user is authetnicated ( logged in ), by checking if a user has been set in the session, otherwise returning false. Some pages, or some page behavior, may be impacted whether or not a user is actually authenticated to be able to do so.

```ruby
# if user has logged in
is_authenticated? 
# => true

# if user has not logged in
is_authenticated?
# => false
```
