# Event Manager

This is my solution to the project on the "Project: Event Manager" lesson for the Ruby Programming track.

## Description

Here is a brief description of this project:

A friend of mine runs a non-profit org around political activism. A number of people have registered for an upcoming event. 
She has asked for my help in engaging these future attendees. And that's why I've coded this project.

The program is able to read from the "database" (a CSV file) the names and zip codes for each of the people that has registered for the event. Bad and missing zip codes are handked properly. With the zip codes, we use Google Civic Information's API to retrieve data relative to the political representatives of each person's home city, on the National Level (for both the Senate and the House).

With this information, a customized letter is generated for each person, thanking their registration and telling them to reach 
out their representatives.

Provision is also made to obtain their phone numbers (and clean them if necessary), and to know in which hour of the day and day of the week there was the greatest number of registrations.

From The Odin Project's [curriculum](https://www.theodinproject.com/courses/ruby-programming/lessons/event-manager)
