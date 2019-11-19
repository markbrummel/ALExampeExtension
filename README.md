# ALExampeExtension

These files are part of my workshop materials and updated from the book Design Patterns for Dynamics NAV.

They are free to download without any waranties or support. Use at your own risk.

(c) Mark Brummel

Exercise 1- Singleton Setup Table

1.	Create a new table with ID 50000 and name Example Setup using the Singleton Pattern
2.	Define field 1 Primary Key as Code 10
3.	Define field 2 Example Enabled Boolean
4.	Create Card Page 50000 Example Setup
a.	InsertAllowed = No
b.	DeleteAllowed = No
c.	OnOpenPage:
RESET;
IF NOT GET THEN BEGIN
  INIT;
  INSERT;
END;
5.	Add the creation to Codeunit 2 and see if you can make this upgradable.
6.	Add a field to the user setup table Example Enabled (50000/Boolean)
7.	Create an Interface Codeunit returning the correct value based on Multi Level Setup

Exercise 2- Master Data Table
1.	Create a new table with ID 50010 and name Example Person
2.	Define field 1 No. as Code 20
3.	Define field 2 Name as Text 50
4.	Define field 3 Search Name as Code 50
5.	Define field 4 Name 2 as Text 50
6.	Add C/AL Code in OnValidate of Name field
IF ("Search Name" = UPPERCASE(xRec.Name)) OR ("Search Name" = '') THEN
  "Search Name" := Name;
7.	Create cardpage 50010 Example Person Card based on table 50010
8.	Create listpage 50011 Example Person List based on table 50010
a.	Editable = FALSE
b.	CardPageId = 50010
9.	Repeat the exercise for table 50020 Example Product
10.	Implement No. Series
11.	Implement Address Integration (In the appropriate Master Data)
12.	Add blocked entity field
13.	Redesign Address Integration to use an argument table
14.	Implement a product sales price table per person using the rules table

Exercise 3  - Journal Template Batch Line
1.	Import Exercise3.fob and study the objects
2.	Add the code to move the fields to the entry table in the Journal Post Line Codeunit
3.	Remove the Boat Anchor in Codeunit 50003 Ex. Jnl-Post line
4.	Create a new flowfield on the ExamplePerson table to study the automated entry creation by flowfields
5.	Create a new Entry table and enable the Autoincrement property. Run the table and see how it generates the unique key
6.	Add another field to the same table and enable Autoincrement. Study the results
7.	What other options are there to create a unique ID?

Exercise 4 – Document
1.	Import Exercise4.fob
2.	Have a look at the document tables and how they are designed using the document pattern.
3.	Refactor the Post Codeunit as a method of the table
4.	Implement UI Separation
5.	Create the Post Action
6.	Import Exercise4a.fob
7.	Create a Hook function for the ExamplePostHook Codeunit, use OnAfterTestNear
8.	Create an event for the OnAfterTestNear function
9.	Import Exercise4b.fob
10.	Study the Query on Page object
11.	Refactor this on a report
